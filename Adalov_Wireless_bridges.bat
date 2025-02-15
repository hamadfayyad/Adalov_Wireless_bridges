@ECHO off
cls
set COLOR_GREEN=[32m>nul
set COLOR_BRIGHTGREEN=[1;32m>nul
set COLOR_BRIGHTYELLOW=[1;33m>nul
set COLOR_BG_GREEN=[42m>nul
set COLOR_BG_YELLOW=[43m>nul
set COLOR_BRIGHTRED=[1;31m>nul
set COLOR_BRIGHTCYAN=[1;36m>nul
set COLOR_RESET=[0m>nul
TITLE CPE
setlocal
goto check_Permissions
:home
   cls
    call :header
    ECHO .  
    ECHO    This script will help you to enter the Admin control panel of Adalov Wireless bridges
    ECHO    Set one of the CPE A-B switch to A, set it Master bridge and transmit the signal;
    ECHO    Set the others CPE A-B switch to B, set them Slave client and receive the signal;
    ECHO    Short press reset button to choose same channel for 3 bridges (Digital X);
    ECHO    Waiting them to pair successful.(Signal Indicators will light when paired)
    ECHO .
    ECHO    Connect CPE A-B to PC via Ethernet 
    ECHO    Choose the network Interface to access admin Panal 
    ECHO .

    SetLocal EnableDelayedExpansion
    
    For /F "Delims==" %%A In ('"(Set NIC[) 2>Nul"') Do Set "%%A="
    Set "i=0"
    For /F "Skip=1 Delims=" %%A In (
        'WMIC NIC Where "NetConnectionID Is Not Null" Get NetConnectionID'
    ) Do For /F "Delims=" %%B In ("%%A") Do Call :Sub %%B
    If %i% Equ 1 (Set "NIC[X]=%NIC[1]%") Else Call :Menu
    Rem Your commands here
    REM Echo You selected %NIC[X]%
    Exit /B

:Sub
    Set /A i+=1
    Set "NIC[%i%]=%*"
    Exit /B

:Menu

    For /L %%A In (1,1,%i%) Do (Echo    %COLOR_BRIGHTGREEN%  %%A.%COLOR_RESET% !NIC[%%A]!)
    Set /P "NIC[X]=%COLOR_BRIGHTGREEN%Choose the network Interface to access admin Panal: "
    If Not Defined NIC[%NIC[X]%] (ClS & GoTo Menu)
    Set "NIC[X]=!NIC[%NIC[X]%]!"

:start
    cls
    call :header
    ECHO.
    ECHO    Type the number below for which Bridge Mod A OR B you want to perform:
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%1.%COLOR_RESET%  %COLOR_BG_GREEN% Bridge Mod A Master %COLOR_RESET%   Master
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%2.%COLOR_RESET%  %COLOR_BG_YELLOW% Bridge Mod B Slave %COLOR_RESET%   Slave
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%3.%COLOR_RESET% Reset network to %COLOR_BRIGHTGREEN% default %COLOR_RESET% ( %NIC[X]% )
    ECHO   -----------------------------
    ECHO   %COLOR_BRIGHTGREEN%4.%COLOR_RESET%  Exit
    ECHO.
    set choice=
    set /p choice=  %COLOR_BRIGHTGREEN%  Enter your choice number :%COLOR_RESET% 
    if not '%choice%'=='' set choice=%choice:~0,1%
    if '%choice%'=='1' goto cona
    if '%choice%'=='2' goto conb
    if '%choice%'=='3' goto autosearch
    if '%choice%'=='4' goto bye
    ECHO "%choice%" is not valid, try again
    ECHO.
    goto start

:cona
    cls
    call :header
    ECHO.
    ECHO.
    ECHO    Type the number below for which Bridge Mod A need to access default is 0:
    ECHO   _________________________________________________________________
    ECHO   %COLOR_BRIGHTGREEN%0. %COLOR_RESET% Bridge Mod A MAster Digital 0    %COLOR_BRIGHTGREEN%1. %COLOR_RESET% Bridge Mod A MAster Digital 1  
    ECHO   %COLOR_BRIGHTGREEN%2. %COLOR_RESET% Bridge Mod A MAster Digital 2    %COLOR_BRIGHTGREEN%3. %COLOR_RESET% Bridge Mod A MAster Digital 3  
    ECHO   %COLOR_BRIGHTGREEN%4. %COLOR_RESET% Bridge Mod A MAster Digital 4    %COLOR_BRIGHTGREEN%5. %COLOR_RESET% Bridge Mod A MAster Digital 5  
    ECHO   %COLOR_BRIGHTGREEN%6. %COLOR_RESET% Bridge Mod A MAster Digital 6    %COLOR_BRIGHTGREEN%7. %COLOR_RESET% Bridge Mod A MAster Digital 7  
    ECHO   %COLOR_BRIGHTGREEN%8. %COLOR_RESET% Bridge Mod A MAster Digital 8    %COLOR_BRIGHTGREEN%9. %COLOR_RESET% Bridge Mod A MAster Digital 9  
    ECHO   %COLOR_BRIGHTGREEN%10.%COLOR_RESET%  Bridge Mod A MAster Digital A   %COLOR_BRIGHTGREEN%11.%COLOR_RESET%  Bridge Mod A MAster Digital b 
    ECHO   %COLOR_BRIGHTGREEN%12.%COLOR_RESET%  Bridge Mod A MAster Digital c   %COLOR_BRIGHTGREEN%13.%COLOR_RESET%  Bridge Mod A MAster Digital d 
    ECHO   %COLOR_BRIGHTGREEN%14.%COLOR_RESET%  Bridge Mod A MAster Digital E   %COLOR_BRIGHTGREEN%15.%COLOR_RESET%  Bridge Mod A MAster Digital F 
    ECHO   _________________________________________________________________
    ECHO   99. Exit
    ECHO.
    set choice=
    set /p choice=  %COLOR_BRIGHTGREEN%  Enter your choice number :%COLOR_RESET% 
    if not '%choice%'=='' set choice=%choice:~0,2%
    if '%choice%'=='0' ( set Name=Bridge Mod A MAster 0
                    set Getways=192.168.255.100
                    set wifi=CPE5G_5G0
                    set Password=zIIinkcpe1234560
                    goto action )
    if '%choice%'=='1' ( set Name=Bridge Mod A MAster 1
                    set Getways=192.168.255.101
                    set wifi=CPE5G_5G36
                    set Password=zIIinkcpe12345636
                    goto action) 
    if '%choice%'=='2' ( set Name=Bridge Mod A MAster 2
                    set Getways=192.168.255.102
                    set wifi=CPE5G_5G40
                    set Password=zIIinkcpe12345640
                    goto action) 
    if '%choice%'=='3' ( set Name=Bridge Mod A MAster 3
                    set Getways=192.168.255.103
                    set wifi=CPE5G_5G44
                    set Password=zllinkcpe12345644
                    goto action) 
    if '%choice%'=='4' ( set Name=Bridge Mod A MAster 4
                    set Getways=192.168.255.104
                    set wifi=CPE5G_5G48
                    set Password=zllinkcpe12345648
                    goto action) 
    if '%choice%'=='5' ( set Name=Bridge Mod A MAster 5
                    set Getways=192.168.255.105
                    set wifi=CPE5G_5G120
                    set Password=zllinkcpe123456120
                    goto action) 
    if '%choice%'=='6' ( set Name=Bridge Mod A MAster 6
                    set Getways=192.168.255.106
                    set wifi=CPE5G_5G124
                    set Password=zllinkcpe123456124
                    goto action) 
    if '%choice%'=='7' ( set Name=Bridge Mod A MAster 7
                    set Getways=192.168.255.107
                    set wifi=CPE5G_5G128
                    set Password=zllinkcpe123456128
                    goto action) 
    if '%choice%'=='8' ( set Name=Bridge Mod A MAster 8
                    set Getways=192.168.255.108
                    set wifi=CPE5G_5G132
                    set Password=zllinkcpe123456132
                    goto action) 
    if '%choice%'=='9' ( set Name=Bridge Mod A MAster 9
                    set Getways=192.168.255.109
                    set wifi=CPESG  5G136
                    set Password=zllinkcpe123456136
                    goto action) 
    if '%choice%'=='10' ( set Name=Bridge Mod A MAster 10
                    set Getways=192.168.255.110
                    set wifi=CPE5G_5G140
                    set Password=zllinkcpe123456140
                    goto action )
    if '%choice%'=='11' ( set Name=Bridge Mod A MAster 11
                    set Getways=192.168.255.111
                    set wifi=CPE5G_5G149
                    set Password=zllinkcpe123456149
                    goto action )
    if '%choice%'=='12' ( set Name=Bridge Mod A MAster 12
                    set Getways=192.168.255.112
                    set wifi=CPESG_5G153
                    set Password=zllinkcpe123456153
                    goto action )
    if '%choice%'=='13' ( set Name=Bridge Mod A MAster 13
                    set Getways=192.168.255.113
                    set wifi=CPE5G_5G157
                    set Password=zllinkcpe123456157
                    goto action )
    if '%choice%'=='14' ( set Name=Bridge Mod A MAster 14
                    set Getways=192.168.255.114
                    set wifi=CPE5G_5G161
                    set Password=zllinkcpe123456161
                    goto action )
    if '%choice%'=='15' ( set Name=Bridge Mod A MAster 15
                    set Getways=192.168.255.115
                    set wifi=CPE5G_5G165
                    set Password=zllinkcpe123456165 
                    goto action )

    if '%choice%'=='99' goto bye
    ECHO "%choice%" is not valid, try again
    ECHO.
    goto start



:conb
    cls
    call :header
    ECHO.
    ECHO.
    ECHO   Type the number below for which Bridge Mod B need to access default is 0:
    ECHO   _________________________________________________________________
    ECHO   %COLOR_BRIGHTGREEN%0. %COLOR_RESET% Bridge Mod B Slave Digital 0    %COLOR_BRIGHTGREEN%1. %COLOR_RESET% Bridge Mod B Slave Digital 1  
    ECHO   %COLOR_BRIGHTGREEN%2. %COLOR_RESET% Bridge Mod B Slave Digital 2    %COLOR_BRIGHTGREEN%3. %COLOR_RESET% Bridge Mod B Slave Digital 3  
    ECHO   %COLOR_BRIGHTGREEN%4. %COLOR_RESET% Bridge Mod B Slave Digital 4    %COLOR_BRIGHTGREEN%5. %COLOR_RESET% Bridge Mod B Slave Digital 5  
    ECHO   %COLOR_BRIGHTGREEN%6. %COLOR_RESET% Bridge Mod B Slave Digital 6    %COLOR_BRIGHTGREEN%7. %COLOR_RESET% Bridge Mod B Slave Digital 7  
    ECHO   %COLOR_BRIGHTGREEN%8. %COLOR_RESET% Bridge Mod B Slave Digital 8    %COLOR_BRIGHTGREEN%9. %COLOR_RESET% Bridge Mod B Slave Digital 9  
    ECHO   %COLOR_BRIGHTGREEN%10.%COLOR_RESET%  Bridge Mod B Slave Digital A   %COLOR_BRIGHTGREEN%11.%COLOR_RESET%  Bridge Mod B Slave Digital b 
    ECHO   %COLOR_BRIGHTGREEN%12.%COLOR_RESET%  Bridge Mod B Slave Digital c   %COLOR_BRIGHTGREEN%13.%COLOR_RESET%  Bridge Mod B Slave Digital d 
    ECHO   %COLOR_BRIGHTGREEN%14.%COLOR_RESET%  Bridge Mod B Slave Digital E   %COLOR_BRIGHTGREEN%15.%COLOR_RESET%  Bridge Mod B Slave Digital F 
    ECHO   _________________________________________________________________
    ECHO   99. Exit
    ECHO.
    set choice=
    set /p choice=  %COLOR_BRIGHTGREEN%  Enter your choice number :%COLOR_RESET% 
    if not '%choice%'=='' set choice=%choice:~0,2%
    if '%choice%'=='0' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.200
                    set wifi=CPE5G_5G0
                    set Password=zIIinkcpe1234560
                    goto action)
    if '%choice%'=='1' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.201
                    set wifi=CPE5G_5G36
                    set Password=zIIinkcpe12345636
                    goto action)
    if '%choice%'=='2' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.202
                    set wifi=CPE5G_5G40
                    set Password=zIIinkcpe12345640
                    goto action)
    if '%choice%'=='3' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.203
                    set wifi=CPE5G_5G44
                    set Password=zllinkcpe12345644
                    goto action)
    if '%choice%'=='4' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.204
                    set wifi=CPE5G_5G48
                    set Password=zllinkcpe12345648
                    goto action)
    if '%choice%'=='5' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.205
                    set wifi=CPE5G_5G120
                    set Password=zllinkcpe12345612
                    goto action)
    if '%choice%'=='6' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.206
                    set wifi=CPE5G_5G124
                    set Password=zllinkcpe12345612
                    goto action)
    if '%choice%'=='7' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.207
                    set wifi=CPE5G_5G128
                    set Password=zllinkcpe12345612
                    goto action)
    if '%choice%'=='8' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.208
                    set wifi=CPE5G_5G132
                    set Password=zllinkcpe12345613
                    goto action)
    if '%choice%'=='9' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.209
                    set wifi=CPESG  5G136
                    set Password=zllinkcpe12345613
                    goto action)
    if '%choice%'=='10' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.210
                    set wifi=CPE5G_5G140
                    set Password=zllinkcpe123456140
                    goto action)
    if '%choice%'=='11' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.211
                    set wifi=CPE5G_5G149
                    set Password=zllinkcpe123456149
                    goto action)
    if '%choice%'=='12' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.212
                    set wifi=CPESG_5G153
                    set Password=zllinkcpe123456153
                    goto action)
    if '%choice%'=='13' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.213
                    set wifi=CPE5G_5G157
                    set Password=zllinkcpe123456157
                    goto action)
    if '%choice%'=='14' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.214
                    set wifi=CPE5G_5G161
                    set Password=zllinkcpe123456161
                    goto action)
    if '%choice%'=='15' ( set Name=Bridge Mod B Slave
                    set Getways=192.168.255.215
                    set wifi=CPE5G_5G165
                    set Password=zllinkcpe123456165
                    goto action)

    if '%choice%'=='99' goto bye
    ECHO "%choice%" is not valid, try again
    ECHO.
    goto start


