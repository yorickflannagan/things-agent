# Basic environment definition
# Arguments:
#    $1: Name of an installed application directory
#    $2: User profile file. Optional: default .profile under above directory.
# Return codes:
#    -1: JAVA_HOME not variable found
#    -2: JAVA_HOME variable does not point to a valid place
#    -3: JAVA_HOME does not exist as a valid directory
#    -4: First argument does not poin to an existing application
# Previous environment:
#    JAVA_HOME: required execution JDK location
#    CLASS_PATH: optional Java class path
#    JMX_HOST: optional application JMX host for Agent connection. Default 127.0.0.1
#    JMX_PORT_AGE: optional application JMX port for Agent connection. Default 1608
#    SNMP_TARGET: optional SNMP address. Default 127.0.0.1/8163
#    JMX_NOAUTH: optional authentication JMX parameters.
#    Default -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false
#    JMX_CONF: optional JMX parameters. Default $JMX_NOAUTH -Djava.rmi.server.hostname=$JMX_HOST
#    -Dcom.sun.management.jmxremote.port=$JMX_PORT_AGE

cur=$PWD
cd $(dirname $0)
export AGENT_DIR=$PWD
cd ..
export INSTALL=$PWD
cd $cur
export SERVERS=$INSTALL/servers

if [ -d "SERVERS/$1" ]; then
	echo "$1 argument does not point to an existing application"
	exit -4
fi
export NAME=$1

if [ -z "$2" ]; then 
	if [ -f $INSTALL/.profile ]; then
		. $INSTALL/.profile;
	else
		echo "Execution profile not found. Will execute with the current environment."
	fi
else
	 echo "Used profile: $INSTALL/$2";
	. $INSTALL/$2
fi

if [ -z "$JAVA_HOME" ]; then
	echo "JAVA_HOME environment variable not found."
	exit -1
fi
if [ -d "$JAVA_HOME" ]; then
	if [ ! -f "$JAVA_HOME/bin/java" ]; then
		echo "JAVA_HOME[$JAVA_HOME] does not points to a valid place."
		exit -2
	fi
else
	echo "JAVA_HOME[$JAVA_HOME] does not exist as a valid directory."
	exit -3
fi
export PATH=$JAVA_HOME/bin/:$PATH

for i in $(ls $AGENT_DIR/*.jar)
do
    cp=$i:$cp
done
if [ -z "$CLASS_PATH" ]; then
	export CLASS_PATH=$cp
else
	export CLASS_PATH=$CLASS_PATH;$cp
fi

if [ -z "$JMX_HOST" ]; then
	export JMX_HOST=127.0.0.1
fi

if [ -z "$JMX_PORT_AGE" ]; then
	export JMX_PORT_AGE=1608
fi

if [ -z "$SNMP_TARGET" ]; then
	export SNMP_TARGET=127.0.0.1/8163
fi

if [ -z "$JMX_NOAUTH" ]; then
	export JMX_NOAUTH="-Dcom.sun.management.jmxremote.authenticate=false"
	export JMX_NOAUTH="$JMX_NOAUTH -Dcom.sun.management.jmxremote.ssl=false"
fi

if [ -z "$JMX_CONF" ]; then
	export JMX_CONF="$JMX_NOAUTH -Djava.rmi.server.hostname" 
	export JMX_CONF="$JMX_CONF=$JMX_HOST"
	export JMX_CONF="$JMX_CONF -Dcom.sun.management.jmxremote.port"
	export JMX_CONF="$JMX_CONF=$JMX_PORT_AGE"
fi
