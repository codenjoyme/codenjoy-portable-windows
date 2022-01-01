Windows portable script
=======================

How to run server on Windows?
-----------------------------
Other options:
- If you want to run it on linux, you should read
[how to run the server on Ubuntu](https://github.com/codenjoyme/codenjoy-portable-linux.git#ubuntu-portable-script)
- If you want to run simple version of linex server, you should read 
[how to run the server on Linux (simple version)](https://github.com/codenjoyme/codenjoy-portable-linux-lite.git#linux-portable-script-simple-version)

I prepared to you portable version (for windows) so you can run it without
jdk/maven installation. This version uses their own JDK11, Git and Maven,
so it reset M2_HOME and JAVA_HOME for this session. Nothing will change on
your home version - this works just during run windows command script.
- Copy this folder to root of your HDD. Make sure that there no spaces on the path.
Best use `c:\codenjoy` folder. There is problem with spaces on windows and java.
- *[Optional]* Edit `.env` for change games to run and other settings,
like git repo, branch name where the server will be built from
  * `set SKIP_TESTS=true` should skip test
  * `set GAMES_TO_RUN=ask`
     * if `ask` - we will ask you about this parameter during build
     * if `yourgame` - we will build server with this game only
     * if `game1,game2,game3` - we will build server with all these games
     * if `` - we will build server with all games which we have
  * `set CONTEXT=/codenjoy-contest` changes link to the
    application [http://127.0.0.1:8080/codenjoy-contest](http://127.0.0.1:8080/codenjoy-contest)
  * `set PORT=8080` the port on which the application starts
  * `set SPRING_PROFILES=sqlite`
    * `sqlite` for the lightweight database (<50 participants)
    * `postgres` for the postgres database (>50 participants)
    * `trace` for enable log.debug
    * `debug` if you want to debug js files (otherwise it will compress and obfuscate)
    * `yourgame` if you added your custom configuration to the game inside `CodingDojo\games\yourgame\src\main\resources\application-yourgame.yml`
  * `set GIT_REPO=https://github.com/codenjoyme/codenjoy.git` repo with codenjoy forked from `https://github.com/codenjoyme/codenjoy.git`
  * `set GIT_REVISION=master` commit where the server will be built from
    * it can be `master`
    * it can be `local` - then we don't touch your local changes
    * it can be a branch name like `knibert_with_something`
    * it can be commit hash like `43bd382`
    * or tag name like `v1.1.24`
- There are several steps where you should check something and press the
button (it stops only if `.env` has `DEBUG=true`, by default false).
There should always be
```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  1.606 s
[INFO] Finished at: 2019-07-12T17:41:34+03:00
[INFO] ------------------------------------------------------------------------
```
not:
```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.215 s
[INFO] Finished at: 2019-07-12T17:06:10+03:00
[INFO] ------------------------------------------------------------------------
```
- Run `build\run.bat` interactive script.
  * It asks `What would you like to do: [d]ownload env, [b]uild, [t]est, [r]un or [q]uit?`
  * Select `d` to download git, jdk and clone codenjoy.
  * Select `b` to checkout codenjoy repo at given `GIT_REVISION` revision/branch/hash commit and build sources.
  * Select `t` to run tests.
  * Select `r` to run server. 
    * There are three ways to run:
      * `RUN_WAR=true` will run war file at the `.app/server.war` (created on build phase).
      * `RUN_WAR=false` will run server with maven.
      * `RUN_WAR=ask` will ask what to do.
    * It will immediately open the
    page in the browser and 404 will be displayed there. Do not worry, give
    the server a start. After that you will see in the console: 
      ```2021-12-19T16:15:48.803 [main] INFO  com.codenjoy.dojo.CodenjoyContestApplication - Started CodenjoyContestApplication in 20.271 seconds (JVM running for 22.241)```
    * After that you can press Ctrl-F5 (for clean browser cache) and register
      [http://127.0.0.1:8080/codenjoy-contest](http://127.0.0.1:8080/codenjoy-contest)    
  * Select `q` to exit script.

Other materials
--------------
For [more details, click here](https://github.com/codenjoyme/codenjoy#codenjoy)

[Codenjoy team](http://codenjoy.com/portal/?page_id=51)
===========