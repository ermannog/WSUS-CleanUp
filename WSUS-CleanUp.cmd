SET MONTH=%DATE:~3,2%
SET DAY=%DATE:~0,2%
IF "%DAY:~0,1%"==" " SET DAY=0%DAY:~1,1%
SET YEAR=%DATE:~6,4%
SET HOUR=%TIME:~0,2%
IF "%HOUR:~0,1%"==" " SET HOUR=0%HOUR:~1,1%
SET MINUTE=%TIME:~3,2%
SET SECOND=%TIME:~6,2%

REM SET LogFilePath=C:\Scripts\Log-WSUS-CleanUp-H%HOUR%.txt
SET LogDirPath=%~dp0Logs
MD %LogDirPath%
SET LogFilePath=%LogDirPath%\Log-WSUS-CleanUp-H%HOUR%.txt
DEL %LogFilePath%

REM Esecuzione dei task in modo separto per ridurre i rischi di timeout

REM PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-GetInfo.ps1 %LogFilePath%
PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-DeclineAggiornamentiScaduti.ps1 %LogFilePath%
PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-DeclineAggiornamentiSostituiti.ps1 %LogFilePath%
PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-CleanUpAggiornamentiObsoleti.ps1 %LogFilePath%
PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-CleanUpRevisioniObsolete.ps1 %LogFilePath%
PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-CleanUpFileNonNecessari.ps1 %LogFilePath%
REM PowerShell -ExecutionPolicy RemoteSigned -File %~dp0WSUS-CleanUpComputerObsoleti.ps1 %LogFilePath%