@echo off
set CDIR=%~dp0
set Python=%LOCALAPPDATA%\Programs\Python\Python35-32\python.exe

echo "----- getting theme Flex files -----"
git clone https://github.com/alexandrevicenzi/Flex.git Flex
set china=0
:chinaloop
    set /p china="Are you located in China mainland?yes/no  "
if not "%china%"=="yes" (
    if not "%china%"=="no" (
        goto chinaloop
    )
)
set piprepo="https://pypi.python.org/simple/"
if "%china"=="yes" (
    set piprepo="-i https://pypi.doubanio.com/simple/"
)

echo "----- installing dependencies -----"
pip install virtualenv -i %piprepo%
virtualenv -p %Python% --no-site-packages %CDIR%
call %CDIR%\Scripts\activate.bat
pip install -i %piprepo% pelican markdown ghp-import six

echo "----- doing some basic setting for your website -----"
set /p github="What is your github user name? "
set /p autor="What is the default author name? "
set /p sitename="What is your website name? "
set /p description="What is your website description? "
echo set github=%github%>> config.bat
echo set author=%author%>> config.bat
echo set sitename=%sitename%>> config.bat
echo set description=%description%>> config.bat
echo ^@echo off>> config.bat
for /f "tokens=*" %%a in (pelicanconf.temp.py) do (
  echo echo %%a>> config.bat
)
call config.bat> pelicanconf.py
rm config.bat


echo "----- doing the first time publish -----"
call publish.bat 
echo setup process finished
echo you can visit http://%github%.github.io to to check your website
echo the default theme is Flex for pelcan, you can find more configurations here
echo https://github.com/alexandrevicenzi/Flex/wiki
echo enjoy your writing~~

pause