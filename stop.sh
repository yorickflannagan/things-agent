# Things application graceful stop
# See base.sh for environment definitions
# Arguments:
#    $1: directory name of the application to start. Must be "agent" for Things Agent stop.
#    $2: optional user profile to environment
. $(dirname $0)/base.sh $1 $2

export WAIT_TIME=10
code=0
if [ "$1" = "agent" ]; then
	java  -cp "$CLASS_PATH"  org.crypthing.things.appservice.Shutdown --agent $JMX_HOST $JMX_PORT_AGE
	code="$?"
	if [ "$code" = "0" ]; then
		echo "Agent stoped";
	else
		echo "Failure. Return code: [$code]";
	fi
else
	java  -cp "$CLASS_PATH"  org.crypthing.things.appservice.Shutdown --stop_by_agent $JMX_HOST $JMX_PORT_AGE $NAME $WAIT_TIME
	code="$?"
	if [ "$code" = "0" ]; then
		echo "Application stoped";
	else
		echo "Failure. Return code: [$code]";
	fi
fi
exit $code
