@echo off
title Notice Generator
color 0a

echo.
echo.

REM Run the Sql Workbench/J scripts for holds, renewals and overdues. Scripts also save files.

echo Pulling data from the DB and writting to a file...
echo.
echo.

java -jar C:\SQLWorkbench\sqlworkbench.jar -script='C:\Shoutbomb\scripts\holds.sql','C:\Shoutbomb\scripts\renew.sql','C:\Shoutbomb\scripts\overdue.sql' -profile=prpld

REM Run winscp to ftp the files over to Shoutbomb

echo Sending files via FTP to ShouthBomb...
echo.
echo.

"C:/Program Files (x86)/WinSCP/winscp.com" /command "option batch abort" "option confirm off" "open ShoutBomb" "put C:\Shoutbomb\Holds\*_MDT.txt /Holds/" "put C:\Shoutbomb\Renewals\*_MDT.txt /Renew/" "put C:\Shoutbomb\Overdue\*_MDT.txt /Overdue/" "exit"

REM move the ftp'd files over to archive folder

echo.
echo.

echo Move files to the Archive folder...

CD C:\
MOVE C:\Shoutbomb\Holds\*_MDT.txt C:\Shoutbomb\Archive\Holds\
MOVE C:\Shoutbomb\Renewals\*_MDT.txt C:\Shoutbomb\Archive\Renewals\
MOVE C:\Shoutbomb\Overdue\*_MDT.txt C:\Shoutbomb\Archive\Overdue\
