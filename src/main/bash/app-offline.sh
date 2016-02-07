#!/bin/bash


function __apptool_offline {
	if [[ "$1" == "enable" ]]; then
		OPENAPPHACK_FORCE_OFFLINE="true"
		echo "Forced offline mode enabled."
	fi
	if [[ "$1" == "disable" ]]; then
		OPENAPPHACK_FORCE_OFFLINE="false"
		OPENAPPHACK_ONLINE="true"
		echo "Online mode re-enabled!"
	fi
}

function openapphack_determine_offline {
    local input="$1"
	if [[ -z "$input" ]]; then
		OPENAPPHACK_ONLINE="false"
		OPENAPPHACK_AVAILABLE="false"
	else
		OPENAPPHACK_ONLINE="true"
	fi
}

function openapphack_force_offline_on_proxy {
	local response="$1"
	local detect_html="$(echo "$response" | tr '[:upper:]' '[:lower:]' | grep 'html')"
	if [[ -n "$detect_html" ]]; then
		echo "OPENAPPHACK can't reach the internet so going offline. Re-enable online with:"
		echo ""
		echo "  $ app offline disable"
		echo ""
		OPENAPPHACK_FORCE_OFFLINE="true"
    else
        OPENAPPHACK_FORCE_OFFLINE="false"
	fi
}
