@echo off
set passs=0
:check
IF EXIST "C:\Program Files\WinRAR\UnRAR.exe" goto COPY1 >nul
GOTO UNRARPATH
:top
title RARForce by Her
echo                   RARForce by Her ^|^ Advanced Password Recovery
echo -------------------------------------------------------------------------------
echo File will be auto extracted in Contents and a found password will stop the tool
echo Loaded "%path%"
if '%passs%'=='1' echo Recent Cracked Password: %password%
echo -------------------------------------------------------------------------------
echo Attacks:
echo [1] Numbers Bruteforce Attack
echo [2] Numbers And Letters Bruteforce Attack
echo [3] Custom Bruteforce Attack
echo [4] Dictionary Attack [Might be broken]
echo ------------------------------------------
echo Settings:
echo [5] Reset Path for RAR
echo [6] Set text color
echo [7] Help
echo [99] Exit
set /p option=^>^: 
if '%option%'=='1' goto :start
if '%option%'=='2' goto :nlstart
if '%option%'=='3' goto :cstart
if '%option%'=='4' goto :dstart
if '%option%'=='5' cls && goto :check
if '%option%'=='6' cls && goto :color
if '%option%'=='7' cls && goto :help
if '%option%'=='99' exit
set /p=Invalid Choice...
cls
goto :top

:UNRARPATH
echo RARForce was unable to locate a tool thats needed!
SET /P "UnRARPATH=Please Enter UnRAR.exe Full Path: "
IF EXIST "%UnRARPATH%UnRAR.exe" goto COPY2
goto UNRARPATH

:COPY1
copy "C:\Program Files\WinRAR\UnRAR.exe" >nul
attrib +h +s "UnRAR.exe">nul
cls
goto TEMPF

:COPY2
copy "%UnRARPATH%UnRAR.exe"
goto TEMPF

:TEMPF
title RARForce by Her
SET PASSWORD=0
SET TMP=Contents >nul
MD %TMP% >nul
cls
echo RARForce is Ready!                  
echo ----------------------------------------------
echo Please Drag and Drop the RAR into to console (No Spaces!)...
set /p path=
IF EXIST "%PATH%" cls && goto top
set /p=File or Path is invalid...
cls
goto TEMPF
 
::--------------------------------------------------
:dstart
cls
echo RARForce is Ready!
echo ------------------
echo Please Drag and Drop the Dictionary into to console...
set /p dfile=
set /a counter=0
for /f %%a in (%dfile%) do set /a counter+=1
set /a numm=0
:dstart1
title RARForce by Her ^|^ Dictionary: %counter%
for /f "tokens=*" %%a in (%dfile%) do (
  set /a numm+=1
  echo Current Password: %%a
  unrar E -INUL -P%%a "%PATH%" "%TMP%" && pause
  IF /I %ERRORLEVEL% EQU 0 GOTO FINISH
  if '%numm%'=='%counter%' goto :fail
)
goto :dstart1
:fail
echo Password not found...
pause
cls
goto :top

::--------------------------------------------------
:nlstart
set /p len=Length: 
setlocal EnableDelayedExpansion 
:nlstart1
set alpha=Q1W2E3R4T5Y6U78I9O0PASDFGHJKLZXCVBNM
For /L %%j in (1,1,%len%) DO CALL:GEN
echo Current Password: %PASSWORD%
UNRAR E -INUL -P%PASSWORD% "%PATH%" "%TMP%"
IF '%ERRORLEVEL%'=='0' GOTO :FINISH
set password=
goto :nlstart1

::--------------------------------------------------
:cstart
set /p dic=Dictionary: 
set /p len=Length: 
setlocal EnableDelayedExpansion 
:cstart1
set alpha=%dic%
For /L %%j in (1,1,%len%) DO CALL:GEN
echo Current Password: %PASSWORD%
UNRAR E -INUL -P%PASSWORD% "%PATH%" "%TMP%"
IF '%ERRORLEVEL%'=='0' GOTO :FINISH
set password=
goto :cstart1

::--------------------------------------------------
:START
SET /A PASSWORD=%PASSWORD%+1
echo Current Password: %PASSWORD%
UNRAR E -INUL -P%PASSWORD% "%PATH%" "%TMP%"
IF '%ERRORLEVEL%'=='0' GOTO :FINISH
GOTO START

:FINISH
cls
title RARForce by Her ^|^ Cracked Password: %PASSWORD%
echo -------------------------
echo File Location : %PATH%
echo Password  : %PASSWORD%
echo -------------------------
echo Password: %password%>>pass.txt
echo Saved Password to pass.txt
pause
cls
set passs=1
goto :top

:color
echo                                  RARForce by Her
echo -------------------------------------------------------------------------------
echo 0 = Black       8 = Gray
echo 1 = Blue        9 = Light Blue
echo 2 = Green       A = Light Green
echo 3 = Aqua        B = Light Aqua
echo 4 = Red         C = Light Red
echo 5 = Purple      D = Light Purple
echo 6 = Yellow      E = Light Yellow
echo 7 = White       F = Bright White
set /p col=Color: 
color %col%
cls
goto :top

:help
echo                               RARForce by Her: Help
echo -------------------------------------------------------------------------------
echo Agreement:
echo This Program Is a Password Recovery Software and should never be misused for
echo cracking private documents or any other such activity, The Misuse Of This
echo Code Can Result In Criminal Charges Brought Against The Persons In Question. 
echo The Author Will Not Be Held Responsible. Criminal Charges Be Brought Against
echo Any Individuals Misusing This Tool To Break The Law. If you do not accept this
echo agreement quit this tool now.
echo.
echo Commands:
echo.
echo Numbers Bruteforce Attack:
echo Attacks every single combonation of numbers starting from 0.
echo Useful for finding passwords like 123, 6969, 420, etc.
echo.
echo Numbers And Letters Bruteforce Attack:
echo Generates a string from the user inputed length.
echo Useful for finding passwords like JF8JDGS8C.
echo.
echo Custom Bruteforce Attack:
echo User will input custom dictionary and length for faster bruteforcing!
echo Good for finding longer passwords.
echo.
echo Dictionary Attack (Best Method!):
echo Reads from a user given text file full of passwords and will check line by line
echo until there is no more passwords to check.
echo This will scan through the text file and read how many lines are in the
echo dictionary. 
echo Good for finding passwords like Password123, or MinecraftPass, etc.
echo.
echo Reset RAR Path: 
echo Select Number 6 and with are easy drag and drop you will be finding passwords
echo like a pro in no time!
echo Good for reseting the RAR path if you put the wrong one.
echo.
echo Set Text Color:
echo This makes the program a little more customizable and fun to use! Change the
echo color to light green to look like a hacker from the movies. 
echo.
echo It freezes at a certain password. Is the program broken?
echo Nope. It has found the password and the very last password is shows is the 
echo cracked password.
echo.
set /p=Press enter to return to menu...
cls
goto :top


::-----------------------------------------------------


:GEN
if %random% gtr 90000 (
set password=%password%%random:~0,1%
) else (
set /a i=%random:~1,1%+%random:~1,1%
if !i! gtr set i=10
set password=%password%!alpha:~%i%,1!
)