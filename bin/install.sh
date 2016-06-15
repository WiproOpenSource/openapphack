#!/bin/bash

# Global variables
OPENAPPHACK_SERVICE="http://wiproopensourcepractice.github.io/openapphack/"
OPENAPPHACK_VERSION="0.0.1"
#OPENAPPHACK_DIR="${0%/*/*}"
OPENAPPHACK_DIR="${HOME}/.ove"

# Local variables
openapphack_bin_folder="${OPENAPPHACK_DIR}/bin"
openapphack_tmp_folder="${OPENAPPHACK_DIR}/tmp"
openapphack_stage_folder="${openapphack_tmp_folder}/stage"
openapphack_etc_folder="${OPENAPPHACK_DIR}/etc"
openapphack_var_folder="${OPENAPPHACK_DIR}/var"
openapphack_config_file="${openapphack_etc_folder}/config"
openapphack_bash_profile="${HOME}/.bash_profile"
openapphack_profile="${HOME}/.profile"
openapphack_bashrc="${HOME}/.bashrc"
openapphack_zshrc="${HOME}/.zshrc"
openapphack_platform=$(uname)

openapphack_init_snippet=$( cat << EOF
#THIS MUST BE AT THE END OF THE FILE FOR OPENAPPHACK CLI TO WORK!!!
[[ -s "${OPENAPPHACK_DIR}/bin/oah-init.sh" ]] && source "${OPENAPPHACK_DIR}/bin/oah-init.sh"
EOF
)


echo '                                                                     '
echo 'Thanks for using OPENAPPHACK                                         '
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
	echo "    $ oah selfupdate"
	echo ""
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for git..."
if [ -z $(which git) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install git on your system using your favourite package manager."
	echo ""
	echo " OPENAPPHACK uses git for crucial interactions with it's github repos."
	echo ""
	echo " Restart after installing git."
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
	echo " OPENAPPHACK uses curl for crucial interactions with it's github pages."
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


echo "Looking for vagrant..."
if [ -z $(which vagrant) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install vagrant on your system using your favourite package manager."
	echo ""
	echo " OPENAPPHACK uses vagrant extensively."
	echo ""
	echo " Restart after installing vagrant."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

echo "Looking for ansible..."
if [ -z $(which ansible) ]; then
	echo "Not found."
	echo ""
	echo "======================================================================================================"
	echo " Please install ansible on your system using your favourite package manager."
	echo ""
	echo " OPENAPPHACK uses ansible extensively."
	echo ""
	echo " Restart after installing ansible."
	echo "======================================================================================================"
	echo ""
	exit 0
fi

# if hostmachine then vagrant or Docker must be installed
# if client machine disable vagrant up commands
# TODO Set the Global var for OAH_HOST and OAH_CLIENT
ansible-galaxy install -r ../data/requirements.yml
ansible-playbook ../data/setup.yml
