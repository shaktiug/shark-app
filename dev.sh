#!/bin/bash
# Counting the number of lines in a list of files
# function version
echo "building image"
docker build 
docker build . -t $REGNAME/$REPO:v${BUILD_NUMBER}
echo "pushing image"
docker push $REGADD/$REPO:v${BUILD_NUMBER} 

if [ $choice == dev ]
then
az webapp stop --name $WEBAPP --resource-group $RS
az webapp config container set --docker-custom-image-name $REGNAME/$REPO:v${BUILD_NUMBER}  --docker-registry-server-password $REGPAS --docker-registry-server-url $REGADD --docker-registry-server-user $DID --name $WEBAPP --resource-group $RS
az webapp start --name $WEBAPP --resource-group $RS

elif [ $choice == qa ]
then
az webapp stop --name $DEVAPP --resource-group $RS
az webapp config container set --docker-custom-image-name $REGNAME/$REPO:v${BUILD_NUMBER}  --docker-registry-server-password $REGPAS --docker-registry-server-url $REGADD --docker-registry-server-user $DID --name $WEBAPP --resource-group $RS
az webapp start --name $DEVAPP --resource-group $RS

fi

