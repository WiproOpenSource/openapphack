#!/bin/bash


function __apptool_selfupdate {
    OPENAPPHACK_FORCE_SELFUPDATE="$1"
	if [[ "$OPENAPPHACK_AVAILABLE" == "false" ]]; then
		echo "$OFFLINE_MESSAGE"

	elif [[ "$OPENAPPHACK_REMOTE_VERSION" == "$OPENAPPHACK_VERSION" && "$OPENAPPHACK_FORCE_SELFUPDATE" != "force" ]]; then
		echo "No update available at this time."

	else
		curl -s "${OPENAPPHACK_SERVICE}/selfupdate" | bash
	fi
	unset OPENAPPHACK_FORCE_SELFUPDATE
}

function __apptool_auto_update {

    local OPENAPPHACK_REMOTE_VERSION="$1"
    local OPENAPPHACK_VERSION="$2"

    OPENAPPHACK_DELAY_UPGRADE="${OPENAPPHACK_DIR}/var/delay_upgrade"

    if [[ -n "$(find "$OPENAPPHACK_DELAY_UPGRADE" -mtime +1)" && ( "$OPENAPPHACK_REMOTE_VERSION" != "$OPENAPPHACK_VERSION" ) ]]; then
        echo ""
        echo ""
        echo "ATTENTION: A new version of OPENAPPHACK is available..."
        echo ""
        echo "The current version is $OPENAPPHACK_REMOTE_VERSION, but you have $OPENAPPHACK_VERSION."
        echo ""

        if [[ "$openapphack_auto_selfupdate" != "true" ]]; then
            echo -n "Would you like to upgrade now? (Y/n)"
            read upgrade
        fi

        if [[ -z "$upgrade" ]]; then upgrade="Y"; fi

        if [[ "$upgrade" == "Y" || "$upgrade" == "y" ]]; then
            __apptool_selfupdate
            unset upgrade
        else
            echo "Not upgrading today..."
        fi

        touch "${OPENAPPHACK_DELAY_UPGRADE}"
    fi

}
