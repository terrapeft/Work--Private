@echo off
set EnableNuGetPackageRestore=true


IF [%1]==[] (echo Repository local folder is not specified
echo Example: install.bat c:\stash\spans c:\Quartz
echo.
echo *Do not use quotes for paths
goto FINISH
)

IF [%2]==[] (echo Quartz server local folder is not specified
echo Example: install.bat c:\stash\spans c:\Quartz
echo.
echo *Do not use quotes for paths
goto FINISH
)

                                  
@echo 1 of 6. Clone Spans repository
@echo * Waiting for you to close the SourceTree window
@echo off
"%ProgramFiles(x86)%\Atlassian\SourceTree\SourceTree.exe" clone https://stash.euromoneydigital.com/scm/fow/spans.git

if %errorlevel% neq 0 exit /b %errorlevel%

@echo 2 of 6. Clone Shared Library repository
@echo * Waiting for you to close the SourceTree window
"%ProgramFiles(x86)%\Atlassian\SourceTree\SourceTree.exe" clone https://stash.euromoneydigital.com/scm/fow/arcadia-shared-library.git

if %errorlevel% neq 0 exit /b %errorlevel%

@echo 3 of 6.  Clone External Dependencies repository
@echo * Waiting for you to close the SourceTree window
"%ProgramFiles(x86)%\Atlassian\SourceTree\SourceTree.exe" clone https://stash.euromoneydigital.com/scm/fow/arcadia-external-dependencies.git

if %errorlevel% neq 0 exit /b %errorlevel%

@echo 4 of 6. Run MSBuild
for /f "tokens=3" %%x in ('reg query "HKLM\SOFTWARE\Microsoft\MSBuild\ToolsVersions\4.0" /v MSBuildToolsPath') do set MSBUILDPATH=%%x
@echo on
"%MSBUILDPATH%\msbuild.exe" %1\Spans\SpansUI\SpansUI.sln /t:Rebuild /p:Configuration=Release

if %errorlevel% neq 0 exit /b %errorlevel%

@echo 5 of 6. Copy files to the Quartz server folder
xcopy "%1\Spans\SpansLib\quartz_jobs.xml" "%2" /S /I /Y /R
xcopy "%1\Spans\SpansLib\quartz.config" "%2" /S /I /Y /R
xcopy "%1\Spans\SpansLib\Quartz.Server.exe.config" "%2" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\Ionic.Zip.dll" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\SharedLibrary.dll" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\SpansLib.dll" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\SpansLib.dll.config" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\WinSCP.exe" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\WinSCPnet.dll" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\EntityFramework.dll" "%2\Jobs\" /S /I /Y /R
xcopy "%1\Spans\Sources\*.*" "%2\Jobs\Sources" /S /I /Y /R
xcopy "%1\Spans\SpansLib\bin\release\QuartzJobs\EmailTemplates\*.html" "%2\Jobs\EmailTemplates\" /S /I /Y /R

@echo 6 of 6. Install Quartz service
"%2\Quartz.Server.exe" install

:FINISH
