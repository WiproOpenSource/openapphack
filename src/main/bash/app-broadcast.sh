#!/bin/bash


function __apptool_broadcast {
	if [ "${BROADCAST_OLD_TEXT}" ]; then
		echo "${BROADCAST_OLD_TEXT}"
	else
		echo "${BROADCAST_LIVE_TEXT}"
	fi
}

function openapphack_update_broadcast_or_force_offline {
    BROADCAST_LIVE_ID=$(openapphack_infer_broadcast_id)

    openapphack_force_offline_on_proxy "$BROADCAST_LIVE_ID"
    if [[ "$OPENAPPHACK_FORCE_OFFLINE" == 'true' ]]; then BROADCAST_LIVE_ID=""; fi

    openapphack_display_online_availability
    openapphack_determine_offline "$BROADCAST_LIVE_ID"

	apptool_update_broadcast "$COMMAND" "$BROADCAST_LIVE_ID"
}

function openapphack_infer_broadcast_id {
	if [[ "$OPENAPPHACK_FORCE_OFFLINE" == "true" || ( "$COMMAND" == "offline" && "$QUALIFIER" == "enable" ) ]]; then
		echo ""
	else
		echo $(curl -s "${OPENAPPHACK_BROADCAST_SERVICE}/broadcast/latest/id")
	fi
}

function openapphack_display_online_availability {
	if [[ -z "$BROADCAST_LIVE_ID" && "$OPENAPPHACK_ONLINE" == "true" && "$COMMAND" != "offline" ]]; then
		echo "$OFFLINE_BROADCAST"
	fi

	if [[ -n "$BROADCAST_LIVE_ID" && "$OPENAPPHACK_ONLINE" == "false" ]]; then
		echo "$ONLINE_BROADCAST"
	fi
}

function apptool_update_broadcast {
	local command="$1"
	local broadcast_live_id="$2"

	local broadcast_id_file="${OPENAPPHACK_DIR}/var/broadcast_id"
	local broadcast_text_file="${OPENAPPHACK_DIR}/var/broadcast"

	local broadcast_old_id=""

	if [[ -f "$broadcast_id_file" ]]; then
		broadcast_old_id=$(cat "$broadcast_id_file");
	fi

	if [[ -f "$broadcast_text_file" ]]; then
		BROADCAST_OLD_TEXT=$(cat "$broadcast_text_file");
	fi

	if [[ "${OPENAPPHACK_AVAILABLE}" == "true" && "$broadcast_live_id" != "${broadcast_old_id}" && "$command" != "selfupdate" && "$command" != "flush" ]]; then
		mkdir -p "${OPENAPPHACK_DIR}/var"

		echo "${broadcast_live_id}" > "$broadcast_id_file"

		BROADCAST_LIVE_TEXT=$(curl -s "${OPENAPPHACK_BROADCAST_SERVICE}/broadcast/latest")
		echo "${BROADCAST_LIVE_TEXT}" > "${broadcast_text_file}"
		echo "${BROADCAST_LIVE_TEXT}"
	fi
}