:action
    cls
    call :header
    ECHO.
    ECHO  setting static IP address for %NIC[X]%
    cd %windir%\system32
    netsh interface ip set address "%NIC[X]%" static 192.168.255.10 255.255.255.0 %Getways%
    if  errorlevel 1 call :ERROR2
    timeout /t 2 >nul
    ECHO %NIC[X]% %Name%  %choice%
    ECHO  IPaddress:   %COLOR_BRIGHTGREEN% 192.168.255.10 %COLOR_RESET%
    ECHO    getways:   %COLOR_BRIGHTGREEN% %Getways% %COLOR_RESET%
    ECHO       wifi:   %COLOR_BRIGHTGREEN% %wifi% %COLOR_RESET%
    ECHO   Password:   %COLOR_BRIGHTGREEN% %Password%  %COLOR_RESET%
    ECHO.
    timeout /t 5 >nul
    ECHO %COLOR_BRIGHTYELLOW%  Do not close this window until you have finished configuration !, you must reset your network num 3 %COLOR_RESET%
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%1.%COLOR_RESET% ping to %COLOR_BRIGHTGREEN% %Getways% %COLOR_RESET%
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%2.%COLOR_RESET% Open admin panale %COLOR_BRIGHTGREEN% http://%Getways% %COLOR_RESET% user:admin Password:admin
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%3.%COLOR_RESET% Reset network to %COLOR_BRIGHTGREEN% default %COLOR_RESET%
    ECHO.
    set action=
    set /p action=  %COLOR_BRIGHTGREEN%  Enter your choice number :%COLOR_RESET% 
    if not '%action%'=='' set action=%action:~0,2%
    if '%action%'=='1' goto ping
    if '%action%'=='2' goto apanal
    if '%action%'=='3' goto autosearch
    ECHO "%choice%" is not valid, try again
    goto con1

