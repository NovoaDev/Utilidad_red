@echo off
:: =========================================================================
::                   Author: lola-rica                                     =
::                   lolatmp@gmail.com                                     =
::                    github/Saycoron                                      =
:: =========================================================================
title /!\ Utilidad Red /!\ By:Lola

set IP_PUBLICA_WS=200.200.200.200

::IP ESTATICA
set IP_ESTATICA_IP=192.168.1.200
set IP_ESTATICA_SM=255.255.255.0
set IP_ESTATICA_GW=192.168.1.1

::DNS
set DNS_ISP_1=200.44.32.12
set DNS_ISP_2=200.44.32.13

::Menu Principal ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
:menu
cls
echo .              
echo  __         ______     __         ______       __  __     ______   __     __        
echo /\ \       /\  __ \   /\ \       /\  __ \     /\ \/\ \   /\__  _\ /\ \   /\ \       
echo \ \ \____  \ \ \/\ \  \ \ \____  \ \  __ \    \ \ \_\ \  \/_/\ \/ \ \ \  \ \ \____  
echo  \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\    \ \_____\    \ \_\  \ \_\  \ \_____\ 
echo   \/_____/   \/_____/   \/_____/   \/_/\/_/     \/_____/     \/_/   \/_/   \/_____/                                                                                
echo .
echo ================================== Menu ==========================================
echo .
echo                         1. Ping WS
echo                         2. Tracert WS
echo                         3. Netstat
echo                         4. Redes WIFI Guardadas
echo                         5. Configurar WIFI Estatica / Dinamica 
echo                         6. Configurar DNS ISP / GOOGLE
echo                         7. Reparar conexiones
echo                         8. Test de conexion KB
echo                         9. Salir
echo .
echo =================================================================================
set /p numero=Teclea un opcion:

if %numero%==1 goto :mPing
if %numero%==2 goto :mTracert
if %numero%==3 goto :mNetstat
if %numero%==4 goto :mRedesG
if %numero%==5 goto :mCfgIP
if %numero%==6 goto :mCfgDNS
if %numero%==7 goto :mReparar
if %numero%==8 goto :testKB
if %numero%==9 goto :Salir
if %numero% GTR 9 echo Error
goto :menu
::FIN Menu Principal +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

:mPing
@start cmd /k ping %IP_PUBLICA_WS%
goto :menu

:mTracert
@start cmd /k tracert %IP_PUBLICA_WS%
goto :menu

:mNetstat
@start cmd /k netstat -bo 10
goto :menu

:mRedesG
@start cmd /k netsh wlan show Profiles
goto :menu

:mCfgIP
echo ================================================================================
echo   (1) Cambiar a IP Estatica.  (2) Cambiar a IP Dinamica.  (3) Volver al Menu.
echo ================================================================================
set /p respuestaCFGIP=Esperando Respuesta: 

if %respuestaCFGIP% EQU 1 (
	Netsh interface ip set address name="Wi-Fi" source=static addr=%IP_ESTATICA_IP% mask=%IP_ESTATICA_SM% gateway=%IP_ESTATICA_GW% gwmetric=1
)
if %respuestaCFGIP% EQU 2 (
	Netsh interface ip set address name="Wi-Fi" source=dhcp
)
if %respuestaCFGIP% EQU 3 goto menu
goto :menu

:mCfgDNS
echo ================================================================================
echo   (1) Cambiar a DNS ISP.  (2) Cambiar a DNS GOOGLE.  (3) Obtener por DHCP.
echo ================================================================================
set /p respuestaCFGDNS=Esperando Respuesta: 

if %respuestaCFGDNS% EQU 1 (
	Netsh interface ipv4 add dns "Wi-Fi" %DNS_ISP_1%
	Netsh interface ipv4 add dns "Wi-Fi" %DNS_ISP_2% index=2 
)
if %respuestaCFGDNS% EQU 2 (
	Netsh interface ipv4 add dns "Wi-Fi" 8.8.8.8
	Netsh interface ipv4 add dns "Wi-Fi" 8.8.4.4 index=2 
)
if %respuestaCFGDNS% EQU 3 (
	netsh interface ipv4 set dns name="Wi-Fi" dhcp
)
goto :menu

:reparar
echo Se va a reiniciar todos los servicios de red. Continuar? 
pause>nul
ipconfig.exe /release *
net.exe stop "dhcp client" 
net.exe stop "dns client" 
net.exe stop "network connections" 
net.exe start "dhcp client" 
net.exe start "dns client" 
net.exe start "network connections" 
ipconfig.exe /flushdns 
ipconfig.exe /renew *

IPConfig /all>C:\logRed.txt
Notepad.exe C:\logRed.txt
goto :menu

:testKB
for /F "tokens=2" %%a in ('"netstat -e | find /I "byte""') do set down1=%%a 
for /F "tokens=3" %%a in ('"netstat -e | find /I "byte""') do set up1=%%a 
ping -w 850 -n 2 127.0.0.1>nul 
for /F "tokens=2" %%a in ('"netstat -e | find /I "byte""') do set /A down2=(%%a-%down1%)/1390 
for /F "tokens=3" %%a in ('"netstat -e | find /I "byte""') do set /A up2=(%%a-%up1%)/1024 
cls 
echo Down %down2% KB 
echo Up   %up2% KB 
title %down2% down %up2% up  
goto :testKB  

:fin
exit
