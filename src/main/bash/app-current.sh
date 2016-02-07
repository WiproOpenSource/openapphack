#!/bin/bash

function __apptool_determine_current_version {
	CANDIDATE="$1"
	if [[ "${solaris}" == true ]]; then
		CURRENT=$(echo $PATH | gsed -r "s|${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/([^/]+)/bin|!!\1!!|1" | gsed -r "s|^.*!!(.+)!!.*$|\1|g")
	elif [[ "${darwin}" == true ]]; then
		CURRENT=$(echo $PATH | sed -E "s|${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/([^/]+)/bin|!!\1!!|1" | sed -E "s|^.*!!(.+)!!.*$|\1|g")
	else
		CURRENT=$(echo $PATH | sed -r "s|${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/([^/]+)/bin|!!\1!!|1" | sed -r "s|^.*!!(.+)!!.*$|\1|g")
	fi

	if [[ "${CURRENT}" == "current" ]]; then
	    unset CURRENT
	fi

	if [[ -z ${CURRENT} ]]; then
		CURRENT=$(readlink "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current" | sed "s!${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/!!g")
	fi
}

function __apptool_current {
	if [ -n "$1" ]; then
		CANDIDATE="$1"
		__apptool_determine_current_version "${CANDIDATE}"
		if [ -n "${CURRENT}" ]; then
			echo "Using ${CANDIDATE} version ${CURRENT}"
		else
			echo "Not using any version of ${CANDIDATE}"
		fi
	else
		INSTALLED_COUNT=0
		for (( i=0; i <= ${#OPENAPPHACK_CANDIDATES}; i++ )); do
			# Eliminate empty entries due to incompatibility
			if [[ -n ${OPENAPPHACK_CANDIDATES[${i}]} ]]; then
				__apptool_determine_current_version "${OPENAPPHACK_CANDIDATES[${i}]}"
				if [ -n "${CURRENT}" ]; then
					if [ ${INSTALLED_COUNT} -eq 0 ]; then
						echo 'Using:'
					fi
					echo "${OPENAPPHACK_CANDIDATES[${i}]}: ${CURRENT}"
					(( INSTALLED_COUNT += 1 ))
				fi
			fi
		done
		if [ ${INSTALLED_COUNT} -eq 0 ]; then
			echo 'No candidates are in use'
		fi
	fi
}
