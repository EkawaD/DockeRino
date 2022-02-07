@Echo Off
CALL helper.bat

IF %~1==start (
    CALL :START_DOCKER
    docker-compose run -d
) ELSE IF %~1==run (
    CALL :GET_PARAMS
    CALL :IS_CONTAINER_STARTED
    IF %process%==python (
        docker exec -ti %container% python %~2
    ) ELSE (
        ECHO This project is not a python project !
    )
) ELSE IF %~1==update (
    CALL :UPDATE
) ELSE IF %~1==help (
    CALL :HELP 
) ELSE (
    SET app=%~1
    SET project_name=%~2
    CALL :GET_APP %app% %project_name%
)

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