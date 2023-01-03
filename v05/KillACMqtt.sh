 #!/bin/bash
acmqtt=$(ps -eo cmd,pid,%mem | grep ACMqtt | grep i | sed 's/\s\+/ /g' )
mqttPid=$( echo $acmqtt | cut -d ' ' -f 4)
mqttMEM=$( echo $acmqtt | cut -d ' ' -f 5)
log_file="/home/moxa/killmqtt.log"
# echo $mqttPid
# echo $mqttMEM
# echo $mqtt
if awk "BEGIN{if($mqttMEM > 5){exit 0}else{exit 1}}"
then
    echo $(date "+%F %T") "," 'mqttMEM > 5% kill mqtt' >> "$log_file"
    kill -9 $mqttPid
else
    echo $(date "+%F %T") "," 'mqttMEM < 5% mqtt sf' >> "$log_file"
fi
