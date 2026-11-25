brainconnect|\
agencybrain)
    # Black Text: Agency Brain was renamed Brain Connect in 1.1.48. agencybrain stays as an
    # alias for preinstall scripts not yet updated.
    name="Brain Connect"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://github.com/8020brain/agency-brain-downloads/releases/latest/download/Brain-Connect-mac-arm64.dmg"
    else
        downloadURL="https://github.com/8020brain/agency-brain-downloads/releases/latest/download/Brain-Connect-mac-intel.dmg"
    fi
    appNewVersion=$(curl -fsL "https://github.com/8020brain/agency-brain-downloads/releases/latest/download/latest-mac.yml" | awk '/^version:/ { print $2; exit }')
    expectedTeamID="J83Q25362G"
    blockingProcesses=( "Brain Connect" "Agency Brain" )
    # Black Text: installs into the signed-in user's own Applications folder, because the
    # app updates itself and most users are standard users, who can't write to /Applications.
    # The updater replaces the whole app, so the folder has to be the user's, not root's.
    if [[ -z $currentUser || $currentUser == "loginwindow" ]]; then
        cleanupAndExit 1 "Brain Connect installs into the signed-in user's Applications folder, and no one is signed in." ERROR
    fi
    targetDir="$(dscl . -read "/Users/$currentUser" NFSHomeDirectory | awk '{ print $2 }')/Applications"
    if [[ ! -d $targetDir && $DEBUG -eq 0 ]]; then
        mkdir -p "$targetDir"
        chown "$currentUser" "$targetDir"
    fi
    # Its own updater keeps an earlier install at "Agency Brain.app", same bundle ID. Rename
    # it, so it's updated in place rather than left beside a second copy.
    if [[ $DEBUG -eq 0 && -d "$targetDir/Agency Brain.app" && ! -e "$targetDir/Brain Connect.app" ]] \
        && [[ $(defaults read "$targetDir/Agency Brain.app/Contents/Info" CFBundleIdentifier 2>/dev/null) == "com.8020brain.agencybrain" ]]; then
        printlog "Renaming $targetDir/Agency Brain.app to Brain Connect.app" INFO
        mv "$targetDir/Agency Brain.app" "$targetDir/Brain Connect.app"
    fi
    ;;
