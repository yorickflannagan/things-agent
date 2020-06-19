# Things application execution
# See base.sh for environment definitions
# Arguments:
#    $1: directory name of the application to start. Must be "agent" for Things Agent start.
#    $2: optional user profile to environment
. $(dirname $0)/base.sh $1 $2


export WAIT_TIME=5
code=0
if [ "$1" = "agent" ]; then
	java $JMX_CONF -cp "$CLASS_PATH" org.crypthing.things.appservice.Bootstrap $SNMP_TARGET 
else
	java $JMX_NOAUTH -cp "$CLASS_PATH" org.crypthing.things.appservice.Launch --agent  $JMX_HOST $JMX_PORT_AGE --home $SERVERS/$NAME/ --runner $SERVERS/$NAME/config/config.xml
	code="$?"
	if [ "$code" = "0" ]; then
		sleep $WAIT_TIME
		saida=$(java $JMX_NOAUTH -cp "$CLASS_PATH"  org.crypthing.things.appservice.AgentStatus  --agent  $JMX_HOST $JMX_PORT_AGE)
		code2=$?
		if [ "$code2" = "0" ]; then
			saida2=$(echo $saida | grep $1)
		if [ -z "$saida2" ]; then
			echo "Failure. Return not listed. Likely error.";
			exit 2
		else
			echo "Done!";
			exit 0
		fi
		else
			echo "Failure. Return listing: [$code2]";
			exit $code2
		fi
	else
		echo "Failure. Return code: [$code]";
	fi
fi	
exit $code
