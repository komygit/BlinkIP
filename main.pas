program main;

{$mode objfpc}{$H+}

{ Blink IP-Address                                                             }
{                                                                              }
{  This example uses the Activity LED to show the last octet of the IP-address.}
{  See comment in unit BlinkIP.                                                }
{                                                                              }
{  To compile the example select Run, Compile (or Run, Build) from the menu.   }
{                                                                              }
{  Once compiled copy the kernel7.img file to an SD card along with the        }
{  firmware files and use it to boot your Raspberry Pi.                        }
{                                                                              }
{  Raspberry Pi 2B version                                                     }
{   What's the difference? See Project, Project Options, Config and Target.    }

{Declare some units used by this example.}
uses
  GlobalConst,
  GlobalTypes,
  Platform,
  Threads,
  Console,
  Framebuffer,
  BCM2836,
  SysUtils,
  Winsock2,        {Include the Winsock2 unit so we can get the IP address}
  SMSC95XX,        {And the driver for the Raspberry Pi network adapter}
  DWCOTG,          {As well as the driver for the Raspberry Pi USB host}
  BlinkIP;

var
 IPAddress:String;
 WindowHandle:TWindowHandle;
 Winsock2TCPClient:TWinsock2TCPClient;

begin
  {A window handle and some others.}

  begin
   {Create our window}
   WindowHandle:=ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_FULL,True);

   {Output the message}
   ConsoleWindowWriteLn(WindowHandle,'Welcome to Example BlinkIP');
   ConsoleWindowWriteLn(WindowHandle,'');

   {Create a Winsock2TCPClient so that we can get some local information}
   Winsock2TCPClient:=TWinsock2TCPClient.Create;

   {Print our host name on the screen}
   ConsoleWindowWriteLn(WindowHandle,'Host name is ' + Winsock2TCPClient.LocalHost);

   {Get our local IP address which may be invalid at this point}
   IPAddress:=Winsock2TCPClient.LocalAddress;

   {Check the local IP address}
   if (IPAddress = '') or (IPAddress = '0.0.0.0') or (IPAddress = '255.255.255.255') then
    begin
     ConsoleWindowWriteLn(WindowHandle,'IP address is ' + IPAddress);
     ConsoleWindowWriteLn(WindowHandle,'Waiting for a valid IP address, make sure the network is connected');

     {Wait until we have an IP address}
     while (IPAddress = '') or (IPAddress = '0.0.0.0') or (IPAddress = '255.255.255.255') do
      begin
       {Sleep a bit}
       Sleep(1000);

       {Get the address again}
       IPAddress:=Winsock2TCPClient.LocalAddress;
      end;
    end;

   {Print our IP address on the screen}
   ConsoleWindowWriteLn(WindowHandle,'IP address is ' + IPAddress);
   ConsoleWindowWriteLn(WindowHandle,'');

   ConsoleWindowWriteLn(WindowHandle,'Blinking will start in 2 seconds.');
   ActivityLEDEnable;
   Sleep(2000);
   BlinkIPAddress(IPAddress);

   {Free the Winsock2TCPClient object}
   Winsock2TCPClient.Free;

   {Halt the thread}
   ThreadHalt(0);

end;

end.

