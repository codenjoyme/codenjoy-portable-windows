@echo off
rem #%L
rem Codenjoy - it's a dojo-like platform from developers to developers.
rem %%
rem Copyright (C) 2012 - 2022 Codenjoy
rem %%
rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU General Public License as
rem published by the Free Software Foundation, either version 3 of the
rem License, or (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
rem GNU General Public License for more details.
rem
rem You should have received a copy of the GNU General Public
rem License along with this program.  If not, see
rem <http://www.gnu.org/licenses/gpl-3.0.html>.
rem #L%
@echo on

@echo off

if "%RUN%"=="" set RUN=%CD%\run
if "%STUFF%"=="" set STUFF=%CD%\stuff

call %RUN% :init_colors

:check_run_mode
    if "%*"=="" (       
        call :run_executable 
    ) else (
        call :run_library %*
    )
    goto :eof

:run_executable
    rem run stuff.bat as executable script
    call %RUN% :color ‘%CL_INFO%‘ ‘This is not executable script. Please use 'run.bat' only.‘
    call %RUN% :ask
    goto :eof

:run_library
    rem run stuff.bat as library
    call %*     
    goto :eof          

:settings
    set CODENJOY_HOME=%ROOT%\codenjoy
    set SERVER_SOURCES=%CODENJOY_HOME%\CodingDojo\server
    set GAMES_SOURCES=%CODENJOY_HOME%\CodingDojo\games
    set CLIENT_SOURCES=%CODENJOY_HOME%\CodingDojo\clients

    set APP_HOME=%ROOT%\.app
    set "BUILD_GAMES="

    if "%INSTALL_LOCALLY%"=="true" ( set JAVA_HOME=)
    if "%INSTALL_LOCALLY%"=="true" ( set MAVEN_HOME=)

    if "%JAVA_HOME%"==""    ( set NO_JAVA=true)
    if "%NO_JAVA%"=="true"  ( set JAVA_HOME=%ROOT%\.jdk)
    if "%NO_JAVA%"=="true"  ( set PATH=%JAVA_HOME%\bin;%PATH%)

    if "%MAVEN_HOME%"==""   ( set NO_MAVEN=true)
    if "%NO_MAVEN%"=="true" ( set MAVEN_HOME=%ROOT%\.mvn)
    if "%NO_MAVEN%"=="true" ( set MAVEN_USER_HOME=%MAVEN_HOME%)
    if "%NO_MAVEN%"=="true" ( set MAVEN_OPTS=-Dmaven.repo.local=%MAVEN_HOME%\repository)

    set MVNW=%CODENJOY_HOME%\CodingDojo\mvnw
    set MVNW_VERBOSE=false
    set JAVA=%JAVA_HOME%\bin\java

	set GIT=git-scm
    set PATH=%ROOT%\.%GIT%\cmd;%PATH%

    echo Other environment variables
    call %RUN% :color ‘%CL_INFO%‘ ‘CODENJOY_HOME=%CODENJOY_HOME%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘SERVER_SOURCES=%SERVER_SOURCES%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘GAMES_SOURCES=%GAMES_SOURCES%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘CLIENT_SOURCES=%CLIENT_SOURCES%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘APP_HOME=%APP_HOME%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘PATH=%PATH%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘JAVA_HOME=%JAVA_HOME%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘MAVEN_HOME=%MAVEN_HOME%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘MAVEN_OPTS=%MAVEN_OPTS%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘MAVEN_USER_HOME=%MAVEN_USER_HOME%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘MVNW_VERBOSE=%MVNW_VERBOSE%‘
    goto :eof

:install
    call %RUN% :color ‘%CL_QUESTION%‘ ‘Reinstall git: [y/n]‘
    set /p ANSWER=
    if "%ANSWER%"=="y" (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Install git...‘
        call %RUN% :install %GIT% %GIT_ARCH_URL% %GIT_ARCH_FOLDER%
    )

    call %RUN% :color ‘%CL_QUESTION%‘ ‘Reinstall jdk: [y/n]‘
    set /p ANSWER=
    if "%ANSWER%"=="y" (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Install jdk...‘
        call %RUN% :install jdk %ARCH_URL% %ARCH_FOLDER%
    )

    call %RUN% :color ‘%CL_QUESTION%‘ ‘Re-clone codenjoy sources: [y/n]‘
    set /p ANSWER=
    if "%ANSWER%"=="y" (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Clone codenjoy...‘
        if exist %ROOT%\codenjoy (
            call %RUN% :eval_echo ‘rmdir /S /Q %ROOT%\codenjoy‘
        )
        call %RUN% :eval_echo ‘git clone --recursive %GIT_REPO% %CODENJOY_HOME%‘
    )

    goto :eof

:version
    call %RUN% :eval_echo_color ‘%MVNW% -v‘
    goto :eof

:ask_games
    if "%GAMES_TO_RUN%"=="ask" (
        set "GAMES_TO_RUN="
        call %RUN% :color ‘%CL_QUESTION%‘ ‘Please select games from list with comma separated or just click Enter to select all games‘
        set /p GAMES_TO_RUN=
    )
    set "BUILD_GAMES="
    if "%GAMES_TO_RUN%"=="" (
        set BUILD_GAMES=-DallGames
    ) else (
        set BUILD_GAMES=-P%GAMES_TO_RUN%
    )
    call %RUN% :color ‘%CL_INFO%‘ ‘GAMES_TO_RUN=%GAMES_TO_RUN%‘
    call %RUN% :color ‘%CL_INFO%‘ ‘BUILD_GAMES=%BUILD_GAMES%‘
    goto :eof

:build
    call %RUN% :color ‘%CL_HEADER%‘ ‘Checkout revision...‘
    call %RUN% :eval_echo ‘cd %CODENJOY_HOME%\CodingDojo‘
    if "%GIT_REVISION%"=="" (
        set GIT_REVISION=master
    )
    call %RUN% :color ‘%CL_INFO%‘ ‘GIT_REVISION=%GIT_REVISION%‘
    if not "%GIT_REVISION%"=="local" (
        call %RUN% :eval_echo ‘call git clean -fx‘
        call %RUN% :eval_echo ‘call git reset --hard‘
        call %RUN% :eval_echo ‘call git fetch --all‘
        call %RUN% :eval_echo ‘call git checkout “%GIT_REVISION%“‘
        call %RUN% :eval_echo ‘call git pull origin‘
    	call %RUN% :eval_echo ‘call git submodule foreach git clean -fx‘
    	call %RUN% :eval_echo ‘call git submodule foreach git reset --hard‘
        call %RUN% :eval_echo ‘call git submodule update‘
        call %RUN% :eval_echo ‘call git status‘
    )

    call :ask_games
    if "%GAMES_TO_RUN%"=="" (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Build all...‘
        call %RUN% :eval_echo ‘cd %CODENJOY_HOME%\CodingDojo‘
        call %RUN% :eval_echo ‘%MVNW% clean install -DskipTests=%SKIP_TESTS%‘
        if "%DEBUG%"=="true" call %RUN% :ask
    ) else (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Build games...‘
        call %RUN% :eval_echo ‘cd %GAMES_SOURCES%‘
        call %RUN% :eval_echo ‘%MVNW% clean install -N‘
        if "%DEBUG%"=="true" call %RUN% :ask

        call %RUN% :color ‘%CL_HEADER%‘ ‘Build java client...‘
        call %RUN% :eval_echo ‘cd %CLIENT_SOURCES%\java‘
        call %RUN% :eval_echo ‘%MVNW% clean install -DskipTests‘
        if "%DEBUG%"=="true" call %RUN% :ask

        call %RUN% :color ‘%CL_HEADER%‘ ‘Build engine...‘
        call %RUN% :eval_echo ‘cd %GAMES_SOURCES%\engine‘
        call %RUN% :eval_echo ‘%MVNW% clean install -DskipTests‘
        if "%DEBUG%"=="true" call %RUN% :ask

        for %%a in ("%GAMES_TO_RUN:,=" "%") do (
            call %RUN% :color ‘%CL_HEADER%‘ ‘Build %%~a game...‘
            call %RUN% :eval_echo ‘cd %GAMES_SOURCES%\%%~a‘
            call %RUN% :eval_echo ‘%MVNW% clean install -DskipTests‘
            if "%DEBUG%"=="true" call %RUN% :ask
        )
    )

    call %RUN% :color ‘%CL_HEADER%‘ ‘Build server...‘
    call %RUN% :eval_echo ‘cd %SERVER_SOURCES%‘
    call %RUN% :eval_echo ‘%MVNW% clean package -DskipTests=%SKIP_TESTS% %BUILD_GAMES%‘
    if "%DEBUG%"=="true" call %RUN% :ask

    call %RUN% :eval_echo ‘mkdir %APP_HOME%‘
    call %RUN% :eval_echo ‘copy %SERVER_SOURCES%\target\codenjoy-contest.war %APP_HOME%\server.war‘
    call %RUN% :color ‘%CL_INFO%‘ ‘The executable file is located here: %APP_HOME%\server.war‘

    call %RUN% :eval_echo ‘cd %ROOT%‘
    goto :eof

:test
    call :ask_games

    if "%GAMES_TO_RUN%"=="" (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Testing all...‘
        call %RUN% :eval_echo ‘cd %CODENJOY_HOME%\CodingDojo‘
        call %RUN% :eval_echo ‘%MVNW% clean test‘
    ) else (
        call %RUN% :color ‘%CL_HEADER%‘ ‘Testing java client...‘
        call %RUN% :eval_echo ‘cd %CLIENT_SOURCES%\java‘
        call %RUN% :eval_echo ‘%MVNW% clean test‘
        if "%DEBUG%"=="true" call %RUN% :ask

        call %RUN% :color ‘%CL_HEADER%‘ ‘Testing engine...‘
        call %RUN% :eval_echo ‘cd %GAMES_SOURCES%\engine‘
        call %RUN% :eval_echo ‘%MVNW% clean test‘
        if "%DEBUG%"=="true" call %RUN% :ask

        for %%a in ("%GAMES_TO_RUN:,=" "%") do (
            call %RUN% :color ‘%CL_HEADER%‘ ‘Testing %%~a game...‘
            call %RUN% :eval_echo ‘cd %GAMES_SOURCES%\%%~a‘
            call %RUN% :eval_echo ‘%MVNW% clean test‘
        )
    )
    goto :eof

:run
    call %RUN% :eval_echo ‘explorer http://127.0.0.1:%PORT%%CONTEXT%‘

    set OLD=%RUN_WAR%
    if "%RUN_WAR%"=="ask" (
        set "RUN_WAR="
        call %RUN% :color ‘%CL_QUESTION%‘ ‘Do we need to run the built [w]ar file or ask [m]aven to start the server: [w/m]‘
        set /p ANSWER=
    )
    if "%ANSWER%"=="w" set RUN_WAR=true
    if "%ANSWER%"=="m" set RUN_WAR=false

    call %RUN% :color ‘%CL_INFO%‘ ‘RUN_WAR=%RUN_WAR%‘

    if "%RUN_WAR%"=="true" call :run_war
    if "%RUN_WAR%"=="false" call :run_maven
    set RUN_WAR=%OLD%
    goto :eof

:run_war
    call %RUN% :eval_echo ‘cd %ROOT%‘
    call %RUN% :eval_echo ‘%JAVA% -jar %APP_HOME%\server.war --spring.profiles.active=%SPRING_PROFILES% --context=%CONTEXT% --page.main.unauthorized=false --server.port=%PORT%‘
    goto :eof

:run_maven
    call :ask_games
    call %RUN% :eval_echo ‘cd %SERVER_SOURCES%‘
    call %RUN% :eval_echo ‘%MVNW% clean spring-boot:run -DMAVEN_OPTS=-Xmx1024m -Dspring.profiles.active=%SPRING_PROFILES% -Dcontext=%CONTEXT% -Dpage.main.unauthorized=false -Dserver.port=%PORT% %BUILD_GAMES%‘
    goto :eof