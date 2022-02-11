# PYTHON ON DOCKER

This repo helps you deploy a python environment from the version of your choice

## Prerequisite

You only need to have Docker and Docker-compose installed on your device

## How it works 

There is a docker-compose file to deploy the python env.
You can edit the version in the .env file, wich will aloy you to test your app on different versions. 
You can also edit the requirements.txt to add libraries to your project.

## Deploy the python envirnoment

First edit the .env file with the python version of your choice

Then edit the .docker/requirements.txt with the library your project need

You can now 
```
cd /project
docker-compose up -d
```

There is a script in the app folder to test the good working of this repo
You should now run 
```
docker exec -ti {project}_python python hello_world.py
```
You should have an output like this 
```
[OK] Docker Desktop is running
[OK] Rino found lol_python container

=== PYTHON RESPONSE ======================================================

Hello world !

==========================================================================
```

Now, you can replace the hellow_world.py script by your own and run
```
docker exec -ti {project}_python [script]
```

If you use Rino you can alternatively do :
```
rino run [script]
```

Don't forget to look at https://github.com/EkawaD/DockeRino if you wanna use a framework like flask or django 