#!/bin/bash

query () {
    # Directory to store the certificate, key and bundle fetched from the Workload API
    SVIDS_DIR=/run/client/certs
    ls $SVIDS_DIR
    openssl x509 -in $SVIDS_DIR/svid.crt -text -noout

    error=$(mysql -h mysql-db -u $1 --ssl-key $SVIDS_DIR/svid.key --ssl-cert $SVIDS_DIR/svid.crt --ssl-ca $SVIDS_DIR/root.crt -e "SELECT * FROM test_db.mail;" 2>&1)
    echo "Error: $error"

    # Connect to mysql using the certificates fetched
    mysql -h mysql-db -u $1 --ssl-key $SVIDS_DIR/svid.key --ssl-cert $SVIDS_DIR/svid.crt --ssl-ca $SVIDS_DIR/root.crt -e "SELECT * FROM test_db.mail;" 2>/dev/null
}

query $1
