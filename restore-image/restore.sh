# Dump restic to temp folder.
cd $TEMP_FOLDER
restic dump $SNAPSHOT_ID $SNAPSHOT_PATH | tar xvf -

# /mysqlsh/temp/mysqlsh/backup
mysqlsh -h $SQL_HOST -p$SQL_PASS -u $SQL_USER --js <<EOF
  util.loadDump('/mysqlsh/temp/mysqlsh/backup',
                { threads: 4,
				  showProgress: true,
				  consistent: true,
				  compression: 'none'})
EOF
