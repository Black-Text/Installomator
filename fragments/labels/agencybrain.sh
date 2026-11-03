agencybrain)
    name="Agency Brain"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://github.com/8020brain/agency-brain-downloads/releases/latest/download/Agency-Brain-mac-arm64.dmg"
    else
        downloadURL="https://github.com/8020brain/agency-brain-downloads/releases/latest/download/Agency-Brain-mac-intel.dmg"
    fi
    appNewVersion=$(curl -fsL "https://github.com/8020brain/agency-brain-downloads/releases/latest/download/latest-mac.yml" | awk '/^version:/ { print $2; exit }')
    expectedTeamID="J83Q25362G"
    # Black Text: installs into the signed-in user's own Applications folder, because the
    # app updates itself and most users are standard users, who can't write to /Applications.
    # The updater replaces the whole app, so the folder has to be the user's, not root's.
    if [[ -z $currentUser || $currentUser == "loginwindow" ]]; then
        cleanupAndExit 1 "Agency Brain installs into the signed-in user's Applications folder, and no one is signed in." ERROR
    fi
    targetDir="$(dscl . -read "/Users/$currentUser" NFSHomeDirectory | awk '{ print $2 }')/Applications"
    if [[ ! -d $targetDir && $DEBUG -eq 0 ]]; then
        mkdir -p "$targetDir"
        chown "$currentUser" "$targetDir"
    fi
    ;;