:con1
    cls
    call :header
    ECHO.
    ECHO  setting static IP address for %NIC[X]%
    netsh interface ip set address "%NIC[X]%" static 192.168.255.10 255.255.255.0 %Getways%
    ECHO %NIC[X]% %Name%  %choice%
    ECHO  IPaddress:   %COLOR_BRIGHTGREEN% 192.168.255.10 %COLOR_RESET%
    ECHO    getways:   %COLOR_BRIGHTGREEN% %Getways% %COLOR_RESET%
    ECHO       wifi:   %COLOR_BRIGHTGREEN% %wifi% %COLOR_RESET%
    ECHO   Password:   %COLOR_BRIGHTGREEN% %Password%  %COLOR_RESET%
    ECHO.
    ECHO %COLOR_BRIGHTYELLOW%  Do not close this window until you have finished configuring, you must reset your network %COLOR_RESET%
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%1.%COLOR_RESET% ping to %COLOR_BRIGHTGREEN% %Getways% %COLOR_RESET%
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%2.%COLOR_RESET% Open admin panale %COLOR_BRIGHTGREEN% http://%Getways% %COLOR_RESET% user:admin Password:admin
    ECHO.
    ECHO   %COLOR_BRIGHTGREEN%3.%COLOR_RESET% Reset network to %COLOR_BRIGHTGREEN% default %COLOR_RESET%
    ECHO.
    set action=
    set /p action=  %COLOR_BRIGHTGREEN%  Enter your choice number :%COLOR_RESET% 
    if not '%action%'=='' set action=%action:~0,2%
    if '%action%'=='1' goto ping
    if '%action%'=='2' goto apanal
    if '%action%'=='3' goto autosearch
    ECHO "%choice%" is not valid, try again
    goto con1


