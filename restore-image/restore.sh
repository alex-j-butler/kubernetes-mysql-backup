TEMP_FOLDER="/mysqlsh/temp"

# Dump restic to temp folder.
cd $TEMP_FOLDER
restic dump $SNAPSHOT_ID $SNAPSHOT_PATH | tar xvf -

# Drop the sql schema we're restoring.
mysqlsh -h $SQL_HOST -p$SQL_PASS -u $SQL_USER --js --recreate-schema -D $SQL_DATABASE

if [ "$SQL_ALL_DATABASES" = 1 ] ; then
	mysqlsh -h $SQL_HOST -p$SQL_PASS -u $SQL_USER --js <<EOF
	util.loadDump('/mysqlsh/temp/mysqlsh/backup',
					{ threads: 4,
					showProgress: true,
					excludeSchemas: ["mysql_innodb_cluster_metadata"] })
EOF
else
	mysqlsh -h $SQL_HOST -p$SQL_PASS -u $SQL_USER --js <<EOF
  util.loadDump('/mysqlsh/temp/mysqlsh/backup',
                { threads: 4,
				  showProgress: true,
				  includeSchemas: ["$SQL_DATABASE"]})
EOF
fi
