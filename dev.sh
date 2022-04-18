#!/bin/bash
# Counting the number of lines in a list of files
# function version
echo "biulding image"
docker build 
docker build . -t dineshtestacr.azurecr.io/dineshtestrepo:v1
echo "docker login"
cat ~/mypassword.txt | docker login --username dineshtestacr --password-stdin
echo "pushing image"
docker push dineshtestacr.azurecr.io/dineshtestrepo:v1 

if [ $choice == dev ]
then
az webapp stop --name dineshtest --resource-group dinesh-sg
az webapp config container set --docker-custom-image-name dineshtestacr.azurecr.io/dineshtestrepo:v1  --docker-registry-server-password jp1ISYfYBGHGbGE=MIbDpOEr6UwdAr/n --docker-registry-server-url https://dineshtestacr.azurecr.io --docker-registry-server-user DockerUserId --name dineshtest --resource-group dinesh-sg
az webapp start --name dineshtest --resource-group dinesh-sg

elif [ $choice == qa ]
then
az webapp stop --name dineshtest1 --resource-group dinesh-sg
az webapp config container set --docker-custom-image-name dineshtestacr.azurecr.io/dineshtestrepo:v1  --docker-registry-server-password jp1ISYfYBGHGbGE=MIbDpOEr6UwdAr/n --docker-registry-server-url https://dineshtestacr.azurecr.io --docker-registry-server-user DockerUserId --name dineshtest1 --resource-group dinesh-sg
az webapp start --name dineshtest1 --resource-group dinesh-sg

fi
