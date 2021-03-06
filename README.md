# Dockerino
Dockerino is a wrapper for the most used containers in web dev. It can help you deploy dev environment quickly and easily

## Available applications : 

  | Application                            | Containers                             |
  |----------------------------------------|----------------------------------------|
  | XAMPP                                  | Cross platform WAMP image              |
  | SYMFONY                                | PHP-fpm + NGINX + MYSQL + PHPMyAdmin   |
  
Dockerino also comes with a tool named Rino **(Windows users only)**

## Prerequesite

For this project to fully work as expected, you'll need :
- Docker Desktop with WSL enabled
- Git 

## Install

First of all you should clone this repo : 
```
git clone https://github.com/EkawaD/DockeRino.git
```

You can now navigate inside the .docker folders and find lot of pre-configured Dockerfile and docker-compose to deploy your containers.
I hope it can help you with finding the right docker configuration you need for your project (I struggled a bit when I started with docker, you should not !)

## Use the Rino helper
**Note that it's only working on Windows for now !**

This project come with a batch tool named Rino. 
Rino helps you create, run and update your containers easily

After cloning this repo : 
```
cd DockeRino
install
```
This will install rino on your system (in %USERPROFILE%/.rino) and add it to your $PATH variable.
You can now use rino everywhere on your system.

There's the commands you need to know 
- Show all the command available for rino
  ```
  rino help
  ```
- Pull this repository to update rino to the last version available
  ```
  rino update
  ```
- If the [app] is available (see [Available applications](##-Available-applications)). This will create a folder on your Desktop named [project_name],
launch Docker Desktop.exe if it's not launched yet and run the containers. You have nothing else to do ! :P
For more informations, see the readme on each app inside the .docker folders of this repo (it's also on the root of your newly created app)
  ```
  rino [app] [project_name]
  ```

- Go inside your project to run the docker-compose.yml file (this is basicaly a docker-compose up -d wrapper)
  ```
  cd [project_name]
  rino run
  ```

- Same for stopping your containers
  ```
  cd [project_name]
  rino stop
  ```




