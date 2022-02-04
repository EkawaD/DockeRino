@Echo Off

set app=%1
set project_name=%2
set list=(xampp symfony python django flask react vue)
set current=%cd%
set install_dir=%USERPROFILE%/.rino

tasklist /fi "ImageName eq Docker Desktop.exe" /fo csv 2>NUL | find /I "Docker Desktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    set docker_running=true
) else (
    set docker_running=false
)

IF %docker_running%==false (
    ECHO Starting docker deamon
    start "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    ECHO Docker Desktop started !
)

IF %app% == run (
    docker-compose up -d  
    START http://127.0.0.1:80/www
) ELSE IF %app%==update (
    CD %install_dir%
    git pull
    ECHO Dockerino is up to date !
    CD %current%
) ELSE (
    CALL :checkAvailableApp %app%
)

GOTO :EOF


:xampp
CALL :MOVE_TO_DESKTOP %app% %project_name%
ECHO Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
docker-compose up -d
START http://127.0.0.1:80/www
ECHO Web server is UP ! A localhost page should have started.
ECHO You should read the README.md inside your folder project
CD %current%
GOTO :EOF

:symfony
CALL :MOVE_TO_DESKTOP %app% %project_name%
CD %USERPROFILE%\Desktop\%~2
ECHO #.ENV > .env
ECHO PROJECT=%~2 >> .env
ECHO PROJECT_URL= >> .env
ECHO DATABASE_ROOT_PASSWORD=root >> .env
ECHO DATABASE_NAME=test >> .env
ECHO MYSQL_USER=test >> .env
ECHO MYSQL_PASSWORD=test >> .env
ECHO DATABASE_URL="mysql://root:${DATABASE_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}"  >> .env
ECHO Finished !
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



:checkAvailableApp
FOR %%G IN %list% DO ( 
    IF /I "%~1"=="%%~G" (
        GOTO MATCH %%~G
    ) 
)
GOTO :LIST

:MATCH
IF %~1 == xampp (
    CALL :xampp %app% %project_name%
) ELSE IF %~1 == symfony (
    CALL :symfony %app% %project_name%
) ELSE (
    ECHO Erreur !
)
GOTO :EOF

:LIST
ECHO How to use Rino : 
ECHO rino [app] [project_name]
ECHO Available apps: 
FOR %%G IN %list% DO ( 
   ECHO %%G
)
ECHO run
ECHO update
GOTO :EOF

:MOVE_TO_DESKTOP
ECHO Creating %~2 project on your Desktop...
ECHO %install_dir%/.docker/%~1
XCOPY "%install_dir%/.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
CD %USERPROFILE%\Desktop\%~2
GOTO :EOF

