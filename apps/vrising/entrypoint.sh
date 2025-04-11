#!/bin/bash
serverDir=/serverdata
persistentDataPath=/savedata

term_handler() {
	echo "Shutting down Server"

	PID=$(pgrep -f "^${serverDir}/VRisingServer.exe")
	if [[ -z $PID ]]; then
		echo "Could not find VRisingServer.exe pid. Assuming server is dead..."
	else
		kill -n 15 "$PID"
		wait "$PID"
	fi
	wineserver -k
	sleep 1
	exit
}

cleanup_logs() {
	echo "Cleaning up logs older than $LOGDAYS days"
	find "$persistentDataPath" -name "*.log" -type f -mtime +"$LOGDAYS" -exec rm {} \;
	echo ""
}

trap 'term_handler' SIGTERM

if [ -z "$LOGDAYS" ]; then
	LOGDAYS=7
fi

cleanup_logs

# Print current user and group IDs
echo "User ID: $(id -u)"
echo "Group ID: $(id -g)"

mkdir -p /home/steam/.steam 2>/dev/null
echo " "
echo "Updating V-Rising Dedicated Server files..."
echo " "
/usr/bin/steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir "$serverDir" +login anonymous +app_update "$STEAM_APP_ID" validate +quit
printf "steam_appid: "
cat "$serverDir/steam_appid.txt"

echo " "
if ! grep -q -o 'avx[^ ]*' /proc/cpuinfo; then
	unsupported_file="VRisingServer_Data/Plugins/x86_64/lib_burst_generated.dll"
	echo "AVX or AVX2 not supported; Check if unsupported ${unsupported_file} exists"
	if [ -f "${serverDir}/${unsupported_file}" ]; then
		echo "Changing ${unsupported_file} as attempt to fix issues..."
		mv "${serverDir}/${unsupported_file}" "${serverDir}/${unsupported_file}.bak"
	fi
fi

echo " "
mkdir "$persistentDataPath/Settings" 2>/dev/null
if [ ! -f "$persistentDataPath/Settings/ServerGameSettings.json" ]; then
	echo "$persistentDataPath/Settings/ServerGameSettings.json not found. Copying default file."
	cp "$serverDir/VRisingServer_Data/StreamingAssets/Settings/ServerGameSettings.json" "$persistentDataPath/Settings/" 2>&1
fi
if [ ! -f "$persistentDataPath/Settings/ServerHostSettings.json" ]; then
	echo "$persistentDataPath/Settings/ServerHostSettings.json not found. Copying default file."
	cp "$serverDir/VRisingServer_Data/StreamingAssets/Settings/ServerHostSettings.json" "$persistentDataPath/Settings/" 2>&1
fi

# Checks if log file exists, if not creates it
current_date=$(date +"%Y%m%d-%H%M")
logfile="$current_date-VRisingServer.log"
if ! [ -f "${persistentDataPath}/$logfile" ]; then
	echo "Creating ${persistentDataPath}/$logfile"
	touch "$persistentDataPath/$logfile"
fi

cd "$serverDir" || {
	echo "Failed to cd to $serverDir"
	exit 1
}

echo "Starting V Rising Dedicated Server with name $SERVER_NAME"
echo " "
echo "Starting Xvfb"
Xvfb :0 -screen 0 1024x768x16 &
echo "Launching wine64 V Rising"
echo " "

run() {
	DISPLAY=:0.0 wine $serverDir/VRisingServer.exe \
    -batchmode \
    -nographics \
    -persistentDataPath "$persistentDataPath" \
    -logFile "$persistentDataPath/$logfile" \
    -serverName "${SERVER_NAME}" \
    -description "${DESCRIPTION}" \
    -gamePort "${GAME_PORT}" \
    -queryPort "${QUERY_PORT}" \
    -bindAddress "${BIND_ADDRESS}" \
    -hideIpAddress "${HIDE_IP}" \
    -lowerFPSWhenEmpty "${LOWER_FPS_EMPTY}" \
    -password "${SERVER_PASSWORD}" \
    -secure "${SECURE}" \
    -listOnEOS "${EOS_LIST}" \
    -listOnSteam "${STEAM_LIST}" \
    -preset "${GAME_PRESET}" \
    -difficultyPreset "${DIFFICULTY}" \
    -saveName "${SAVE_NAME}" 2>&1
}

run &
# Gets the PID of the last command
ServerPID=$!

# Tail log file and waits for Server PID to exit
/usr/bin/tail -n 0 -f "$persistentDataPath/$logfile" &
wait $ServerPID