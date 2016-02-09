#!/bin/bash

# Global variables
OPENAPPHACK_SERVICE="http://panickervinod.github.io/openapphack"
OPENAPPHACK_BROKER_SERVICE="http://panickervinod.github.io/openapphack/broadcast"
OPENAPPHACK_VERSION="0.0.1"
OPENAPPHACK_DIR="$HOME/.openapphack"

# Local variables
openapphack_bin_folder="${OPENAPPHACK_DIR}/bin"
openapphack_src_folder="${OPENAPPHACK_DIR}/src"
openapphack_tmp_folder="${OPENAPPHACK_DIR}/tmp"
openapphack_stage_folder="${openapphack_tmp_folder}/stage"
openapphack_zip_file="${openapphack_tmp_folder}/res-${OPENAPPHACK_VERSION}.zip"
openapphack_ext_folder="${OPENAPPHACK_DIR}/ext"
openapphack_etc_folder="${OPENAPPHACK_DIR}/etc"
openapphack_var_folder="${OPENAPPHACK_DIR}/var"
openapphack_vm_folder="${OPENAPPHACK_DIR}/vm"
openapphack_dotvms_folder="${OPENAPPHACK_DIR}/.vms"
openapphack_config_file="${openapphack_etc_folder}/config"
openapphack_bash_profile="${HOME}/.bash_profile"
openapphack_profile="${HOME}/.profile"
openapphack_bashrc="${HOME}/.bashrc"
openapphack_zshrc="${HOME}/.zshrc"
openapphack_platform=$(uname)

openapphack_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR OPENAPPHACK TO WORK!!!
[[ -s "${OPENAPPHACK_DIR}/bin/app-init.sh" ]] && source "${OPENAPPHACK_DIR}/bin/app-init.sh"
EOF
)

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

echo '                                                                     '
echo 'Thanks for using     OpenAppHack Cli                                 '
echo '                                                                     '
echo '                                                                     '
echo '                                       Will now attempt installing...'
echo '                                                                     '


# Sanity checks

echo "Looking for a previous installation of OPENAPPHACK..."
if [ -d "${OPENAPPHACK_DIR}" ]; then
	echo "OPENAPPHACK found."
	echo ""
	echo "======================================================================================================"
	echo " You already have OPENAPPHACK installed."
	echo " OPENAPPHACK was found at:"
	echo ""
	echo "    ${OPENAPPHACK_DIR}"
	echo ""
	echo " Please consider running the following if you need to upgrade."
	echo ""
	echo "    $ app selfupdate"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for git..."
