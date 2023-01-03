    #!/bin/bash
    acmqtt=$(ps -eo cmd,pid,%mem | grep ACMqtt | grep i | sed 's/\s\+/ /g' )
    mqttPid=$( echo $acmqtt | cut -d ' ' -f 4)
    mqttMEM=$( echo $acmqtt | cut -d ' ' -f 5)
    log_file="/home/moxa/killmqtt.log"

    # echo $mqttPid
    # echo $mqttMEM
    # echo $mqtt

    if [ $(echo "$mqttMEM > 5" | bc) -eq 1 ];then
        echo $(date "+%F %T") ","  'mqttMEM > 5% kill mqtt' >> "$log_file" 
        kill -9 $mqttPid
    else
        echo $(date "+%F %T") "," 'mqttMEM < 5%  mqtt sf' >> "$log_file"
    fi

