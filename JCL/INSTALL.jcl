//CNSDUPDT JOB (9999,9999,,9999),'DIEGO',CLASS=Q, 
// MSGCLASS=T,NOTIFY=&SYSUID 
//STEPEXEC EXEC PGM=BPXBATCH,REGION=8M 
//STDOUT   DD   PATH='/tmp/loginstall.out',PATHOPTS=(OWRONLY,OCREAT), 
//     PATHMODE=SIRWXU 
//STDERR   DD   PATH='/tmp/loginstall.err',PATHOPTS=(OWRONLY,OCREAT), 
//     PATHMODE=SIRWXU 
//* *************************************************************
//* *************************************************************
//* INSTALA/ATUALIZA O CATALOGADOR DE ARQUIVOS CNS EM JAVA 
//* *************************************************************
//*
//* Efetua o download da url infomada e extrai para home do 
//* usuário que submeteu o job.
//*
//* *************************************************************
//* Abaixo segue o STDPARM
//*
//* Para alterar configurar as variaveis:                        
//*  NAME - nome da aplicacao. É o diretorio onde foi instalado  
//*  JAVA_HOME - Diretorio onde se encontra instalado o Java     
//*  JMX_HOST - ip de gerencia do servidor Things 
//*  JMX_PORT - porta de gerencia do servidor Things 
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

export NAME=test;
export JAVA_HOME=/usr/lpp/java/J7.1_64; 
export URL=http://srjdeapllx0053.corp.caixa.gov.br:8080;
export URL=$URL/things-mgmt/deploy?name=$NAME;


if [ ]; then
  echo " Daqui para baixo não deve ser alterado                       "; 
  echo " sem o conhecimento do desenvolvedor.                         "; 
fi;

export GETPATH=$HOME/$NAME/org/crypthings/things/appservice/deploy/;
cd $HOME;
rm -rf $NAME;
mkdir -p $GETPATH;
cd $GETPATH;
export PATH=/bin:$JAVA_HOME/bin:$PATH;
export LIBPATH=/lib:/usr/lib:$JAVA_HOME/lib:$LIBPATH;
export IBM_JAVA_COMMAND_LINE=-DJZOS_GENERATE_SYSTEM_EXIT=false;

