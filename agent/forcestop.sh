# Things application forced shutdown
# See base.sh for environment definitions
# Arguments:
#    $1: directory name of the application to start
#    $2: optional user profile to environment
. $(dirname $0)/base.sh $1 $2

java  -cp "$CLASS_PATH"  org.crypthing.things.appservice.Shutdown --force_stop_by_agent $JMX_HOST $JMX_PORT_AGE $1 10
code="$?"
if [ "$code" = "0" ]; then
	echo "Application stoped";
else
	echo "Failure. Return code: [$code]";
fi
