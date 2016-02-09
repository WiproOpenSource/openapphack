#!/bin/bash

#
# common internal function definitions
#

function __apptool_check_candidate_present {
	if [ -z "$1" ]; then
		echo -e "\nNo candidate provided."
		__apptool_help
		return 1
	fi
}

function __apptool_check_version_present {
	if [ -z "$1" ]; then
		echo -e "\nNo candidate version provided."
		__apptool_help
		return 1
	fi
}

function __apptool_determine_version {

	if [[ "${OPENAPPHACK_AVAILABLE}" == "false" && -n "$1" && -d "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/$1" ]]; then
		VERSION="$1"

	elif [[ "${OPENAPPHACK_AVAILABLE}" == "false" && -z "$1" && -L "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current" ]]; then

		VERSION=$(readlink "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current" | sed "s!${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/!!g")

	elif [[ "${OPENAPPHACK_AVAILABLE}" == "false" && -n "$1" ]]; then
		echo "Stop! ${CANDIDATE} ${1} is not available in offline mode."
		return 1

	elif [[ "${OPENAPPHACK_AVAILABLE}" == "false" && -z "$1" ]]; then
        echo "${OFFLINE_MESSAGE}"
        return 1

	elif [[ "${OPENAPPHACK_AVAILABLE}" == "true" && -z "$1" ]]; then
		VERSION_VALID='valid'
		VERSION=$(curl -s "${OPENAPPHACK_SERVICE}/candidates/${CANDIDATE}/default")

	else
		VERSION_VALID=$(curl -s "${OPENAPPHACK_SERVICE}/candidates/${CANDIDATE}/$1")
		if [[ "${VERSION_VALID}" == 'valid' || ( "${VERSION_VALID}" == 'invalid' && -n "$2" ) ]]; then
			VERSION="$1"

		elif [[ "${VERSION_VALID}" == 'invalid' && -h "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/$1" ]]; then
			VERSION="$1"

		elif [[ "${VERSION_VALID}" == 'invalid' && -d "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/$1" ]]; then
			VERSION="$1"

		else
			echo ""
			echo "Stop! $1 is not a valid ${CANDIDATE} version."
			return 1
		fi
	fi
}

function __apptool_default_environment_variables {

	if [ ! "$OPENAPPHACK_FORCE_OFFLINE" ]; then
		OPENAPPHACK_FORCE_OFFLINE="false"
	fi

	if [ ! "$OPENAPPHACK_ONLINE" ]; then
		OPENAPPHACK_ONLINE="true"
	fi

	if [[ "${OPENAPPHACK_ONLINE}" == "false" || "${OPENAPPHACK_FORCE_OFFLINE}" == "true" ]]; then
		OPENAPPHACK_AVAILABLE="false"
	else
	  	OPENAPPHACK_AVAILABLE="true"
	fi
}

function __apptool_link_candidate_version {
	CANDIDATE="$1"
	VERSION="$2"

	# Change the 'current' symlink for the candidate, hence affecting all shells.
	if [ -L "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current" ]; then
		unlink "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current"
	fi
	ln -s "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}" "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current"
}
