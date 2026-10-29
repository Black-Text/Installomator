googleadseditor)
    name="Google Ads Editor"
    type="dmg"
    downloadURL="https://dl.google.com/adwords_editor/google_ads_editor.dmg"
    appNewVersion="$(curl -s "https://support.google.com/google-ads/editor/topic/13728" | grep -Eo 'Google Ads Editor version [0-9]+(\.[0-9]+)*' | head -1 | grep -Eo '[0-9]+(\.[0-9]+)*')"
    # Google numbers releases 2.x (the bundle says 14.x). Read the full 2.x number from the
    # newest copy in Versions/: the old ".{0,4}" pattern cut 2.13 down to 2.1.
    appCustomVersion(){
        local versions=( "/Applications/Google Ads Editor.app/Contents/Versions/"*(N/nOn) )
        (( ${#versions} )) || return 0
        grep -oE 'about version [0-9]+(\.[0-9]+)*' "${versions[1]}/Google Ads Editor.app/Contents/locale/content/welcome1/welcome1-en-US.htm" 2>/dev/null | head -1 | grep -oE '[0-9]+(\.[0-9]+)*$'
    }
    expectedTeamID="EQHXZ8M8AV"
    ;;
