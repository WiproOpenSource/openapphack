#!/bin/bash


export OPENAPPHACK_VERSION="@OPENAPPHACK_VERSION@"
export OPENAPPHACK_PLATFORM=$(uname)

if [ -z "${OPENAPPHACK_SERVICE}" ]; then
    export OPENAPPHACK_SERVICE="@OPENAPPHACK_SERVICE@"
fi

if [ -z "${OPENAPPHACK_BROADCAST_SERVICE}" ]; then
    export OPENAPPHACK_BROADCAST_SERVICE="@OPENAPPHACK_BROADCAST_SERVICE@"
fi

if [ -z "${OPENAPPHACK_BROKER_SERVICE}" ]; then
    export OPENAPPHACK_BROKER_SERVICE="@OPENAPPHACK_BROKER_SERVICE@"
fi

if [ -z "${OPENAPPHACK_DIR}" ]; then
	export OPENAPPHACK_DIR="$HOME/.openapphack"
fi

# force zsh to behave well
if [[ -n "$ZSH_VERSION" ]]; then
	setopt shwordsplit
fi

# OS specific support (must be 'true' or 'false').
cygwin=false;
darwin=false;
solaris=false;
freebsd=false;
case "$(uname)" in
    CYGWIN*)
        cygwin=true
        ;;
    Darwin*)
        darwin=true
        ;;
    SunOS*)
        solaris=true
        ;;
    FreeBSD*)
        freebsd=true
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if ${cygwin} ; then
    [ -n "${JAVACMD}" ] && JAVACMD=$(cygpath --unix "${JAVACMD}")
    [ -n "${JAVA_HOME}" ] && JAVA_HOME=$(cygpath --unix "${JAVA_HOME}")
    [ -n "${CP}" ] && CP=$(cygpath --path --unix "${CP}")
fi


OFFLINE_BROADCAST=$( cat << EOF
==== BROADCAST =============================================

OFFLINE MODE ENABLED! Some functionality is now disabled.

============================================================
EOF
)

ONLINE_BROADCAST=$( cat << EOF
==== BROADCAST =============================================

ONLINE MODE RE-ENABLED! All functionality now restored.

============================================================
EOF
)

OFFLINE_MESSAGE="This command is not available in offline mode."

# fabricate list of candidates
if [[ -f "${OPENAPPHACK_DIR}/var/candidates" ]]; then
	OPENAPPHACK_CANDIDATES_CSV=$(cat "${OPENAPPHACK_DIR}/var/candidates")
else
	OPENAPPHACK_CANDIDATES_CSV=$(curl -s "${OPENAPPHACK_SERVICE}/candidates")
	echo "$OPENAPPHACK_CANDIDATES_CSV" > "${OPENAPPHACK_DIR}/var/candidates"
fi



# Set the candidate array
OLD_IFS="$IFS"
IFS=","
OPENAPPHACK_CANDIDATES=(${OPENAPPHACK_CANDIDATES_CSV})
IFS="$OLD_IFS"

# Source openapphack module scripts.
for f in $(find "${OPENAPPHACK_DIR}/src" -type f -name 'app-*' -exec basename {} \;); do
    source "${OPENAPPHACK_DIR}/src/${f}"
done

# Source extension files prefixed with 'app-' and found in the ext/ folder
# Use this if extensions are written with the functional approach and want
# to use functions in the main openapphack script.
for f in $(find "${OPENAPPHACK_DIR}/ext" -type f -name 'app-*' -exec basename {} \;); do
    source "${OPENAPPHACK_DIR}/ext/${f}"
done
unset f

