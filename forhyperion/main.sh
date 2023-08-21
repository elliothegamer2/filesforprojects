if [ $(id -u) -ne 0 ]; then
    echo "Run this script as root (sudo su)"
    sleep 2
    init
fi

extids='ext-id.txt'

cd /tmp
rm -f $extids
if test -f $extids; then
    echo "Found the Extension File"
    else
    echo "Did not find file"
    sleep 0.5
    echo 'Creating..'
    touch ext-id.txt
    sleep 0.2
    curl https://raw.githubusercontent.com/elliothegamer2/filesforprojects/main/forhyperion/extids > ext-id.txt
    echo 'Created'
    cat ext-id.txt
fi
function select_option {

    # little helpers for terminal print control and key input
    ESC=$( printf "\033")
    cursor_blink_on()  { printf "$ESC[?25h"; }
    cursor_blink_off() { printf "$ESC[?25l"; }
    cursor_to()        { printf "$ESC[$1;${2:-1}H"; }
    print_option()     { printf "   $1 "; }
    print_selected()   { printf "  $ESC[7m $1 $ESC[27m"; }
    get_cursor_row()   { IFS=';' read -sdR -p $'\E[6n' ROW COL; echo ${ROW#*[}; }
    key_input()        { read -s -n3 key 2>/dev/null >&2
                         if [[ $key = $ESC[A ]]; then echo up;    fi
                         if [[ $key = $ESC[B ]]; then echo down;  fi
                         if [[ $key = ""     ]]; then echo enter; fi; }

    # initially print empty new lines (scroll down if at bottom of screen)
    for opt; do printf "\n"; done

    # determine current screen position for overwriting the options
    local lastrow=`get_cursor_row`
    local startrow=$(($lastrow - $#))

    # ensure cursor and input echoing back on upon a ctrl+c during read -s
    trap "cursor_blink_on; stty echo; printf '\n'; exit" 2
    cursor_blink_off

    local selected=0
    while true; do
        # print options by overwriting the last lines
        local idx=0
        for opt; do
            cursor_to $(($startrow + $idx))
            if [ $idx -eq $selected ]; then
                print_selected "$opt"
            else
                print_option "$opt"
            fi
            ((idx++))
        done

        # user key control
        case `key_input` in
            enter) break;;
            up)    ((selected--));
                   if [ $selected -lt 0 ]; then selected=$(($# - 1)); fi;;
            down)  ((selected++));
                   if [ $selected -ge $# ]; then selected=0; fi;;
        esac
    done

    # cursor position back to normal
    cursor_to $lastrow
    printf "\n"
    cursor_blink_on

    return $selected
}
cd
clear
harddisableext() {
    clear
    echo
    echo 'Credit to MercuryWorkshop where i got this code'
    echo "Please choose the extension you wish to disable."
    echo "(1) GoGuardian"
    echo "(2) Securly Filter"
    echo "(3) LightSpeed Filter"
    echo "(4) Cisco Umbrella"
    echo "(5) ContentKeeper Authenticator"
    echo "(6) Hapara"
    echo "(7) iboss"
    echo "(8) LightSpeed Classroom"
    echo "(9) Blocksi"
    echo "(10) Linewize"
    echo "(11) Securly Classroom"
    echo "(12) Impero"
    echo "(13) put extension ID in manually"
    read -r -p "> (1-13): " choice
    case "$choice" in
    1) extid=haldlgldplgnggkjaafhelgiaglafanh;;
    2) extid=iheobagjkfklnlikgihanlhcddjoihkg;;
    3) extid=adkcpkpghahmbopkjchobieckeoaoeem;;
    4) extid=jcdhmojfecjfmbdpchihbeilohgnbdci;;
    5) extid=jdogphakondfdmcanpapfahkdomaicfa;;
    6) extid=aceopacgaepdcelohobicpffbbejnfac;;
    7) extid=kmffehbidlalibfeklaefnckpidbodff;;
    8) extid=jaoebcikabjppaclpgbodmmnfjihdngk;;
    9) extid=ghlpmldmjjhmdgmneoaibbegkjjbonbk;;
    10) extid=ddfbkhpmcdbciejenfcolaaiebnjcbfc;;
    11) extid=jfbecfmiegcjddenjhlbhlikcbfmnafd;;
    12) extid=jjpmjccpemllnmgiaojaocgnakpmfgjg;;
    13) read -r -p "enter extension id>" extid;;
    *) echo "invalid option" ;;
    esac
    echo "$extid" | grep -qE '^[a-z]{32}$' && chmod 000 "/home/chronos/user/Extensions/$extid" && kill -9 $(pgrep -f "\-\-extension\-process") || "invalid input"
    main
}

