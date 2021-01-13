//CNSDCTLG JOB (9999,9999,,9999),'DIEGO',CLASS=Q, 
// MSGCLASS=T,NOTIFY=&SYSUID 
//* Configurar a saída do log.
//STEPEXEC EXEC PGM=BPXBATCH,REGION=8M 
//STDOUT   DD   PATH='/tmp/logstart.out',PATHOPTS=(OWRONLY,OCREAT), 
//     PATHMODE=SIRWXU 
//STDERR   DD   PATH='/tmp/logstart.err',PATHOPTS=(OWRONLY,OCREAT), 
//     PATHMODE=SIRWXU 
//* *************************************************************
//* *************************************************************
//* INICIA A EXECUÇÃO DO CATALOGADOR DE ARQUIVOS CNS EM JAVA
//* *************************************************************
//* JOB DE TEMPO DE EXECUÇÃO INDETERMINADO USAR START
//* *************************************************************
//* Abaixo segue o STDPARM
//*
//* Para alterar configurar as variaveis:                        
//*  NAME - nome da aplicacao. É o diretorio onde foi instalado  
//*  JAVA_HOME - Diretorio onde se encontra instalado o Java     
//*  JMX_HOST - ip de gerencia do servidor Things 
//*  JMX_PORT - porta de gerencia do servidor Things 
//*  SNMP_TARGET - ip/porta da MIB SNMP
//* *************************************************************
//*                                                              
//*  Outras variaveis utilizadas pela aplicacao:                 
//*   estas devem estar preferencialmente no .profile do usuario 
//*   devido a sua sensibilidade, e este deve estar com permissao
//*   somente para o próprio: chmod 600 ~/.profile               
//*                                                              
//*   DB2USER - usuário de serviço DB2                           
//*   DB2PASS - senha do usuário   DB2                           
//*                                                              
//* *************************************************************
//* *************************************************************
//STDPARM  DD * 
SH 
set -x;

if [ -f ~/.profile ]; then
 . ~/.profile;
else
 echo "Profile nao encontrado.";
fi;

export NAME=test;
export JAVA_HOME=/usr/lpp/java/J7.1_64;
export JMX_HOST=10.216.80.110;
export JMX_PORT=1603;
export SNMP_TARGET=127.0.0.1/8163;


if [ ]; then
  echo " Daqui para baixo não deve ser alterado                       ";
  echo " sem o conhecimento do desenvolvedor.                         ";
fi;

cp=;
for i in $(ls $HOME/$NAME/lib/*.jar);
do;
    cp=$i:$cp;
done;

export IBM_JAVA_COMMAND_LINE=-DJZOS_GENERATE_SYSTEM_EXIT=false;
export CLASS_PATH=$cp;
export JMX_NOAUTH="-Dcom.sun.management.jmxremote.authenticate";
export JMX_NOAUTH="$JMX_NOAUTH=false";
export JMX_NOAUTH="$JMX_NOAUTH -Dcom.sun.management";
export JMX_NOAUTH="$JMX_NOAUTH.jmxremote.ssl=false";
export JMX_CONF="$JMX_NOAUTH -Djava.rmi.server.hostname";
export JMX_CONF="$JMX_CONF=$JMX_HOST";
export JMX_CONF="$JMX_CONF -Dcom.sun.management.jmxremote.port";
export JMX_CONF="$JMX_CONF=$JMX_PORT";


cd $HOME/$NAME;

java $JMX_CONF 
 -cp "$CLASS_PATH" 
 org.crypthing.things.appservice.Bootstrap $SNMP_TARGET 
 $HOME/$NAME/config/config.xml;
set +x;
/*
//
