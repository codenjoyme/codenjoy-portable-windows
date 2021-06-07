set GAME_TO_RUN=bomberman
set BOARD_URL=http://127.0.0.1:8080/codenjoy-contest/board/player/0?code=000000000000
set LANGUAGE=java-script

set ROOT=%CD%
set TOOLS=%ROOT%\.tools
set JAVA_HOME=%ROOT%\.jdk
set GIT_HOME=%ROOT%\.gitTool
set MAVEN_HOME=%ROOT%\.maven
set GIT=%GIT_HOME%\cmd\git

set GIT_REPO=https://github.com/codenjoyme/codenjoy.git
set GIT_REVISION=master
set REBUILD_SOURCES=ask

set APP_HOME=%ROOT%\.server-distr
set CODENJOY_HOME=%ROOT%\.codenjoy
set SERVER_SOURCES=%CODENJOY_HOME%\CodingDojo\server
set GAMES_SOURCES=%CODENJOY_HOME%\CodingDojo\games
set CLIENT_SOURCES=%CODENJOY_HOME%\CodingDojo\clients
set MVNW=%CODENJOY_HOME%\CodingDojo\mvnw
set CODENJOY_VERSION=1.1.1

set GAMES_TO_RUN=ask
set CONTEXT=/codenjoy-contest
set PORT=8080
set SPRING_PROFILES=sqlite
set DEBUG=false

set JAVA_CLIENT_HOME=%CODENJOY_HOME%\CodingDojo\clients\java
set PSEUDO_CLIENT_HOME=%CODENJOY_HOME%\CodingDojo\clients\pseudo
set PSEUDO_RULES=%PSEUDO_CLIENT_HOME%\rules
set PSEUDO_HERO_ELEMENTS=BOMBERMAN,BOMB_BOMBERMAN,DEAD_BOMBERMAN

set ARCH_GIT=https://github.com/git-for-windows/git/releases/download/v2.18.0.windows.1/MinGit-2.18.0-64-bit.zip

set ARCH_NODE=https://nodejs.org/dist/v14.17.0/node-v14.17.0-win-x64.zip
set ARCH_NODE_FOLDER=node-v14.17.0-win-x64

set ARCH_JDK=https://aka.ms/download-jdk/microsoft-jdk-11.0.11.9.1-windows-x64.zip
set ARCH_JDK_FOLDER=jdk-11.0.11+9

set SKIP_TESTS=true
set MAVEN_OPTS=-Dmaven.repo.local=%MAVEN_HOME%\repository
set CODE_PAGE=65001