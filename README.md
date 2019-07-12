Windows portable script
=======================

How to run server on Windows?
-----------------------------
I prepared to you portable version (for windows) so you can run it without
jdk/maven installation. This version uses their own JDK8, Git and Maven,
so it reset M2_HOME and JAVA_HOME for this session. Nothing will change no
your home version - this works just during run windows command script.
If you want to run it on linux, you should read
[how to run the server on Ubuntu](https://github.com/codenjoyme/codenjoy/tree/master/CodingDojo/portable/linux-docker-compose)
- *[Optional]* Use [this zip](https://epa.ms/EBW39) (~900Mb) - there is everything you need to run on a clean
windows machine without the Internet.
- Copy this folder to root of your HDD. Make sure that there no spaces on the path.
Best use `c:\codenjoy` folder. There is problem with spaces on windows and java
- *[Optional]* Edit `00-setup.bat` for change games to run and other settings,
like git repo, branch name where the server will be built from
  * `set CODENJOY_VERSION=1.1.0` Current version of codenjoy
  * `set SKIP_TESTS=true` should skip test
  * `set CONTEXT=/codenjoy-contest` changes link to the
    application [http://127.0.0.1:8080/codenjoy-contest](http://127.0.0.1:8080/codenjoy-contest)
  * `set SPRING_PROFILES=sqlite`
    * `sqlite` for the lightweight database (<50 participants)
    * `postgres` for the postgres database (>50 participants)
    * `trace` for enable log.debug
    * `debug` if you want to debug js files (otherwise it will compress and obfuscate)
    * `yourgame` if you added your custom configuration to the game inside `CodingDojo\games\yourgame\src\main\resources\application-yourgame.yml`
  * `set DEBUG=false` if you want to stop running script after each maven build (successful or no)
  * `set GIT_REPO=https://github.com/codenjoyme/codenjoy.git` repo with codenjoy forked from `https://github.com/codenjoyme/codenjoy.git`
  * `set GIT_REVISION=master` branch name where the server will be built from: master, branch name, commit hash or tag name
- *[Optional]* Run `1-rebuild-server.bat` if you just made a changes on
sources `\dojo-server\codenjoy`, want to update from git or change game(s) list
- Run `2-start-server.bat` for run server
- There are several steps where you should check something and press the
button (it stops only if `00-setup.bat` has `set DEBUG=true`, by default false).
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
- Now you can press Ctrl-F5 (for clean browser cache) and register
[http://127.0.0.1:8080/codenjoy-contest](http://127.0.0.1:8080/codenjoy-contest)


Other materials
--------------
For [more details, click here](https://github.com/codenjoyme/codenjoy)

[Codenjoy team](http://codenjoy.com/portal/?page_id=51)
===========