:autosearch
    cls
    call :header
    ECHO %COLOR_BG_GREEN%Obtaining IP Address automatically for %NIC[X]%
    echo Starting networking stack reset%COLOR_RESET%
    cd %windir%\system32
    timeout /t 3
    netsh interface ip reset "%NIC[X]%"
    if  errorlevel 1 echo %COLOR_BRIGHTYELLOW% warning - We will Trying to send commands if not change you must Run as administrator%COLOR_RESET%
    timeout /t 3 
    echo %COLOR_BG_GREEN%ipv4 stack reset%COLOR_RESET%
    netsh interface ipv4 set address "%NIC[X]%" dhcp
    if  errorlevel 1 echo   %COLOR_BRIGHTYELLOW% warning - We will Trying to send commands if not change you must Run as administrator%COLOR_RESET%
    timeout /t 3 
    echo %COLOR_BG_GREEN%dns stack reset%COLOR_RESET%
    netsh interface ip set dns "%NIC[X]%" dhcp
    if  errorlevel 1 echo %COLOR_BRIGHTYELLOW% warning - We will Trying to send commands if not change you must Run as administrator%COLOR_RESET%

   
    if  errorlevel 1 goto ERROR
    if  errorlevel 0 echo %COLOR_BRIGHTCYAN% Successfully %COLOR_RESET%
    PAUSE
    goto end



