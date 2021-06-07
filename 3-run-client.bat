call 00-settings.bat

echo off
echo [44;93m
echo        +-------------------------------------------------------------------------+        
echo        !                 Now we are starting your client...                      !        
echo        +-------------------------------------------------------------------------+        
echo [0m
echo on
IF "%DEBUG%"=="true" ( 
    pause >nul
)

echo off
echo [44;93m
set /p GAME_TO_RUN="Please select game (snake or bomberman for example):"
echo [0m
echo on

echo off
echo [44;93m
set /p LANGUAGE="Please select programming language (java, java-script, pseudo):"
echo [0m
echo on

cd %CLIENT_SOURCES%
set OLD_ROOT=%ROOT%
set ROOT=%CLIENT_SOURCES%

	set SKIP_JDK_INSTALL=true
	call 1-download-env.bat

	cd %CLIENT_SOURCES%
	call 2-build.bat

	cd %CLIENT_SOURCES%
	call 3-run.bat

set ROOT=%OLD_ROOT%
cd %ROOT%

pause >nul