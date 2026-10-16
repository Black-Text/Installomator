lucidlink3)
    # LucidLink 3 installs LucidLink.app. The lucidlink label is LucidLink Classic (2.x, Lucid.app).
    name="LucidLink"
    type="pkg"
    packageID="com.lucidlink.app"
    downloadURL="https://www.lucidlink.com/download/new-ll-latest/macos/stable/"
    appNewVersion=$(curl -fsIL "$downloadURL" | awk 'BEGIN{IGNORECASE=1}/^location:/{gsub("\r",""); print $2}' | tail -n 1 | sed -E 's|.*/lucidlink-([0-9]+(\.[0-9]+)+)\.pkg$|\1|')
    expectedTeamID="Y4KMJPU2B4"
    ;;
