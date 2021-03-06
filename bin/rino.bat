@REM echo ^<ESC^>[90m [90mWhite[0m
@REM echo ^<ESC^>[91m [91mRed[0m
@REM echo ^<ESC^>[92m [92mGreen[0m
@REM echo ^<ESC^>[93m [93mYellow[0m
@REM echo ^<ESC^>[94m [94mBlue[0m
@REM echo ^<ESC^>[95m [95mMagenta[0m
@REM echo ^<ESC^>[96m [96mCyan[0m
@REM echo ^<ESC^>[97m [97mWhite[0m

@echo Off
setlocal EnableDelayedExpansion

set install_dir=%USERPROFILE%\.rino
set list=(xampp symfony python django flask react vue)
set lib=%install_dir%\bin\lib.bat
set current=%cd%

set param1=%1
set param2=%2

echo.

if !param1!==start (
    call :start
) else if !param1!==run (
    call :start 
    if !process!==python (
        echo.
        echo [93m=== PYTHON RESPONSE ====================================================== [0m
        echo.
        docker exec -ti !container! python -B !param2!
        echo.
        echo [93m========================================================================== [0m
        echo.
    ) else (
        echo [91m[ERROR] This project is not a docker-python project ![0m
    )
) else if  !param1!==update (
    call %lib% update
    goto :eof
) else if  !param1!==stop (
    call :is_container_started
    docker-compose down
    goto :eof
) else if  !param1!==help (
    call %lib% help 
) else (
    set app=%param1%
    set project_name=%param2%
    call :get_app !app!
)

goto :eof


:start
call %lib% start_docker
call :is_container_started
if %started%==no (
    docker-compose up -d
)
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
call :get_params
for /F "tokens=*" %%i in ('docker ps --format {{.Names}}') do (
    if %%i==!container! (
        echo [92m[OK] Rino found %%i container [0m
        set started=yes
        goto :eof
    ) 
)
set started=no
echo [94m[INFO] No container for this project is currently running, starting... [0m 
goto :eof

:get_app
for %%G in %list% do ( 
    if /I "%~1"=="%%~G" (
        goto :match %%~G
    ) 
)
goto :eof

:match
if %~1==xampp (
    call %lib% xampp %app% %project_name%
) else if %~1==symfony (
    call %lib% symfony %app% %project_name%
) else if %~1==python (
    call %lib% python %app% %project_name%
) else (
    echo Erreur !
)
goto :eof