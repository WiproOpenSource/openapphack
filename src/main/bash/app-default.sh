#!/bin/bash



function __apptool_default {
	CANDIDATE="$1"
	__apptool_check_candidate_present "${CANDIDATE}" || return 1
	__apptool_determine_version "$2" || return 1

	if [ ! -d "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}" ]; then
		echo ""
		echo "Stop! ${CANDIDATE} ${VERSION} is not installed."
		return 1
	fi

	__apptool_link_candidate_version "${CANDIDATE}" "${VERSION}"

	echo ""
	echo "Default ${CANDIDATE} version set to ${VERSION}"
}
