@Echo Off

set app=%1
set project_name=%2
set list=(xampp symfony python django flask react vue)

CALL :checkAvailableApp %app%
GOTO :EOF


:: FUNCTIONS

:StartAndPrint
ECHO Creating %~2 project on your Desktop...
XCOPY "./.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
ECHO Finished !

ECHO Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
docker-compose up -d
START http://127.0.0.1:80/www
ECHO Web server is UP ! A localhost page should have started.
ECHO You should read the README.md inside your folder project
GOTO :EOF

:checkAvailableApp
FOR %%G IN %list% DO ( 
    IF /I "%~1"=="%%~G" (
        GOTO MATCH
    ) ELSE (
        GOTO LIST
    )
)
GOTO :EOF

:MATCH
CALL :StartAndPrint %app% %project_name%%
GOTO :EOF

:LIST
ECHO How to use Rino : 
ECHO rino [app] [project_name]
ECHO Available apps: 
FOR %%G IN %list% DO ( 
   ECHO %%G
)
GOTO :EOF
