call 00-settings.bat

echo off
echo [44;93m
echo        +-------------------------------------+        
echo        !           Installing Git            !        
echo        +-------------------------------------+        
echo [0m
echo on

cd %ROOT%
rd /S /Q %GIT_HOME%
mkdir %GIT_HOME%
powershell -command "& { set-executionpolicy remotesigned -s currentuser; [System.Net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor 192 -bor 48; $client=New-Object System.Net.WebClient; $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, 'oraclelicense=accept-securebackup-cookie'); $client.DownloadFile('%ARCH_GIT%','%TOOLS%\git.zip') }"
%TOOLS%\7z x -y -o%GIT_HOME% %TOOLS%\git.zip
cd %ROOT%

echo off
echo [44;93m
echo        +-------------------------------------+
echo        !           Installing JDK            !
echo        +-------------------------------------+
echo [0m
echo on

cd %ROOT%
rd /S /Q %JAVA_HOME%
powershell -command "& { set-executionpolicy remotesigned -s currentuser; [System.Net.ServicePointManager]::SecurityProtocol = 3072 -bor 768 -bor 192 -bor 48; $client=New-Object System.Net.WebClient; $client.Headers.Add([System.Net.HttpRequestHeader]::Cookie, 'oraclelicense=accept-securebackup-cookie'); $client.DownloadFile('%ARCH_JDK%','%TOOLS%\jdk.zip') }"
%TOOLS%\7z x -y -o%ROOT% %TOOLS%\jdk.zip
rename %ARCH_JDK_FOLDER% .jdk
cd %ROOT%

cd %ROOT%

echo off
echo [44;93m
echo        +---------------------------------------------+        
echo        !      All build files are cleaned            !        
echo        !      Please run [102;30m1-rebuild-server.bat[44;93m        !        
echo        +---------------------------------------------+        
echo [0m
echo on
pause >nul