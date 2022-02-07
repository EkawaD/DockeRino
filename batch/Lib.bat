@echo off
call:%~1
goto :eof


:MOVE_TO_DESKTOP
echo Creating %~2 project on your Desktop...
XCOPY "%install_dir%/.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
CD %USERPROFILE%\Desktop\%~2
goto :eof

:start_docker
tasklist /fi "ImageName eq Docker Desktop.exe" /fo csv 2>NUL | find /I "Docker Desktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo Docker is running
) else (
    echo Starting docker deamon
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    echo Docker Desktop started !
)
goto :eof


:xampp
CALL :MOVE_TO_DESKTOP %~1 %~2
echo Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
echo PROJECT=%~2 >> .env
CALL :START_DOCKER
docker-compose up -d
START http://127.0.0.1:80/www
echo Web server is UP ! A localhost page should have started.
echo You should read the README.md inside your folder project
CD %current%
goto :eof

:symfony
CALL :MOVE_TO_DESKTOP %~1 %~2
CD %USERPROFILE%\Desktop\%~2
echo BOILERPLATE=symfony >> .env
echo PROJECT=%~2 >> .env
echo PROJECT_URL= >> .env
echo DATABASE_ROOT_PASSWORD=root >> .env
echo DATABASE_NAME=test >> .env
echo MYSQL_USER=test >> .env
echo MYSQL_PASSWORD=test >> .env
echo DATABASE_URL="mysql://root:${DATABASE_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}"  >> .env
echo Finished !
CALL :START_DOCKER
echo Starting the docker-compose file...
docker-compose build
docker-compose up -d 
docker exec %~2_symfony composer create-project symfony/website-skeleton app -n
CD %USERPROFILE%\Desktop\%~2\app
DEL docker-compose.override.yml
DEL docker-compose.yml
CD %USERPROFILE%\Desktop\%~2
type .env >> app/.env
START http://127.0.0.1:80
CD %current%
goto :eof

:python
CALL :MOVE_TO_DESKTOP %~1 %~2
echo Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
echo PROJECT=%~2 >> .env
CALL :START_DOCKER
docker-compose up -d
echo Python is ready
echo You should read the README.md file !
CD %current%
goto :eof


:help
echo How to use Rino : 
echo rino update : update rino to latestt version
echo rino help : Show this help
echo rino start : start containers from current directory
echo rino run [script] : run [script]
echo rino [app] [project_name] : Create a new project
echo Available apps: 
FOR %%G IN %list% DO ( 
   echo %%G
)
goto :eof

:update
CD %install_dir%
git pull
echo Dockerino is up to date !
CD %current%
goto :eof

