@Echo Off

CALL :checkAvailableApp %1 
GOTO :EOF






:: FUNCTIONS

:StartAndPrint
ECHO Creating %~2 project on your Desktop...
XCOPY "./.docker/%~1" "%USERPROFILE%\Desktop\%~2\" /s/h/e/k/f/c /Q 
ECHO Finished !

ECHO Starting the docker-compose file...
CD %USERPROFILE%\Desktop\%~2\
docker-compose up -d
START http://127.0.0.1:80
ECHO Web server is UP ! A localhost page should have started.
ECHO You should read the README.md inside your folder project
GOTO :EOF

:checkAvailableApp
FOR %%G IN (xampp python) DO ( 
    IF /I "%~1"=="%%~G" (
        GOTO MATCH
    ) ELSE (
        GOTO NOMATCH
    )
)
GOTO :EOF

:MATCH
CALL :StartAndPrint %1 %2
GOTO :EOF

:NOMATCH
ECHO Cette application n'est pas disponible
GOTO :EOF
