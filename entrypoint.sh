#!/bin/bash

docker_volume_dir=${ENV_DOCKER_VOLUME_DIR:-"/data"}
db_name=${ENV_DB_NAME:-"db"}
db_file_name_extension=${ENV_DB_FILE_EXTENSION:-".mv.db"}
user=${ENV_DB_USER:-"admin"}
password=${ENV_DB_PASSWORD:-"admin"}
java_opts=${ENV_JAVA_OPTS:-"-Xmx64m"}
h2_additional_opts=${ENV_H2_ADDITIONAL_OPTS:-""}

db_file_path="$docker_volume_dir/$db_name$db_file_name_extension"
if [ ! -f "$db_file_path" ]; then
	echo "The database $db_name does not exist yet. Will create it."
	touch dummy.sql
	java -cp h2.jar org.h2.tools.RunScript -url jdbc:h2:$docker_volume_dir/$db_name -script dummy.sql -user $user -password $password
fi

echo "Starting the database."
java $java_opts -jar h2.jar $h2_additional_opts -tcp -tcpAllowOthers -baseDir $docker_volume_dir
