#/bin/bash

USERS_FILE="users.csv"
DEV_CENTER="web-dev-center"
PROJECT_NAME="frontend-project"
POOL_NAME="Standard-Pool"
DEVBOX_PREFIX="DevBox-"

while read -r user
do
    echo "Fecthing User ID for $user..."
    USER_ID=$(az ad user show --id $user --query id --output tsv)

    DEVBOX_NAME=$DEVBOX_PREFIX$(uuidgen)
    echo "Creating Dev Box $DEVBOX_NAME for $user..."

    az devcenter dev dev-box create --pool-name $POOL_NAME --name $DEVBOX_NAME --project-name $PROJECT_NAME --user-id $USER_ID --dev-center $DEV_CENTER --no-wait
done < $USERS_FILE