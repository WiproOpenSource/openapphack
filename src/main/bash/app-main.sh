#!/bin/bash


function app {

    COMMAND="$1"
    QUALIFIER="$2"

    case "$COMMAND" in
        l)
            COMMAND="list";;
        ls)
            COMMAND="list";;
        h)
            COMMAND="help";;
        v)
            COMMAND="version";;
        u)
            COMMAND="use";;
        up)
            COMMAND="up";;
        halt)
            COMMAND="halt";;
        k)
            COMMAND="halt";;
        provision)
            COMMAND="provision";;
        p)
            COMMAND="provision";;

        destroy)
            COMMAND="destroy";;
        x)
            COMMAND="destroy";;
        i)
            COMMAND="install";;
        rm)
            COMMAND="uninstall";;
        c)
            COMMAND="current";;
        o)
            COMMAND="outdated";;
        d)
            COMMAND="default";;
        b)
            COMMAND="broadcast";;
    esac

	#
	# Various sanity checks and default settings
	#
	__apptool_default_environment_variables

	mkdir -p "$OPENAPPHACK_DIR"

    openapphack_update_broadcast_or_force_offline

	# Load the openapphack config if it exists.
	if [ -f "${OPENAPPHACK_DIR}/etc/config" ]; then
		source "${OPENAPPHACK_DIR}/etc/config"
	fi

 	# no command provided
	if [[ -z "$COMMAND" ]]; then
		__apptool_help
		return 1
	fi

	# Check if it is a valid command
	CMD_FOUND=""
	CMD_TARGET="${OPENAPPHACK_DIR}/src/app-${COMMAND}.sh"
	if [[ -f "$CMD_TARGET" ]]; then
		CMD_FOUND="$CMD_TARGET"
	fi

	# Check if it is a sourced function
	CMD_TARGET="${OPENAPPHACK_DIR}/ext/app-${COMMAND}.sh"
	if [[ -f "$CMD_TARGET" ]]; then
		CMD_FOUND="$CMD_TARGET"
	fi

	# couldn't find the command
	if [[ -z "$CMD_FOUND" ]]; then
		echo "Invalid command: $COMMAND"
		__apptool_help
	fi

	# Check whether the candidate exists
	local openapphack_valid_candidate=$(echo ${OPENAPPHACK_CANDIDATES[@]} | grep -w "$QUALIFIER")
	if [[ -n "$QUALIFIER" && "$COMMAND" != "offline" && "$COMMAND" != "flush" && "$COMMAND" != "selfupdate" && -z "$openapphack_valid_candidate" ]]; then
		echo -e "\nStop! $QUALIFIER is not a valid candidate."
		return 1
	fi

	if [[ "$COMMAND" == "offline" &&  -z "$QUALIFIER" ]]; then
		echo -e "\nStop! Specify a valid offline mode."
	elif [[ "$COMMAND" == "offline" && ( -z $(echo "enable disable" | grep -w "$QUALIFIER")) ]]; then
		echo -e "\nStop! $QUALIFIER is not a valid offline mode."
	fi

	# Check whether the command exists as an internal function...
	#
	# NOTE Internal commands use underscores rather than hyphens,
	# hence the name conversion as the first step here.
	CONVERTED_CMD_NAME=$(echo "$COMMAND" | tr '-' '_')

	# Execute the requested command
	if [ -n "$CMD_FOUND" ]; then
		# It's available as a shell function
		__apptool_"$CONVERTED_CMD_NAME" "$QUALIFIER" "$3" "$4"
	fi

	# Attempt upgrade after all is done
	if [[ "$COMMAND" != "selfupdate" ]]; then
	    __apptool_auto_update "$OPENAPPHACK_REMOTE_VERSION" "$OPENAPPHACK_VERSION"
	fi
}