# Attempt to set JAVA_HOME if it's not already set.
# if [ -z "${JAVA_HOME}" ] ; then
#     if ${darwin} ; then
#         [ -z "${JAVA_HOME}" -a -f "/usr/libexec/java_home" ] && export JAVA_HOME=$(/usr/libexec/java_home)
#         [ -z "${JAVA_HOME}" -a -d "/Library/Java/Home" ] && export JAVA_HOME="/Library/Java/Home"
#         [ -z "${JAVA_HOME}" -a -d "/System/Library/Frameworks/JavaVM.framework/Home" ] && export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
#     else
#         javaExecutable="$(which javac 2> /dev/null)"
#         [[ -z "${javaExecutable}" ]] && echo "OPENAPPHACK: JAVA_HOME not set and cannot find javac to deduce location, please set JAVA_HOME." && return
#
#         readLink="$(which readlink 2> /dev/null)"
#         [[ -z "${readLink}" ]] && echo "OPENAPPHACK: JAVA_HOME not set and readlink not available, please set JAVA_HOME." && return
#
#         javaExecutable="$(readlink -f "${javaExecutable}")"
#         javaHome="$(dirname "${javaExecutable}")"
#         javaHome=$(expr "${javaHome}" : '\(.*\)/bin')
#         JAVA_HOME="${javaHome}"
#         [[ -z "${JAVA_HOME}" ]] && echo "OPENAPPHACK: could not find java, please set JAVA_HOME" && return
#         export JAVA_HOME
#     fi
# fi

# Load the openapphack config if it exists.
if [ -f "${OPENAPPHACK_DIR}/etc/config" ]; then
	source "${OPENAPPHACK_DIR}/etc/config"
fi

# Create upgrade delay token if it doesn't exist
if [[ ! -f "${OPENAPPHACK_DIR}/var/delay_upgrade" ]]; then
	touch "${OPENAPPHACK_DIR}/var/delay_upgrade"
fi

# determine if up to date
OPENAPPHACK_VERSION_TOKEN="${OPENAPPHACK_DIR}/var/version"
if [[ -f "$OPENAPPHACK_VERSION_TOKEN" && -z "$(find "$OPENAPPHACK_VERSION_TOKEN" -mmin +$((60*24)))" ]]; then
    OPENAPPHACK_REMOTE_VERSION=$(cat "$OPENAPPHACK_VERSION_TOKEN")

else
    OPENAPPHACK_REMOTE_VERSION=$(curl -s "${OPENAPPHACK_SERVICE}/app/version" --connect-timeout 1 --max-time 1)
    openapphack_force_offline_on_proxy "$OPENAPPHACK_REMOTE_VERSION"
    if [[ -z "$OPENAPPHACK_REMOTE_VERSION" || "$OPENAPPHACK_FORCE_OFFLINE" == 'true' ]]; then
        OPENAPPHACK_REMOTE_VERSION="$OPENAPPHACK_VERSION"
    else
        echo ${OPENAPPHACK_REMOTE_VERSION} > "$OPENAPPHACK_VERSION_TOKEN"
    fi
fi

# initialise once only
if [[ "${OPENAPPHACK_INIT}" != "true" ]]; then
    # # Build _HOME environment variables and prefix them all to PATH
    #
    # # The candidates are assigned to an array for zsh compliance, a list of words is not iterable
    # # Arrays are the only way, but unfortunately zsh arrays are not backward compatible with bash
    # # In bash arrays are zero index based, in zsh they are 1 based(!)
    # for (( i=0; i <= ${#OPENAPPHACK_CANDIDATES}; i++ )); do
    #     # Eliminate empty entries due to incompatibility
    #     if [[ -n ${OPENAPPHACK_CANDIDATES[${i}]} ]]; then
    #         CANDIDATE_NAME="${OPENAPPHACK_CANDIDATES[${i}]}"
    #         CANDIDATE_HOME_VAR="$(echo ${CANDIDATE_NAME} | tr '[:lower:]' '[:upper:]')_HOME"
    #         CANDIDATE_DIR="${OPENAPPHACK_DIR}/.vms/${CANDIDATE_NAME}/current"
    #         export $(echo ${CANDIDATE_HOME_VAR})="$CANDIDATE_DIR"
    #         PATH="${CANDIDATE_DIR}/bin:${PATH}"
    #         unset CANDIDATE_HOME_VAR
    #         unset CANDIDATE_NAME
    #         unset CANDIDATE_DIR
    #     fi
    # done
    # unset i
    # export PATH

    export OPENAPPHACK_INIT="true"
fi
