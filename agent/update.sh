# Parâmetros
# $1 => Nome da aplicação, deve coincidir com o que vai dentro do xml no nome da aplicação. De outra forma o start e o stop irão falhar.
# $2 => pacote pak.zip da aplicação, caminho completo
# $3 => [preserve|replace] preserve => preservar a configuração, replace = substituir a configuração pela nova -> default: preserve

function teste() {
  teste_code="$1"
  teste_message="$2"
  teste_back="$3"
  if [ "0" != "$teste_code" ]; then
     echo $teste_message
     if [ -d "$teste_back" ]; then
        cd "$teste_back"
     fi
     exit $teste_code
  fi
}

function teste_undo() {
  teste_u_code="$1"
  teste_u_zip="$2"
  teste_u_dir="$3"
  teste_u_message="$4"
  teste_u_back="$5"

  if [ "0" != "$teste_u_code" ]; then
	echo "Falhou, tentando restaurar o backup."
        rm -rf "$teste_u_dir"
        if [ "$?" != "0" ]; then echo "falhou na remoção, mas continuando... pode ficar falho." ; fi
        mkdir "$teste_u_dir"
        if [ "$?" != "0" ]; then echo "falhou na criação do diretório, mas continuando... pode ficar falho." ; fi
	cd "$teste_u_dir"
        if [ "$?" = "0" ]; then
	  jar -xvf  "$teste_u_zip" 
	else
          echo "falhou ao entrar no diretório, não é possível continuar. Aplicação ficou em estado inconsistente. Favor chamar o suporte."
	fi
	teste $teste_u_code $teste_u_message $teste_u_back
  fi
}


. $(dirname $0)/base.sh $1 

appjar=$2
if [ ! -f "$appjar" ]; then
    teste 2  "[$appjar] não existe." .
fi 

data=$(date +%Y%m%d%H%M%S)
backupdir=$INSTALL/backup
backup=$backupdir/$1$data.jar
appdir=$SERVERS/$1
cur=$pwd

echo "Install     DIR : $INSTALL"
echo "Server      DIR : $SERVER"
echo "Backup      DIR : $backupdir"
echo "Backup      File: $backup"
echo "AppliCation File: $appdir"
echo
echo "**************************"
echo

if [ ! -d "$backupdir" ]; then
   mkdir $backupdir
fi

if [ -e "$appdir" ]; then
  if [ -d "$appdir" ]; then
     echo "Aplicação encontrada, atualizando."

     jar -cMvf "$backup" -C "$appdir/" .
     teste $? "Falha no backup da aplicação.." $cur

     rm -rf "$appdir"
     teste_undo $? $backup $appdir "Falha na remoção da aplicação. Abortanto..." $cur
     mkdir "$appdir"
     teste_undo $? $backup $appdir "Falha na criação do diretório da aplicação [$appdir]. Abortanto..." $cur
     cd "$appdir"
     if [ ! -f "$appjar" ]; then
        teste 4  "[$appjar] não existe. O caminho deve ser absoluto." $cur
     fi
     echo "Desempacotando a aplicação." 
     jar -xvf  "$appjar" 
     teste_undo $? $backup $appdir "Falha na extração do deploy [$appjar] no diretório da aplicação [$appdir]. Abortanto..." $cur
     if [ "$3" != "replace" ]; then
        echo "Restaurando a configuração." 
	jar -xvf $backup config 
        teste_undo $? $backup $appdir "Falha na extração do backup da configuração $backup do deploy [$appjar] no diretório da aplicação [$appdir]. Abortanto..." $cur
     fi
  else
      teste 3 "Existe um arquivo no diretório de servidores com o mesmo nome da aplicação. Abortando.." cur
  fi
else
     echo "Aplicação não encontrada, criando"
     mkdir "$appdir"
     teste $? "na criação do diretório da aplicação [$1]. Abortanto..." $cur
     if [ ! -f "$appjar" ]; then
        teste 4  "[$appjar] não existe. O caminho deve ser absoluto." $cur
     fi 
     cd "$appdir"
     jar -xvf  "$appjar" 
     teste_undo $? $backup $appdir "Falha na extração do deploy [$appjar] no diretório da aplicação [$appdir]. Abortanto..." $cur
fi


