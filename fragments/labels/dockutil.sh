dockutil)
    name="dockutil"
    type="pkg"
    packageID="dockutil.cli.tool"
    downloadURL=$(downloadURLFromGit "kcrawford" "dockutil")
    appNewVersion=$(versionFromGit "kcrawford" "dockutil")
    # Version from the binary, not the pkg receipt: a receipt left behind after the binary
    # was deleted made Installomator report "up to date" and never reinstall it.
    appCustomVersion(){ [[ -x /usr/local/bin/dockutil ]] && /usr/local/bin/dockutil --version 2>/dev/null; }
    expectedTeamID="Z5J8CJBUWC"
    blockingProcesses=( NONE )
    ;;
