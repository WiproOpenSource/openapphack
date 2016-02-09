#!/bin/bash

function __apptool_download {
	CANDIDATE="$1"
	VERSION="${2:=master}"
	mkdir -p "${OPENAPPHACK_DIR}/archives"
	if [ ! -f "${OPENAPPHACK_DIR}/archives/${CANDIDATE}-${VERSION}.zip" ]; then
		echo ""
		echo "Downloading: ${CANDIDATE} ${VERSION}"
		echo ""
		DOWNLOAD_URL="${OPENAPPHACK_SERVICE}/download/${CANDIDATE}/${VERSION}/platform/${OPENAPPHACK_PLATFORM}/openapphackvm-${VERSION}.zip"
		ZIP_ARCHIVE="${OPENAPPHACK_DIR}/archives/${CANDIDATE}-${VERSION}.zip"
		if [[ "$openapphack_insecure_ssl" == "true" ]]; then
			curl -k -L "${DOWNLOAD_URL}" > "${ZIP_ARCHIVE}"
		else
			curl -L "${DOWNLOAD_URL}" > "${ZIP_ARCHIVE}"
		fi
		__apptool_validate_zip "${ZIP_ARCHIVE}" || return 1
	else
		echo ""
		echo "Found a previously downloaded ${CANDIDATE} ${VERSION} archive. Not downloading it again..."
		__apptool_validate_zip "${OPENAPPHACK_DIR}/archives/${CANDIDATE}-${VERSION}.zip" || return 1
	fi
	echo ""
}

function __apptool_validate_zip {
	ZIP_ARCHIVE="$1"
	ZIP_OK=$(unzip -t "${ZIP_ARCHIVE}" | grep 'No errors detected in compressed data')
	if [ -z "${ZIP_OK}" ]; then
		rm "${ZIP_ARCHIVE}"
		echo ""
		echo "Stop! The archive was corrupt and has been removed! Please try installing again."
		return 1
	fi
}

function __apptool_install {
	CANDIDATE="$1"
	LOCAL_FOLDER="$3"
	__apptool_check_candidate_present "${CANDIDATE}" || return 1
	__apptool_determine_version "$2" "$3" || return 1

	if [[ -d "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}" || -h "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}" ]]; then
		echo ""
		echo "Stop! ${CANDIDATE} ${VERSION} is already installed."
		return 0
	fi

	if [[ ${VERSION_VALID} == 'valid' ]]; then
		__apptool_install_candidate_version "${CANDIDATE}" "${VERSION}" || return 1

		if [[ "${openapphack_auto_answer}" != 'true' ]]; then
			echo -n "Do you want ${CANDIDATE} ${VERSION} to be set as default? (Y/n): "
			read USE
		fi
		if [[ -z "${USE}" || "${USE}" == "y" || "${USE}" == "Y" ]]; then
			echo ""
			echo "Setting ${CANDIDATE} ${VERSION} as default."
			__apptool_link_candidate_version "${CANDIDATE}" "${VERSION}"
		fi
		return 0

	elif [[ "${VERSION_VALID}" == 'invalid' && -n "${LOCAL_FOLDER}" ]]; then
		__apptool_install_local_version "${CANDIDATE}" "${VERSION}" "${LOCAL_FOLDER}" || return 1

    else
        echo ""
		echo "Stop! $1 is not a valid ${CANDIDATE} version."
		return 1
	fi
}


function __apptool_install_local_version {
	CANDIDATE="$1"
	VERSION="${2:=master}"
	LOCAL_FOLDER="$3"
	CANDIDATE_VM_LOCATION="${OPENAPPHACK_DIR}/.vms/${CANDIDATE}"
	mkdir -p "${CANDIDATE_VM_LOCATION}"

	echo "Linking ${CANDIDATE} ${VERSION} to ${LOCAL_FOLDER}"
	ln -s "${LOCAL_FOLDER}" "${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}"
	echo "Done installing!"
	echo ""
}


function __apptool_install_candidate_version {
	CANDIDATE="$1"
	# version defaults to master if no tag is giving
	VERSION="${2:=master}"
	echo "Installing: ${CANDIDATE} ${VERSION}"

  CANDIDATE_VM_LOCATION="${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/${VERSION}"
	CANDIDATE_VM_LOCATION_CURRENT="${OPENAPPHACK_DIR}/.vms/${CANDIDATE}/current"
	VM_LOCATION="${OPENAPPHACK_DIR}/vm"

	mkdir -p "${CANDIDATE_VM_LOCATION}"
  pushd .
	cd "${CANDIDATE_VM_LOCATION}"

	git clone https://github.com/${CANDIDATE}/openapphack-vm.git

	#TODO check for valid tag before checkout of TAG

	if [[ -z "${VERSION}" || "${VERSION}" != "master" ]]; then
		git checkout "tags/${VERSION}"
  fi

	# Change the 'vm' symlink , hence affecting all shells.
	if [ -L "${VM_LOCATION}" ]; then
		unlink "${VM_LOCATION}"
	fi


	# Change the 'current candidate vm' symlink , hence affecting all shells.
	if [ -L "${CANDIDATE_VM_LOCATION_CURRENT}" ]; then
		unlink "${CANDIDATE_VM_LOCATION_CURRENT}"
	fi

	ln -s "${CANDIDATE_VM_LOCATION_CURRENT}" "${CANDIDATE_VM_LOCATION}"

	ln -s "${VM_LOCATION}" "${CANDIDATE_VM_LOCATION_CURRENT}"

	popd

	echo "Done installing!"
	echo ""
}
