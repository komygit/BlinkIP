unit BlinkIP;
{ Blink IP-Address                                                             }
{                                                                              }
{  Uses the Activity LED to show the last octet of the IP-address.             }
{  A digit starts with 2 short flashes (*-*-) and shows the value              }
{  by the number of long flashes (***---) and a pause.                         }
{  example: 192.168.2.102 will blink '1' '0' '2'.                              }
{      '1'                   '0'                '2'                            }
{  *-*-***--- 1 s         *-*- 1 s          *-*-***---***---                   }
{  short short long pause short short pause short short long long              }
{                                                                              }

{$mode objfpc}{$H+}

interface

uses
  Platform,
  SysUtils;

procedure BlinkIPAddress(Address:String);

implementation

{delay timings in ms}
const
  SlowDelay = 400; {long blink}
  FastDelay = 200; {short blink}
  PauseDelay = 1000; {pause to blink next digit}

procedure FastBlink;
begin
 ActivityLEDOn;
 Sleep(FastDelay);
 ActivityLEDOff;
 Sleep(FastDelay);
end;

procedure SlowBlink;
begin
 ActivityLEDOn;
 Sleep(SlowDelay);
 ActivityLEDOff;
 Sleep(SlowDelay);
end;

procedure BlinkIPAddress(Address:String);
var
  I, J: Integer;
begin
  ActivityLEDOff;

  {remove subnet from address}
  for i:=1 to 3 do
     Address:=RightStr(Address,length(Address) - pos('.',Address));

  {do the blinks}
  for j:= 1 to Length(Address) do
    begin
     FastBlink;
     FastBlink;
     for i:= 1 to Ord(Address[j]) - Ord('0') do
      SlowBlink;

     Sleep(PauseDelay);
    end;
end;

end.