:ping
    cls
    call :header
    ECHO.
    ECHO .
    ping %Getways%
    goto con1

:apanal
    start http://%Getways%
    goto con1

:ERROR
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************** Failed **************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ************ something wrong *********%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ****** Please check permissions ******%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ******** %COLOR_BRIGHTYELLOW%Run as administrator%COLOR_RESET% %COLOR_BRIGHTRED%********%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    timeout /t 1
    echo Press Enter To Back Main Menu ...
    pause >nul
    goto home

:ERROR2
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************** Failed **************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ************ something wrong *********%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ****** Please check permissions ******%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   ******** %COLOR_BRIGHTYELLOW%Run as administrator%COLOR_RESET% %COLOR_BRIGHTRED%********%COLOR_RESET%
    echo %COLOR_BRIGHTRED%   **************************************%COLOR_RESET%
    timeout /t 1 >nul
    echo   %COLOR_BRIGHTYELLOW%  We will Trying to send commands if not change you must Run as administrator%COLOR_RESET%
    echo Press Enter To Continue ...
    pause >nul
    exit /b 1

:bye
    cls
    call :header
    ECHO.
    ECHO bye . . .
    timeout /t 2
    goto end


:check_Permissions    
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto home
    ) else (
        echo    Failure: Current permissions inadequate.
        echo %COLOR_BRIGHTYELLOW%   Run as administrator %COLOR_RESET%
        pause
        goto home
        
    )
    
    pause >nul

:header
    ECHO.
    ECHO  %COLOR_GREEN%     @@@@@@@@@@@@  @@@@@@@@@@@    @@@@@@@@   @@@@     @@@@    @@@@     @@@@@:       @@@@@@          
    ECHO       @@@@@@@@@@@@  @@@@@@@@@@@   @@@@@@@@@   @@@@     @@@@    @@@@@    @@@@:     @@@@@  @@@@@              
    ECHO          @@@@       @@@          @@@@         @@@@     @@@@    @@@@@@@ @@@@@:   @@@@       @@@@                     
    ECHO          @@@@       @@@@@@@@     @@@          @@@@@@@@@@@@@    @@@@@@@@@@@@@:  @@@         @@@@                    
    ECHO          @@@@       @@@@@@@@     @@@@         @@@@     @@@@    @@@@ @@@@@@@@:  @@@@        @@@@                     
    ECHO          @@@@       @@@@          @@@@@@@@@@  @@@@     @@@@    @@@@    @@@@@:   @@@@@  @@@@@@                       
    ECHO          @@@@       @@@@@@@@@@@     @@@@@@@   @@@@     @@@@    @@@@     @@@@:     @@@@@@@@    
    ECHO.
    ECHO                            Techno Touch for Security solution  %COLOR_RESET%
    ECHO.


:end
    exit /b %ERRORLEVEL%



