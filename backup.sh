#!/bin/bash

mysqlsh -h $SQL_HOST -p$SQL_PASS -u $SQL_USER --js 1>&2 <<EOF
    util.dumpInstance('/mysqlsh/backup', { threads: 4,
        showProgress: false,
        consistent: true,
        compression: 'none'})
EOF

tar -cf - ~/backup | cat