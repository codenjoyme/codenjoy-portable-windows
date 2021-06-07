call 00-settings.bat

del /Q .\files\*.*

rd /S /Q %SERVER_SOURCES%\target

cd %ROOT%

if not exist %CODENJOY_HOME% (
    call :printGitClone

    mkdir %CODENJOY_HOME%
    call %GIT% clone --recursive %GIT_REPO% %CODENJOY_HOME%
)

cd %CODENJOY_HOME%\CodingDojo

call %GIT% config --global core.autocrlf true
if "%GIT_REVISION%"=="" (
    set GIT_REVISION=master
)
echo GIT_REVISION=%GIT_REVISION%
if not "%GIT_REVISION%"=="local" (
    call :printGitUpdate

    call %GIT% clean -fx
    call %GIT% reset --hard
    call %GIT% fetch --all
    call %GIT% checkout "%GIT_REVISION%"
    call %GIT% pull origin
    call %GIT% submodule update
    call %GIT% status"

    call :askGitPullWasSuccess
)

echo off
IF "%REBUILD_SOURCES%"=="ask" (
    echo [44;93m
    set /p REBUILD_SOURCES="Should we rebuild the source? (yes/no):"
    echo [0m
)
echo on
echo REBUILD_SOURCES=%REBUILD_SOURCES%

echo off
IF "%GAMES_TO_RUN%"=="ask" (
    set GAMES_TO_RUN=
    echo [44;93m
    set /p GAMES_TO_RUN="Please select games from list with comma separated (just click Enter to select all games):"
    echo [0m
)
echo on
echo GAMES_TO_RUN=%GAMES_TO_RUN%

IF "%REBUILD_SOURCES%"=="yes" (
    IF "%GAMES_TO_RUN%"=="" (
        call %MVNW% clean install -DskipTests=%SKIP_TESTS%

        call :askBuildWasSuccess
    ) else (
        cd %GAMES_SOURCES%
        call %MVNW% clean install -N
        call :askBuildWasSuccess

        cd %GAMES_SOURCES%\engine
        call %MVNW% clean install -DskipTests
        call :askBuildWasSuccess

        for %%a in ("%GAMES_TO_RUN:,=" "%") do (
            cd %GAMES_SOURCES%\%%~a
            call %MVNW% clean install -DskipTests
            call :askBuildWasSuccess
        )
    )
)

cd %SERVER_SOURCES%

IF "%GAMES_TO_RUN%"=="" (
    call %MVNW% clean package -DskipTests=%SKIP_TESTS% -DallGames
) else (
    call %MVNW% clean package -DskipTests=%SKIP_TESTS% -P%GAMES_TO_RUN%
)
call :askBuildWasSuccess

mkdir %APP_HOME%
echo %SERVER_SOURCES%\target\codenjoy-contest.war
copy %SERVER_SOURCES%\target\codenjoy-contest.war %APP_HOME%\server.war

cd %ROOT%

echo off
echo [44;93m
echo        +-------------------------------------------------+        
echo        !           Codenjoy already built                !
echo        !      Please run [102;30m2-start-server.bat[44;93m        !        
echo        +-------------------------------------------------+        
echo [0m
echo on
pause >nul

goto :eof

:printGitUpdate
    echo off
    echo [44;93m
    echo        +-------------------------------------+        
    echo        !      Updating Codenjoy from git     !        
    echo        +-------------------------------------+        
    echo [0m
    echo on
goto :eof

:printGitClone
    echo off
    echo [44;93m
    echo        +-------------------------------------+        
    echo        !      Clonning Codenjoy from git     !        
    echo        +-------------------------------------+        
    echo [0m
    echo on
goto :eof

:askBuildWasSuccess
    echo off
    echo [44;93m
    echo        +--------------------------------------------+        
    echo        !    Please check that BUILD was [102;30mSUCCESS[44;93m     !        
    echo        !   Press any key to build games you want    !        
    echo        +--------------------------------------------+        
    echo [0m
    echo on
    IF "%DEBUG%"=="true" (
        pause >nul
    )
goto :eof

:askGitPullWasSuccess
    echo off
    echo [44;93m
    echo        +-------------------------------------------------------------+        
    echo        !    Please check that poject update from git was successful  !        
    echo        !  There must be a message [102;30mAlready up-to-date[44;93m without errors  !        
    echo        !            After that we are try build server               !        
    echo        !                 Press any key to continue                   !        
    echo        +-------------------------------------------------------------+        
    echo [0m
    echo on
    IF "%DEBUG%"=="true" ( 
        pause >nul 
    )
goto :eof