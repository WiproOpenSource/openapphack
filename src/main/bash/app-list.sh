#!/bin/bash


function __apptool_build_version_csv {
	CANDIDATE="$1"
	CSV=""
	for version in $(find "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}" -maxdepth 1 -mindepth 1 -exec basename '{}' \; | sort); do
		if [[ "${version}" != 'current' ]]; then
			CSV="${version},${CSV}"
		fi
	done
	CSV=${CSV%?}
}

function __apptool_offline_list {
	echo "------------------------------------------------------------"
	echo "Offline Mode: only showing installed ${CANDIDATE} versions"
	echo "------------------------------------------------------------"
	echo "                                                            "

	openapphack_versions=($(echo ${CSV//,/ }))
	for (( i=0 ; i <= ${#openapphack_versions} ; i++ )); do
		if [[ -n "${openapphack_versions[${i}]}" ]]; then
			if [[ "${openapphack_versions[${i}]}" == "${CURRENT}" ]]; then
				echo -e " > ${openapphack_versions[${i}]}"
			else
				echo -e " * ${openapphack_versions[${i}]}"
			fi
		fi
	done

	if [[ -z "${openapphack_versions[@]}" ]]; then
		echo "   None installed!"
	fi

	echo "------------------------------------------------------------"
	echo "* - installed                                               "
	echo "> - currently in use                                        "
	echo "------------------------------------------------------------"

	unset CSV openapphack_versions
}

function __apptool_list {
	CANDIDATE="$1"
	__apptool_check_candidate_present "${CANDIDATE}" || return 1
	__apptool_build_version_csv "${CANDIDATE}"
	__apptool_determine_current_version "${CANDIDATE}"

	if [[ "${OPENAPPHACK_AVAILABLE}" == "false" ]]; then
		__apptool_offline_list
	else
		FRAGMENT=$(curl -s "${OPENAPPHACK_SERVICE}/candidates/${CANDIDATE}/list?platform=${OPENAPPHACK_PLATFORM}&current=${CURRENT}&installed=${CSV}")
		echo "${FRAGMENT}"
		unset FRAGMENT
	fi
}