hardenableext() {
    clear
    echo
    echo 'Credit to MercuryWorkshop where i got this code'
    echo "Please choose the extension you wish to enable."
    echo "(1) GoGuardian"
    echo "(2) Securly Filter"
    echo "(3) LightSpeed Filter"
    echo "(4) Cisco Umbrella"
    echo "(5) ContentKeeper Authenticator"
    echo "(6) Hapara"
    echo "(7) iboss"
    echo "(8) LightSpeed Classroom"
    echo "(9) Blocksi"
    echo "(10) Linewize"
    echo "(11) Securly Classroom"
    echo "(12) Impero"
    echo "(13) put extension ID in manually"
    read -r -p "> (1-13): " choice
    case "$choice" in
    1) extid=haldlgldplgnggkjaafhelgiaglafanh;;
    2) extid=iheobagjkfklnlikgihanlhcddjoihkg;;
    3) extid=adkcpkpghahmbopkjchobieckeoaoeem;;
    4) extid=jcdhmojfecjfmbdpchihbeilohgnbdci;;
    5) extid=jdogphakondfdmcanpapfahkdomaicfa;;
    6) extid=aceopacgaepdcelohobicpffbbejnfac;;
    7) extid=kmffehbidlalibfeklaefnckpidbodff;;
    8) extid=jaoebcikabjppaclpgbodmmnfjihdngk;;
    9) extid=ghlpmldmjjhmdgmneoaibbegkjjbonbk;;
    10) extid=ddfbkhpmcdbciejenfcolaaiebnjcbfc;;
    11) extid=jfbecfmiegcjddenjhlbhlikcbfmnafd;;
    12) extid=jjpmjccpemllnmgiaojaocgnakpmfgjg;;
    13) read -r -p "enter extension id>" extid;;
    *) echo "invalid option" ;;
    esac
    echo "$extid" | grep -qE '^[a-z]{32}$' && chmod 777 "/home/chronos/user/Extensions/$extid" && kill -9 $(pgrep -f "\-\-extension\-process") || "invalid input"
    main
}

init() {
    clear
    echo "Welcome to HyperionHub"
    echo

    options=("Main" "Expermental" "Exit")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"
    if [[ $choice == 0 ]]; then
        main
    fi
    if [[ $choice == 1 ]]; then
        expermental
    fi
    if [[ $choice == 2 ]]; then
        exit
    fi
}

