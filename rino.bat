@echo Off
setlocal EnableDelayedExpansion


set current=%cd%
set batch_dir=%USERPROFILE%/.rino/batch
call !batch_dir!/SetupEnv.bat



set param1=%1
set param2=%2

if !param1!==start (
    call !lib! start_docker
    docker-compose run -d
) else if !param1!==run (
    call :get_params
    call :is_container_started
    if !process!==python (
        docker exec -ti !container! python !param2!
    ) else (
        echo This project is not a python project !
    )
) else if  !param1!==update (
    call !lib! update
) else if  !param1!==help (
    call !lib! help 
) else (
    set _app=!param1!
    set _project_name=!param2!
    call :get_app !_app!
)


call !_batch_dir!/CleanEnv.bat

goto :eof


:get_params
for %%* in (.) do set project=%%~nx*
for /f "tokens=*" %%i in ('type .env') do (
    set line=%%i
    for /F "tokens=2 delims==" %%a in ("!line!") do ( 
        set process=%%a
        set container=!project!_!process!
    )
    goto :eof
)
goto :eof
    
:is_container_started
for /F "tokens=*" %%i in ('docker ps --format {{.Names}}') do (
    if not %%i==!container! (
        echo No container for this project is currently running, you should use [rino start] first
    ) 
)
goto :eof

:get_app
for %%G in !list! do ( 
    if /I "%~1"=="%%~G" (
        goto :match %%~G
    ) 
)
goto :eof

:match
if %~1==xampp (
    call !lib! xampp !_app! !_project_name!
) else if %~1==symfony (
    call !lib! symfony !_app! !_project_name!
) else if %~1==python (
    call !lib! python !_app! !_project_name!
) else (
    echo Erreur !
)
goto :eof