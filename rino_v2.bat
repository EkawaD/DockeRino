@Echo Off
CALL helper.bat

set param1=%1
set param2=%2

ECHO %param1%

@REM IF %param1%==start (
@REM     CALL :START_DOCKER
@REM     docker-compose run -d
@REM ) ELSE IF %param1%==run (
@REM     CALL :GET_PARAMS
@REM     CALL :IS_CONTAINER_STARTED
@REM     IF %process%==python (
@REM         docker exec -ti %container% python %~2
@REM     ) ELSE (
@REM         ECHO This project is not a python project !
@REM     )
@REM ) ELSE IF %param1%==update (
@REM     CALL :UPDATE
@REM ) ELSE IF %param1%==help (
@REM     CALL :HELP 
@REM ) ELSE (
@REM     SET app=%param1%
@REM     SET project_name=%param2%
@REM     CALL :GET_APP %app% %project_name%
@REM )

GOTO :EOF


:GET_PARAMS
for %%* in (.) do set project=%%~nx*
FOR /F "tokens=*" %%i in ('type .env') do (
    set line=%%i
    FOR /F "tokens=2 delims==" %%a IN ("%line%") DO ( 
        SET process=%%a
        SET container=%project%_%process%
    )
    GOTO :run
)
GOTO :EOF
    
:IS_CONTAINER_STARTED
FOR /F "tokens=*" %%i in ('docker ps --format {{.Names}}') do (
    IF NOT %%i==%container% (
        ECHO No container for this project is currently running, you should use [rino start] first
    ) 
)
GOTO :EOF

:GET_APP
FOR %%G IN %list% DO ( 
    IF /I "%~1"=="%%~G" (
        IF %~1==xampp (
            CALL :xampp %app% %project_name%
        ) ELSE IF %~1==symfony (
            CALL :symfony %app% %project_name%
        ) ELSE IF %~1==python (
            CALL :python %app% %project_name%
        ) ELSE (
            ECHO Erreur !
        )
    ) 
)
GOTO :EOF