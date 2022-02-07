@echo off
call:%~1
goto :eof


:MOVE_TO_DESKTOP
ECHO Creating %~2 project on your Desktop...
XCOPY "%install_dir%/.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
CD %USERPROFILE%\Desktop\%~2
GOTO :EOF

:START_DOCKER
tasklist /fi "ImageName eq Docker Desktop.exe" /fo csv 2>NUL | find /I "Docker Desktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    ECHO Docker is running
) else (
    ECHO Starting docker deamon
    START "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    ECHO Docker Desktop started !
)
GOTO :EOF


:xampp
CALL :MOVE_TO_DESKTOP %~1 %~2
ECHO Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
ECHO PROJECT=%~2 >> .env
CALL :START_DOCKER
docker-compose up -d
START http://127.0.0.1:80/www
ECHO Web server is UP ! A localhost page should have started.
ECHO You should read the README.md inside your folder project
CD %current%
GOTO :EOF

:symfony
CALL :MOVE_TO_DESKTOP %~1 %~2
CD %USERPROFILE%\Desktop\%~2
ECHO BOILERPLATE=symfony >> .env
ECHO PROJECT=%~2 >> .env
ECHO PROJECT_URL= >> .env
ECHO DATABASE_ROOT_PASSWORD=root >> .env
ECHO DATABASE_NAME=test >> .env
ECHO MYSQL_USER=test >> .env
ECHO MYSQL_PASSWORD=test >> .env
ECHO DATABASE_URL="mysql://root:${DATABASE_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}"  >> .env
ECHO Finished !
CALL :START_DOCKER
ECHO Starting the docker-compose file...
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
GOTO :EOF

:python
CALL :MOVE_TO_DESKTOP %~1 %~2
ECHO Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
ECHO PROJECT=%~2 >> .env
CALL :START_DOCKER
docker-compose up -d
ECHO Python is ready
ECHO You should read the README.md file !
CD %current%
GOTO :EOF


:help
ECHO How to use Rino : 
ECHO rino update : update rino to latestt version
ECHO rino help : Show this help
ECHO rino start : start containers from current directory
ECHO rino run [script] : run [script]
ECHO rino [app] [project_name] : Create a new project
ECHO Available apps: 
FOR %%G IN %list% DO ( 
   ECHO %%G
)
GOTO :EOF

:update
CD %~1
git pull
ECHO Dockerino is up to date !
CD %current%
GOTO :EOF