main() {
    clear
    echo "Main Hyperion Page"
    echo

    options=("Hard Disable Extension" "Hard Enable Extension" "Clear UrlBlockList" "Clear SecondarySignin" "Back")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"
    if [[ $choice == 0 ]]; then
        harddisableext
    fi
    if [[ $choice == 1 ]]; then
        hardenableext
    fi
    if [[ $choice == 2 ]]
    then
        ask_clearURLBLOCKLIST
    fi
    if [[ $choice == 3 ]]
    then
        clear
        echo "Clear SecondaryGoogleAccountSigninAllowed?"
        echo

        options=("Yes" "No" "Cancel")

        select_option "${options[@]}"
        choice=$?

        echo "Choosen index = $choice"
        echo "        value = ${options[$choice]}"
        if [[ $choice == 0 ]]; then
            sleep 1
            mkdir -p /tmp/overlay/etc/opt/chrome/policies/managed
            echo '{"SecondaryGoogleAccountSigninAllowed": false}' > /tmp/overlay/etc/opt/chrome/policies/managed/policy.json
            cp -a -L /etc/* /tmp/overlay/etc 2> /dev/null
            mount --bind /tmp/overlay/etc /etc

            echo ""
            echo "Pollen has been successfully applied!"
            sleep 2
            init
    fi  
}
expermental() {
    clear
    echo "Expermental Hyperion Page"
    echo "These may break btw"
    echo

    options=("SecDNS" "Test Menu" "Back")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"
    if [[ $choice == 0 ]]; then
        ask_secdns
    fi
    if [[ $choice == 1 ]]; then
        tes_menu
    fi
}
ask_clearURLBLOCKLIST() {
    clear
    echo "Clear UrlBlockList?"
    echo

    options=("Yes" "No" "Cancel")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"
    if [[ $choice == 0 ]]; then
        sleep 1
        mkdir -p /tmp/overlay/etc/opt/chrome/policies/managed
        echo '{"URLBlocklist": []}' > /tmp/overlay/etc/opt/chrome/policies/managed/policy.json
        cp -a -L /etc/* /tmp/overlay/etc 2> /dev/null
        mount --bind /tmp/overlay/etc /etc

        echo ""
        echo "Pollen has been successfully applied!"
        sleep 2
        init
    fi
    if [[ $choice == 1 ]];
    then
        echo 'This will reboot your chromebook so that it is reset to normal status'
        sleep 5
        echo 'Rebooting...'
        reboot
    fi
    if [[ $choice == 2 ]]
    then
        init
    fi
}
ask_secdns() {
    clear
    echo "Enable of Disable SecureDNS?"
    echo

    options=("On" "Off" "Cancel")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"   
    if [[ $choice == 0 ]]
    then
        if [ $(id -u) -ne 0 ]; then
            echo "Run this script as root (sudo su)"
            sleep 2
            init
        fi

        echo "+##############################################+"
        echo "# Welcome To Pollen!                           #"
        echo "# The User Policy Editor                       #"
        echo "# -------------------------------------------- #"
        echo "# Developers:                                  #"
        echo "# - OlyB                                       #"
        echo "# - Rafflesia                                  #"
        echo "# - Scaratek                                   #"
        echo "# - r58Playz                                   #"
        echo "+##############################################+"
        echo "May Ultrablue Rest in Peace, o7"

        sleep 1

        mkdir -p /tmp/overlay/etc/opt/chrome/policies/managed
        echo '{"DnsOverHttpsMode": null}' > /tmp/overlay/etc/opt/chrome/policies/managed/policy.json
        cp -a -L /etc/* /tmp/overlay/etc 2> /dev/null
        mount --bind /tmp/overlay/etc /etc

        echo ""
        echo "Pollen has been successfully applied!"
        sleep 2
        init
    fi
    if [[ $choice == 1 ]]
    then
        if [ $(id -u) -ne 0 ]; then
            echo "Run this script as root (sudo su)"
            sleep 2
            init
        fi

        echo "+##############################################+"
        echo "# Welcome To Pollen!                           #"
        echo "# The User Policy Editor                       #"
        echo "# -------------------------------------------- #"
        echo "# Developers:                                  #"
        echo "# - OlyB                                       #"
        echo "# - Rafflesia                                  #"
        echo "# - Scaratek                                   #"
        echo "# - r58Playz                                   #"
        echo "+##############################################+"
        echo "May Ultrablue Rest in Peace, o7"

        sleep 1

        mkdir -p /tmp/overlay/etc/opt/chrome/policies/managed
        echo '{"DnsOverHttpsMode": off}' > /tmp/overlay/etc/opt/chrome/policies/managed/policy.json
        cp -a -L /etc/* /tmp/overlay/etc 2> /dev/null
        mount --bind /tmp/overlay/etc /etc

        echo ""
        echo "Pollen has been successfully applied!"
        sleep 2
        init
    fi
    if [[ $choice == 2 ]]; then
        init
    fi
}
tes_menu() {
    clear
    echo "Select A Extension to Disable"
    echo

    options=("GoGuardian" "Securly Filter" "LightSpeed Filter" "Cisco Umbrella" "ContentKeeper Authenticator" "Hapara" "iBoss" "Lightspeed Classroom" "Blocksi" "Linewize" "Securly Classrom" "Impero")

    select_option "${options[@]}"
    choice=$?

    echo "Choosen index = $choice"
    echo "        value = ${options[$choice]}"
    if [[ $choice == 0 ]]
    then
        extid='haldlgldplgnggkjaafhelgiaglafanh'
        echo 'Disabling GoGuardian'
    fi
    echo "$extid" | grep -qE '^[a-z]{32}$' && chmod 000 "/home/chronos/user/Extensions/$extid" && kill -9 $(pgrep -f "\-\-extension\-process") || "invalid input"
    echo 'Disabled GuGuardian!'
    sleep 2
    init
}
init