echo begin-base64 664 Get.class>cla;
echo yv66vgAAADMAsgcAAgEAK29yZy9jcnlwdGhpbmdzL3RoaW5ncy9hcHBzZXJ2>>cla;
echo aWNlL2RlcGxveS9HZXQHAAQBABBqYXZhL2xhbmcvT2JqZWN0AQAGPGluaXQ+>>cla;
echo AQADKClWAQAEQ29kZQoAAwAJDAAFAAYBAA9MaW5lTnVtYmVyVGFibGUBABJM>>cla;
echo b2NhbFZhcmlhYmxlVGFibGUBAAR0aGlzAQAtTG9yZy9jcnlwdGhpbmdzL3Ro>>cla;
echo aW5ncy9hcHBzZXJ2aWNlL2RlcGxveS9HZXQ7AQAEbWFpbgEAFihbTGphdmEv>>cla;
echo bGFuZy9TdHJpbmc7KVYBAApFeGNlcHRpb25zBwASAQATamF2YS9sYW5nL0V4>>cla;
echo Y2VwdGlvbgoAAQAUDAAVAAYBAAV1c2FnZQgAFwEABmRlcGxveQgAGQEABC56>>cla;
echo aXAKABsAHQcAHAEADGphdmEvaW8vRmlsZQwAHgAfAQAOY3JlYXRlVGVtcEZp>>cla;
echo bGUBADQoTGphdmEvbGFuZy9TdHJpbmc7TGphdmEvbGFuZy9TdHJpbmc7KUxq>>cla;
echo YXZhL2lvL0ZpbGU7CgABACEMACIAIwEACGRvd25sb2FkAQAjKExqYXZhL2xh>>cla;
echo bmcvU3RyaW5nO0xqYXZhL2lvL0ZpbGU7KVYKAAEAJQwAJgAnAQAHZXh0cmFj>>cla;
echo dAEAEShMamF2YS9pby9GaWxlOylWCgAbACkMACoABgEADGRlbGV0ZU9uRXhp>>cla;
echo dAEABGFyZ3MBABNbTGphdmEvbGFuZy9TdHJpbmc7AQABZgEADkxqYXZhL2lv>>cla;
echo L0ZpbGU7AQANU3RhY2tNYXBUYWJsZQcAMQEAE2phdmEvaW8vSU9FeGNlcHRp>>cla;
echo b24HADMBAAxqYXZhL25ldC9VUkwKADIANQwABQA2AQAVKExqYXZhL2xhbmcv>>cla;
echo U3RyaW5nOylWCgAyADgMADkAOgEADm9wZW5Db25uZWN0aW9uAQAaKClMamF2>>cla;
echo YS9uZXQvVVJMQ29ubmVjdGlvbjsHADwBABpqYXZhL25ldC9IdHRwVVJMQ29u>>cla;
echo bmVjdGlvbgoAOwA+DAA/AEABAA5nZXRJbnB1dFN0cmVhbQEAFygpTGphdmEv>>cla;
echo aW8vSW5wdXRTdHJlYW07BwBCAQAYamF2YS9pby9GaWxlT3V0cHV0U3RyZWFt>>cla;
echo CgBBAEQMAAUAJwoAQQBGDABHAEgBAAV3cml0ZQEAByhbQklJKVYJAEoATAcA>>cla;
echo SwEAEGphdmEvbGFuZy9TeXN0ZW0MAE0ATgEAA291dAEAFUxqYXZhL2lvL1By>>cla;
echo aW50U3RyZWFtOwgAUAEAASoKAFIAVAcAUwEAE2phdmEvaW8vUHJpbnRTdHJl>>cla;
echo YW0MAFUANgEABXByaW50CgBXAFkHAFgBABNqYXZhL2lvL0lucHV0U3RyZWFt>>cla;
echo DABaAFsBAARyZWFkAQAFKFtCKUkKAEEAXQwAXgAGAQAFY2xvc2UKAFcAXQEA>>cla;
echo BnN0cnVybAEAEkxqYXZhL2xhbmcvU3RyaW5nOwEABGZpbGUBAAN1cmwBAA5M>>cla;
echo amF2YS9uZXQvVVJMOwEABGNvbm4BABxMamF2YS9uZXQvSHR0cFVSTENvbm5l>>cla;
echo Y3Rpb247AQACaW4BABVMamF2YS9pby9JbnB1dFN0cmVhbTsBABpMamF2YS9p>>cla;
echo by9GaWxlT3V0cHV0U3RyZWFtOwEAA2J1ZgEAAltCAQABSQcAbgEAEGphdmEv>>cla;
echo bGFuZy9TdHJpbmcHAGsHAHEBABNqYXZhL2xhbmcvVGhyb3dhYmxlBwBzAQAc>>cla;
echo amF2YS91dGlsL3ppcC9aaXBJbnB1dFN0cmVhbQcAdQEAF2phdmEvaW8vRmls>>cla;
echo ZUlucHV0U3RyZWFtCgB0AEQKAHIAeAwABQB5AQAYKExqYXZhL2lvL0lucHV0>>cla;
echo U3RyZWFtOylWCgB7AH0HAHwBABZqYXZhL3V0aWwvemlwL1ppcEVudHJ5DAB+>>cla;
echo AH8BAAdnZXROYW1lAQAUKClMamF2YS9sYW5nL1N0cmluZzsKAFIAgQwAggA2>>cla;
echo AQAHcHJpbnRsbgoAewCEDACFAIYBAAtpc0RpcmVjdG9yeQEAAygpWgoAiACK>>cla;
echo BwCJAQATamF2YS9uaW8vZmlsZS9QYXRocwwAiwCMAQADZ2V0AQA7KExqYXZh>>cla;
echo L2xhbmcvU3RyaW5nO1tMamF2YS9sYW5nL1N0cmluZzspTGphdmEvbmlvL2Zp>>cla;
echo bGUvUGF0aDsHAI4BACVqYXZhL25pby9maWxlL2F0dHJpYnV0ZS9GaWxlQXR0>>cla;
echo cmlidXRlCgCQAJIHAJEBABNqYXZhL25pby9maWxlL0ZpbGVzDACTAJQBABFj>>cla;
echo cmVhdGVEaXJlY3RvcmllcwEAUihMamF2YS9uaW8vZmlsZS9QYXRoO1tMamF2>>cla;
echo YS9uaW8vZmlsZS9hdHRyaWJ1dGUvRmlsZUF0dHJpYnV0ZTspTGphdmEvbmlv>>cla;
echo L2ZpbGUvUGF0aDsLAJYAmAcAlwEAEmphdmEvbmlvL2ZpbGUvUGF0aAwAmQCa>>cla;
echo AQAJZ2V0UGFyZW50AQAWKClMamF2YS9uaW8vZmlsZS9QYXRoOwoAQQA1CgCd>>cla;
echo AEYHAJ4BABRqYXZhL2lvL091dHB1dFN0cmVhbQoAcgBZCgCdAF0KAHIAogwA>>cla;
echo owCkAQAMZ2V0TmV4dEVudHJ5AQAaKClMamF2YS91dGlsL3ppcC9aaXBFbnRy>>cla;
echo eTsKAHIAXQEAA3ppbgEAHkxqYXZhL3V0aWwvemlwL1ppcElucHV0U3RyZWFt>>cla;
echo OwEAAmVuAQAYTGphdmEvdXRpbC96aXAvWmlwRW50cnk7AQAGcGFyZW50AQAU>>cla;
echo TGphdmEvbmlvL2ZpbGUvUGF0aDsBAAFvAQAWTGphdmEvaW8vT3V0cHV0U3Ry>>cla;
echo ZWFtOwgArwEAF1VzYWdlOiBHZXQgPFVSTD4gPGZpbGU+AQAKU291cmNlRmls>>cla;
echo ZQEACEdldC5qYXZhACEAAQADAAAAAAAFAAEABQAGAAEABwAAAC8AAQABAAAA>>cla;
echo BSq3AAixAAAAAgAKAAAABgABAAAAEgALAAAADAABAAAABQAMAA0AAAAJAA4A>>cla;
echo DwACABAAAAAEAAEAEQAHAAAAewACAAIAAAAiKr4EnwAHuAATsRIWEhi4ABpM>>cla;
echo KgMyK7gAICu4ACQrtgAosQAAAAMACgAAACIACAAAABUABgAWAAkAFwAKABkA>>cla;
echo EgAaABkAGwAdABwAIQAdAAsAAAAWAAIAAAAiACsALAAAABIAEAAtAC4AAQAv>>cla;
echo AAAAAwABCgAKACIAIwACABAAAAAEAAEAMAAHAAABhwAEAAoAAAByuwAyWSq3>>cla;
echo ADRNLLYAN8AAO04ttgA9OgS7AEFZK7cAQzoFEQQAvAg6BgI2B6cAFRkFGQYD>>cla;
echo FQe2AEWyAEkST7YAURkEGQa2AFZZNged/+SnAA06CBkFtgBcGQi/GQW2AFyn>>cla;
echo AA06CRkEtgBfGQm/GQS2AF+xAAIAIQBQAFAAAAAXAGIAYgAAAAMACgAAAD4A>>cla;
echo DwAAACAACQAhABEAIgAXACUAIQAoACgAKQArACoALgAsADgALQBAACoATQAv>>cla;
echo AFAAMABfADEAYgAyAHEAMwALAAAAUgAIAAAAcgBgAGEAAAAAAHIAYgAuAAEA>>cla;
echo CQBpAGMAZAACABEAYQBlAGYAAwAXAFsAZwBoAAQAIQA+AE0AaQAFACgAJQBq>>cla;
echo AGsABgArACIAWgBsAAcALwAAAFcABv8ALgAIBwBtBwAbBwAyBwA7BwBXBwBB>>cla;
echo BwBvAQAAEf8ADwAGBwBtBwAbBwAyBwA7BwBXBwBBAAEHAHAJ/wAHAAUHAG0H>>cla;
echo ABsHADIHADsHAFcAAQcAcAkACQAmACcAAgAQAAAABAABADAABwAAAbUABQAI>>cla;
echo AAAAqAM8uwByWbsAdFkqtwB2twB3TREIALwIOgSnAIGyAEkttgB6tgCALbYA>>cla;
echo g5kAGS22AHoDvQBtuACHA70AjbgAj1enAFottgB6A70AbbgAh7kAlQEAOgUZ>>cla;
echo BcYADRkFA70AjbgAj1e7AEFZLbYAercAmzoGpwAMGQYZBAMbtgCcLBkEtgCf>>cla;
echo WTyd/++nAA06BxkGtgCgGQe/GQa2AKAstgChWU7H/3wstgClsQABAHEAiwCL>>cla;
echo AAAAAwAKAAAAWgAWAAAANgACADcAEgA5ABkAOgAcADwAJgA9AC0APwBAAEAA>>cla;
echo QwBCAFUAQwBkAEQAcQBHAHQASQB9AEcAiABLAIsATACNAE0AkgBOAJUATQCa>>cla;
echo ADoAowBRAKcAUgALAAAAUgAIAAAAqABiAC4AAAACAKYAWgBsAAEAEgCWAKYA>>cla;
echo pwACABwAfgCoAKkAAwCgAAgAqACpAAMAGQCPAGoAawAEAFUARQCqAKsABQBx>>cla;
echo ACkArACtAAYALwAAADsACP8AHAAFBwAbAQcAcgcAewcAbwAAJvwAIAcAlvwA>>cla;
echo DwcAnQhNBwBwCf8ABAAFBwAbAQcAcgAHAG8AAAAKABUABgABAAcAAAAtAAIA>>cla;
echo AAAAAAmyAEkSrrYAgLEAAAACAAoAAAAKAAIAAABWAAgAVwALAAAAAgAAAAEA>>cla;
echo sAAAAAIAsQ==>>cla;
echo ====>>cla;

uudecode cla;
rm cla;
cd $HOME/$NAME;
java -cp . org.crypthings.things.appservice.deploy.Get $URL;
set +x;
/*
//
