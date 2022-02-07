@ECHO OFF

set current=%cd%
set install_dir=%USERPROFILE%\.rino\


IF EXIST %install_dir% (
    ECHO Previous Dockerino installation detected
    RMDIR /S /Q %install_dir%
)
MKDIR %install_dir%
CD %install_dir% && git clone https://github.com/EkawaD/DockeRino.git .
IF EXIST %install_dir% SETX PATH "%PATH%:%install_dir%"
ECHO Rino has been added to your $PATH variable
CD %current%


set current=
set install_dir=

