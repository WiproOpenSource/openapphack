#!/bin/bash

function openapphack_echo_debug {
	if [[ "$OPENAPPHACK_DEBUG_MODE" == 'true' ]]; then
		echo "$1"
	fi
}

echo ""
echo "Updating openapphack..."

OPENAPPHACK_VERSION="0.0.1"
if [ -z "${OPENAPPHACK_DIR}" ]; then
#	OPENAPPHACK_DIR="${0%/*/*}"
	OPENAPPHACK_DIR="~/.oah"
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

openapphack_platform=$(uname)
openapphack_bin_folder="${OPENAPPHACK_DIR}/bin"
openapphack_stage_folder="${OPENAPPHACK_DIR}/tmp/stage"

openapphack_echo_debug "git pull..."
git pull

# prepare candidates
OPENAPPHACK_CANDIDATES_CSV=$(curl -s "${OPENAPPHACK_SERVICE}/candidates")
echo "$OPENAPPHACK_CANDIDATES_CSV" > "${OPENAPPHACK_DIR}/var/candidates"

# drop version token
echo "$OPENAPPHACK_VERSION" > "${OPENAPPHACK_DIR}/var/version"

# create candidate directories
# convert csv to array
OLD_IFS="$IFS"
IFS=","
OPENAPPHACK_CANDIDATES=(${OPENAPPHACK_CANDIDATES_CSV})
IFS="$OLD_IFS"

for candidate in "${OPENAPPHACK_CANDIDATES[@]}"; do
    if [[ -n "$candidate" ]]; then
        mkdir -p "${OPENAPPHACK_DIR}/${candidate}"
        openapphack_echo_debug "Created for ${candidate}: ${OPENAPPHACK_DIR}/${candidate}"
    fi
done

if [[ -f "${OPENAPPHACK_DIR}/ext/config" ]]; then
	openapphack_echo_debug "Removing config from ext folder..."
	rm -v "${OPENAPPHACK_DIR}/ext/config"
fi

openapphack_echo_debug "Prime the config file..."
openapphack_config_file="${OPENAPPHACK_DIR}/etc/config"
touch "${openapphack_config_file}"
if [[ -z $(cat ${openapphack_config_file} | grep 'openapphack_auto_answer') ]]; then
	echo "openapphack_auto_answer=false" >> "${openapphack_config_file}"
fi

if [[ -z $(cat ${openapphack_config_file} | grep 'openapphack_auto_selfupdate') ]]; then
	echo "openapphack_auto_selfupdate=false" >> "${openapphack_config_file}"
fi

if [[ -z $(cat ${openapphack_config_file} | grep 'openapphack_insecure_ssl') ]]; then
	echo "openapphack_insecure_ssl=false" >> "${openapphack_config_file}"
fi

openapphack_echo_debug "Download new scripts to: ${openapphack_tmp_zip}"
curl -s "${OPENAPPHACK_SERVICE}/platform/${openapphack_platform}/oah_scripts.zip" > "${openapphack_tmp_zip}"

openapphack_echo_debug "Extract script archive..."
openapphack_echo_debug "Unziping scripts to: ${openapphack_stage_folder}"
if [[ "${cygwin}" == 'true' ]]; then
	openapphack_echo_debug "Cygwin detected - normalizing paths for unzip..."
	unzip -qo $(cygpath -w "${openapphack_tmp_zip}") -d $(cygpath -w "${openapphack_stage_folder}")
else
	unzip -qo "${openapphack_tmp_zip}" -d "${openapphack_stage_folder}"
fi

openapphack_echo_debug "Moving oah-init file to bin folder..."
mv "${openapphack_stage_folder}/oah-init.sh" "${openapphack_bin_folder}"

openapphack_echo_debug "Move remaining module scripts to src folder: ${openapphack_src_folder}"
mv "${openapphack_stage_folder}"/oah-* "${openapphack_src_folder}"

openapphack_echo_debug "Clean up staging folder..."
rm -rf "${openapphack_stage_folder}"

echo ""
echo ""
echo "Successfully upgraded OPENAPPHACK."
echo ""
echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${OPENAPPHACK_DIR}/bin/oah-init.sh\""
echo ""
echo ""
