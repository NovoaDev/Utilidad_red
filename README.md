# Utilidad_red
Mini bat - Creado para testear mi ws, cambiar configuracion ip, cambiar dns, ver conexiones activas, etc

Variables: 
por seguridad cambie todas mis variables por otras es cuestion de modificarlas a su gusto. 

set IP_PUBLICA_WS=200.200.200.200       ip publica del webservice al cual se le hara ping y tracert

::IP ESTATICA
set IP_ESTATICA_IP=192.168.1.200       

set IP_ESTATICA_SM=255.255.255.0        

set IP_ESTATICA_GW=192.168.1.1           Configuracion ip, mascara de subred y gateway para la configuracion ip estatica

::DNS
set DNS_ISP_1=200.44.32.12             <

set DNS_ISP_2=200.44.32.13               Dns para el cambio de DNS por iSP

OPCIONES DEL MENU
  1. Ping WS
  2. Tracert WS
  3. Netstat
  4. Redes WIFI Guardadas
  5. Configurar WIFI Estatica / Dinamica 
  6. Configurar DNS ISP / GOOGLE
  7. Reparar conexiones
  8. Test de conexion KB
