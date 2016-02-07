

echo ""
echo "Updating openapphack..."

OPENAPPHACK_VERSION="x.y.z"

openapphack_bin_folder="${OPENAPPHACK_DIR}/bin"
openapphack_stage_folder="${OPENAPPHACK_DIR}/tmp/stage"
openapphack_src_folder="${OPENAPPHACK_DIR}/src"

echo "Purge existing scripts..."
rm -rf "${openapphack_bin_folder}"
rm -rf "${openapphack_src_folder}"

echo "Refresh directory structure..."
mkdir -p "${OPENAPPHACK_DIR}/bin"
mkdir -p "${OPENAPPHACK_DIR}/ext"
mkdir -p "${OPENAPPHACK_DIR}/etc"
mkdir -p "${OPENAPPHACK_DIR}/src"
mkdir -p "${OPENAPPHACK_DIR}/var"
mkdir -p "${OPENAPPHACK_DIR}/tmp"
mkdir -p "${OPENAPPHACK_DIR}/vm"
mkdir -p "${OPENAPPHACK_DIR}/.vms"

# drop version token
echo "$OPENAPPHACK_VERSION" > "${OPENAPPHACK_DIR}/var/version"

echo "Prime the config file..."
openapphack_config_file="${OPENAPPHACK_DIR}/etc/config"
touch "${openapphack_config_file}"

echo "Extract script archive..."

echo "Unziping scripts to: ${openapphack_stage_folder}"

echo "Moving app-init file to bin folder..."

echo "Move remaining module scripts to src folder: ${openapphack_src_folder}"

echo "Clean up staging folder..."

echo ""
echo ""
echo "Successfully upgraded OpenAppHack CLI."
echo ""
echo "Please open a new terminal, or run the following in the existing one:"
echo ""
echo "    source \"${OPENAPPHACK_DIR}/bin/app-init.sh\""
echo ""
echo ""
