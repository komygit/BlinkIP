# BlinkIP for Ultibo on Raspberry Pi Modell 2b

Uses the Activity LED to show the last octet of the IP-address.             
A digit starts with 2 short flashes (*-*-) and shows the value              
by the number of long flashes (***---) and a pause.                         
example: 192.168.2.102 will blink '1' '0' '2'.                              
      '1'                   '0'                '2'                            
  *-*-***--- 1 s         *-*- 1 s          *-*-***---***---                   
  short short long pause short short pause short short long long 
