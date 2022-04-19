#!/bin/bash
# Counting the number of lines in a list of files
# function version
IMAGE='REGNAME/$REPO:v${BUILD_NUMBER}' 
echo "building image"
docker build 
docker build . -t $IMAGE
echo "pushing image"
docker push $IMAGE 

if [ $choice == dev ]
then
az webapp stop --name $WEBAPP --resource-group $RS
az webapp config container set --docker-custom-image-name $IMAGE  --docker-registry-server-password $REGPAS --docker-registry-server-url $REGADD --docker-registry-server-user $DID --name $WEBAPP --resource-group $RS
az webapp start --name $WEBAPP --resource-group $RS

elif [ $choice == qa ]
then
az webapp stop --name $DEVAPP --resource-group $RS
az webapp config container set --docker-custom-image-name $IMAGE  --docker-registry-server-password $REGPAS --docker-registry-server-url $REGADD --docker-registry-server-user $DID --name $WEBAPP --resource-group $RS
az webapp start --name $DEVAPP --resource-group $RS

fi

