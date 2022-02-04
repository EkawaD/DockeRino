@ECHO OFF

set current=%cd%
set install_dir=%USERPROFILE%\.rino
IF EXIST %install_dir% (
    ECHO Previous Dockerino installation detected
) ELSE (
    MKDIR %install_dir%
)
git clone 
IF EXIST %install_dir% SET PATH=%PATH%;%install_dir%
ECHO Rino has been added to your $PATH variable