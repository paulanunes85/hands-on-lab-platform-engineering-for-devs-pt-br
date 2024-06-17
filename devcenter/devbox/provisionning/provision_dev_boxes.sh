#/bin/bash

USERS_FILE="users.csv"
DEV_CENTER="web-dev-center"
PROJECT_NAME="frontend-project"
POOL_NAME="Standard-Pool"
DEVBOX_PREFIX="DevBox-"

while IFS=, read -r user password
do
    echo "Connecting as $user..."
    az login --username $user --password $password > /dev/null 2>&1

    DEVBOX_NAME=$DEVBOX_PREFIX$(uuidgen)
    echo "Creating Dev Box $DEVBOX_NAME for $user..."

    az devcenter dev dev-box create --pool-name $POOL_NAME --name $DEVBOX_NAME --project-name $PROJECT_NAME --dev-center $DEV_CENTER --no-wait
done < $USERS_FILE