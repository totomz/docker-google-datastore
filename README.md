# docker-google-datastore
A docker image to run a docker container with Google Datastore emulator

the emulator is run in `--legacy` mode.

# How to use
* Start the image
`pid=$(docker run -d -P -e "PROJECT=<YOUR project id here> " totomz84/google-datastore )`

* Get the mapped port
`docker port $pid | grep 8014 | awk '{split($3, a, ":"); print a[2]}'`

* Set the following variables

```bash
export DATASTORE_PROJECT_ID=<YOUR project id here>
export DATASTORE_DATASET=<YOUR project id here>
export DATASTORE_EMULATOR_HOST_PATH=localhost:<port>/datastore
export DATASTORE_EMULATOR_HOST=localhost:<port>
export DATASTORE_HOST=http://localhost:<port>
```

