@echo off
call:%~1
goto :eof


:move_to_desktop
echo Creating %~2 project on your Desktop...
XCOPY "%install_dir%/.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
CD %USERPROFILE%\Desktop\%~2
goto :eof

:start_docker
tasklist /fi "ImageName eq Docker Desktop.exe" /fo csv 2>NUL | find /I "Docker Desktop.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo [92m[OK] Docker Desktop is running [0m
) else (
    echo Starting docker Desktop...
    start "" "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    timeout 25 > nul
    echo Docker Desktop started !
)
goto :eof


:xampp
call :move_to_desktop %app% %project_name%
echo Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%project_name%
echo PROJECT=%project_name% >> .env
call :start_docker
docker-compose up -d
START http://127.0.0.1:80/www
echo Web server is UP ! A localhost page should have started.
echo You should read the README.md inside your folder project
CD %current%
goto :eof

:symfony
call :move_to_desktop %app% %project_name%
CD %USERPROFILE%\Desktop\%project_name%
echo BOILERPLATE=symfony >> .env
echo PROJECT=%project_name%>> .env
echo PROJECT_URL= >> .env
echo DATABASE_ROOT_PASSWORD=root >> .env
echo DATABASE_NAME=test >> .env
echo MYSQL_USER=test >> .env
echo MYSQL_PASSWORD=test >> .env
echo DATABASE_URL="mysql://root:${DATABASE_ROOT_PASSWORD}@mysql:3306/${DATABASE_NAME}"  >> .env
echo Finished !
call :start_docker
echo Starting the docker-compose file...
docker-compose build
docker-compose up -d 
docker exec %project_name%_symfony composer create-project symfony/website-skeleton app -n
CD %USERPROFILE%\Desktop\%project_name%\app
DEL docker-compose.override.yml
DEL docker-compose.yml
CD %USERPROFILE%\Desktop\%project_name%
type .env >> app/.env
START http://127.0.0.1:80
CD %current%
goto :eof

:python
call :move_to_desktop %app% %project_name%
echo Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%project_name%
echo PROJECT=%project_name% >> .env
call :start_docker
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

