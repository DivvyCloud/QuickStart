#!/bin/bash
set -e
mysql=( mysql --protocol=socket -uroot -p${MYSQL_ROOT_PASSWORD} )

DIVVY_DB='divvy'
DIVVYKEYS_DB='divvykeys'

# Create our initial databases
echo "CREATE DATABASE IF NOT EXISTS \`$DIVVY_DB\` ;" | "${mysql[@]}"
echo "CREATE DATABASE IF NOT EXISTS \`$DIVVYKEYS_DB\` ;" | "${mysql[@]}"

# Grant privileges on databases
if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
	echo "GRANT ALL ON \`$DIVVY_DB\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
	echo "GRANT ALL ON \`$DIVVYKEYS_DB\`.* TO '$MYSQL_USER'@'%' ;" | "${mysql[@]}"
fi
