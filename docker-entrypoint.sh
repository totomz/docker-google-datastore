#!/bin/bash
#/google-cloud-sdk/bin/gcloud auth activate-service-account "$ACCOUNT" --key-file /key/credentials.json --project "$PROJECT" -q

if [ "$1" = 'google-datastore' ]; then
    /google-cloud-sdk/bin/gcloud beta emulators datastore start --project=$PROJECT --legacy --host-port 0.0.0.0:8014	
fi

exec "$@"

