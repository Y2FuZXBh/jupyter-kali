function refresh(){
    IP=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"IP\"])")
    HOST=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"HOST\"])")
    DOMAIN=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"DOMAIN\"])")
    WORKGROUP=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"WORKGROUP\"])")
    DC=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"DC\"])")
    DNS=$(python -c "import yaml;print(yaml.safe_load(open('target.yml'))[\"DNS\"])")
}
function update-hosts(){
    refresh
    if [ $IP != 'None' ] && [ $HOST != 'None' ] && [ $DOMAIN != 'None' ]; then
        null=$(hostsman -i $HOST.$DOMAIN:$IP)
        hostsman -l | grep "$HOST.$DOMAIN"
    fi
    if [ $IP != 'None' ] && [ $HOST != 'None' ] && [ $DOMAIN = 'None' ]; then
        null=$(hostsman -i $HOST:$IP)
        hostsman -l | grep "$HOST"
    fi
}
function target(){
if [[ ! -f target.yml ]]; then
    echo "IP: 
HOST: 
DOMAIN: 
WORKGROUP: 
OS: 
DC: 
DNS: " > target.yml
fi
cat target.yml
}
function notes(){
if [[ ! -f notes.txt ]]; then
    echo " 
" > notes.yml
fi
cat notes.txt
}
function refresh-users(){
    cat users | sed 's/ *$//' | sed -r '/^\s*$/d' | sort -u > users
    cat users
}
function powershell(){
    pwsh -nop -noni -nol -c "$@"
}

target
notes
refresh