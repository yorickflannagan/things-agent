# Things application status listing
# See base.sh for environment definitions
# Arguments:
#    $1: directory name of the application to start
#    $2: optional user profile to environment
. $(dirname $0)/base.sh $1 $2

export WAIT_TIME=1000
export TIMES=100
java  -cp "$CLASS_PATH"  org.crypthing.things.appservice.Status $SERVERS/$NAME/config/config.xml  $TIMES $WAIT_TIME
