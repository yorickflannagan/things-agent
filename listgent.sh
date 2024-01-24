# Things agent status listing
# See base.sh for environment definitions
# Arguments:
#    $1: directory name of the application to start
#    $2: optional user profile to environment
. $(dirname $0)/base.sh $1 $2

java  -cp "$CLASS_PATH"  org.crypthing.things.appservice.AgentStatus --agent $JMX_HOST $JMX_PORT_AGE