if [ -z $(which git) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install git on your system using your favourite package manager."
	echo ""
	echo " Restart after installing git."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for vagrant..."
if [ -z $(which vagrant) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install vagrant on your system ."
	echo ""
	echo " OPENAPPHACK uses vagrant extensively."
	echo ""
	echo " Restart after installing vagrant."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for unzip..."
if [ -z $(which unzip) ]; then
	echo "Not found."
	echo "======================================================================================================"
	echo " Please install unzip on your system using your favourite package manager."
	echo ""
	echo " Restart after installing unzip."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for curl..."
if [ -z $(which curl) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install curl on your system using your favourite package manager."
	echo ""
	echo " OPENAPPHACK uses curl for crucial interactions with it's backend server."
	echo ""
	echo " Restart after installing curl."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for sed..."
if [ -z $(which sed) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install sed on your system using your favourite package manager."
	echo ""
	echo " OPENAPPHACK uses sed extensively."
	echo ""
	echo " Restart after installing sed."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

if [[ "${solaris}" == true ]]; then
	echo "Looking for gsed..."
	if [ -z $(which gsed) ]; then
		echo "Not found."
		echo ""
		echo "======================================================================================================"
		echo " Please install gsed on your solaris system."
		echo ""
		echo " OPENAPPHACK uses gsed extensively."
		echo ""
		echo " Restart after installing gsed."
		echo "======================================================================================================"
		echo ""
		exit 0
	fi
fi


echo "Installing openapphack scripts..."


# Create directory structure

echo "Create distribution directories..."
mkdir -p "${openapphack_bin_folder}"
mkdir -p "${openapphack_src_folder}"
mkdir -p "${openapphack_tmp_folder}"
mkdir -p "${openapphack_stage_folder}"
mkdir -p "${openapphack_ext_folder}"
mkdir -p "${openapphack_etc_folder}"
mkdir -p "${openapphack_var_folder}"
mkdir -p "${openapphack_vm_folder}"
mkdir -p "${openapphack_dotvms_folder}"

echo "Create candidate directories..."

OPENAPPHACK_CANDIDATES_CSV=$(curl -s "${OPENAPPHACK_SERVICE}/candidates")
echo "$OPENAPPHACK_CANDIDATES_CSV" > "${OPENAPPHACK_DIR}/var/candidates"

echo "$OPENAPPHACK_VERSION" > "${OPENAPPHACK_DIR}/var/version"

# convert csv to array
OLD_IFS="$IFS"
IFS=","
OPENAPPHACK_CANDIDATES=(${OPENAPPHACK_CANDIDATES_CSV})
IFS="$OLD_IFS"

for (( i=0; i <= ${#OPENAPPHACK_CANDIDATES}; i++ )); do
	# Eliminate empty entries due to incompatibility
	if [[ -n ${OPENAPPHACK_CANDIDATES[${i}]} ]]; then
		CANDIDATE_NAME="${OPENAPPHACK_CANDIDATES[${i}]}"
		mkdir -p "${OPENAPPHACK_DIR}/.vms/${CANDIDATE_NAME}"
		echo "Created for ${CANDIDATE_NAME}: ${OPENAPPHACK_DIR}/.vms/${CANDIDATE_NAME}"
		unset CANDIDATE_NAME
	fi
done

echo "Prime the config file..."
touch "${openapphack_config_file}"
echo "openapphack_auto_answer=false" >> "${openapphack_config_file}"
echo "openapphack_auto_selfupdate=false" >> "${openapphack_config_file}"
echo "openapphack_insecure_ssl=false" >> "${openapphack_config_file}"

echo "Download script archive..."
curl -s "${OPENAPPHACK_SERVICE}/res/platform/${openapphack_platform}/purpose/install/openapphack-cli-scripts.zip" > "${openapphack_zip_file}"

echo "Extract script archive..."
if [[ "${cygwin}" == 'true' ]]; then
	echo "Cygwin detected - normalizing paths for unzip..."
	openapphack_zip_file=$(cygpath -w "${openapphack_zip_file}")
	openapphack_stage_folder=$(cygpath -w "${openapphack_stage_folder}")
fi
unzip -qo "${openapphack_zip_file}" -d "${openapphack_stage_folder}"

echo "Install scripts..."
mv "${openapphack_stage_folder}/app-init.sh" "${openapphack_bin_folder}"
mv "${openapphack_stage_folder}"/app-* "${openapphack_src_folder}"

echo "Attempt update of bash profiles..."
if [ ! -f "${openapphack_bash_profile}" -a ! -f "${openapphack_profile}" ]; then
	echo "#!/bin/bash" > "${openapphack_bash_profile}"
	echo "${openapphack_init_snippet}" >> "${openapphack_bash_profile}"
	echo "Created and initialised ${openapphack_bash_profile}"
else
	if [ -f "${openapphack_bash_profile}" ]; then
		if [[ -z `grep 'app-init.sh' "${openapphack_bash_profile}"` ]]; then
			echo -e "\n${openapphack_init_snippet}" >> "${openapphack_bash_profile}"
			echo "Updated existing ${openapphack_bash_profile}"
		fi
	fi

	if [ -f "${openapphack_profile}" ]; then
		if [[ -z `grep 'app-init.sh' "${openapphack_profile}"` ]]; then
			echo -e "\n${openapphack_init_snippet}" >> "${openapphack_profile}"
			echo "Updated existing ${openapphack_profile}"
		fi
	fi
fi

if [ ! -f "${openapphack_bashrc}" ]; then
	echo "#!/bin/bash" > "${openapphack_bashrc}"
	echo "${openapphack_init_snippet}" >> "${openapphack_bashrc}"
	echo "Created and initialised ${openapphack_bashrc}"
else
	if [[ -z `grep 'app-init.sh' "${openapphack_bashrc}"` ]]; then
		echo -e "\n${openapphack_init_snippet}" >> "${openapphack_bashrc}"
		echo "Updated existing ${openapphack_bashrc}"
	fi
fi

echo "Attempt update of zsh profiles..."
if [ ! -f "${openapphack_zshrc}" ]; then
	echo "${openapphack_init_snippet}" >> "${openapphack_zshrc}"
	echo "Created and initialised ${openapphack_zshrc}"
else
	if [[ -z `grep 'app-init.sh' "${openapphack_zshrc}"` ]]; then
		echo -e "\n${openapphack_init_snippet}" >> "${openapphack_zshrc}"
		echo "Updated existing ${openapphack_zshrc}"
	fi
fi

echo -e "\n\n\nAll done!\n\n"

echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${OPENAPPHACK_DIR}/bin/app-init.sh\""
echo ""
echo "Then issue the following command:"
echo ""
echo "    app help"
echo ""
echo "Enjoy!!!"
