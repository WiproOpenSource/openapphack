#!/bin/bash

function openapphack_echo_debug {
	if [[ "$OPENAPPHACK_DEBUG_MODE" == 'true' ]]; then
		echo "$1"
	fi
}

echo ""
echo "Updating openapphack..."

OPENAPPHACK_VERSION="@OPENAPPHACK_VERSION@"
if [ -z "${OPENAPPHACK_DIR}" ]; then
	OPENAPPHACK_DIR="$HOME/.openapphack"
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
openapphack_tmp_zip="${OPENAPPHACK_DIR}/tmp/res-${OPENAPPHACK_VERSION}.zip"
openapphack_stage_folder="${OPENAPPHACK_DIR}/tmp/stage"
openapphack_src_folder="${OPENAPPHACK_DIR}/src"

openapphack_echo_debug "Purge existing scripts..."
rm -rf "${openapphack_bin_folder}"
rm -rf "${openapphack_src_folder}"

openapphack_echo_debug "Refresh directory structure..."
mkdir -p "${OPENAPPHACK_DIR}/bin"
mkdir -p "${OPENAPPHACK_DIR}/ext"
mkdir -p "${OPENAPPHACK_DIR}/etc"
mkdir -p "${OPENAPPHACK_DIR}/src"
mkdir -p "${OPENAPPHACK_DIR}/var"
mkdir -p "${OPENAPPHACK_DIR}/tmp"
mkdir -p "${OPENAPPHACK_DIR}/vm"
mkdir -p "${OPENAPPHACK_DIR}/.vms"

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
        mkdir -p "${OPENAPPHACK_DIR}/.vms/${candidate}"
        openapphack_echo_debug "Created for ${candidate}: ${OPENAPPHACK_DIR}/.vms/${candidate}"
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
curl -s "${OPENAPPHACK_SERVICE}/res/platform/${openapphack_platform}/purpose/selfupdate/openapphack-cli-scripts.zip" > "${openapphack_tmp_zip}"

openapphack_echo_debug "Extract script archive..."
openapphack_echo_debug "Unziping scripts to: ${openapphack_stage_folder}"
if [[ "${cygwin}" == 'true' ]]; then
	openapphack_echo_debug "Cygwin detected - normalizing paths for unzip..."
	unzip -qo $(cygpath -w "${openapphack_tmp_zip}") -d $(cygpath -w "${openapphack_stage_folder}")
else
	unzip -qo "${openapphack_tmp_zip}" -d "${openapphack_stage_folder}"
fi

openapphack_echo_debug "Moving app-init file to bin folder..."
mv "${openapphack_stage_folder}/app-init.sh" "${openapphack_bin_folder}"

openapphack_echo_debug "Move remaining module scripts to src folder: ${openapphack_src_folder}"
mv "${openapphack_stage_folder}"/app-* "${openapphack_src_folder}"

openapphack_echo_debug "Clean up staging folder..."
rm -rf "${openapphack_stage_folder}"

echo ""
echo ""
echo "Successfully upgraded OpenAppHack CLI."
echo ""
echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${OPENAPPHACK_DIR}/bin/app-init.sh\""
echo ""
echo ""
