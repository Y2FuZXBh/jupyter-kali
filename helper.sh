function update-hosts(){
    if [ $IP != '' ] && [ $HOST != '' ] && [ $DOMAIN != '' ]; then
        null=$(hostsman -i $HOST.$DOMAIN:$IP)
        hostsman -l | grep "$HOST.$DOMAIN"
    fi
    if [ $IP != '' ] && [ $HOST != '' ] && [ $DOMAIN = '' ]; then
        null=$(hostsman -i $HOST:$IP)
        hostsman -l | grep "$HOST"
    fi
}
function notes(){
if [[ ! -f notes.txt ]]; then
    echo " 
" > notes.txt
fi
}
function refresh-users(){
    cat users | sed 's/ *$//' | sed -r '/^\s*$/d' | sort -u > users
    cat users
}
function powershell(){
    pwsh -nop -noni -nol -c "$@"
}

notes
update-hosts
refresh-users