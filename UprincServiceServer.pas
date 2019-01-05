unit UprincServiceServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  IdIPAddrMon, IdUserAccounts, IdNetworkCalculator, IdIPWatch,
  IdSchedulerOfThreadDefault, IdScheduler, IdSchedulerOfThread,
  IdSchedulerOfThreadPool, IdServerIOHandler, IdSSL, IdSSLOpenSSL,
  IdIOHandlerSocket, IdIOHandlerStack, IdIOHandler, IdIOHandlerStream,
  IdIdentServer, IdEchoServer, IdDNSServer, IdDiscardServer, IdCmdTCPServer,
  IdDICTServer, IdIPMCastBase, IdIPMCastServer, IdChargenServer,
  IdCustomTCPServer, IdTCPServer, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, ExtCtrls, IdRawBase, IdRawClient, IdIcmpClient, IdTraceRoute;

type
  TService1 = class(TService)
    IdTCPClient1: TIdTCPClient;
    IdTCPServer1: TIdTCPServer;
    IdChargenServer1: TIdChargenServer;
    IdIPMCastServer1: TIdIPMCastServer;
    IdDICTServer1: TIdDICTServer;
    IdDISCARDServer1: TIdDISCARDServer;
    IdDNSServer1: TIdDNSServer;
    IdECHOServer1: TIdECHOServer;
    IdIdentServer1: TIdIdentServer;
    IdIOHandlerStream1: TIdIOHandlerStream;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
    IdSchedulerOfThreadPool1: TIdSchedulerOfThreadPool;
    IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault;
    IdIPWatch1: TIdIPWatch;
    IdNetworkCalculator1: TIdNetworkCalculator;
    IdUserManager1: TIdUserManager;
    IdIPAddrMon1: TIdIPAddrMon;
    IdTraceRoute1: TIdTraceRoute;
    Timer1: TTimer;
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
  private
//  timer1 : Ttimer ;
    { Déclarations privées }
  public
    function GetServiceController: TServiceController; override;
//    procedure timer(sender : TObject );
    { Déclarations publiques }
  end;

var
  Service1: TService1;

implementation

{$R *.dfm}

//procedure TService1.timer(sender : Tobject );
//var Stre : TfileStream;
//    s : string;
//begin
//if not(fileexists('C:\Users\mohamed\Documents\Embarcadero\Studio\Projets\PServerService\Win32\Debug\t.txt')) then
//stre :=TfileStream.Create('C:\Users\mohamed\Documents\Embarcadero\Studio\Projets\PServerService\Win32\Debug\t.txt',FmOpenWrite or fmcreate);
//s:=timetostr(now());
//stre.Writebuffer(s,sizeof(s));
//end;
procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
var Stre : TfileStream;
begin
  Result := ServiceController;
end;

procedure TService1.ServiceExecute(Sender: TService);
var Stre : TfileStream;
    s : string;
    ft : TNotifyEvent;
begin
//timer1:= TTimer.Create(self);
//timer1.Interval:=1000;
//timer1.OnTimer:= @timer;
s:=IdIPwatch1.Localip;
stre :=TfileStream.Create('C:\Users\mohamed\Documents\Embarcadero\Studio\Projets\PServerService\Win32\Debug\t.txt',FmOpenWrite or fmcreate);
stre.Writebuffer(s,sizeof(s));
//showmessage(IdIPwatch1.LocalIP);
end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
IdIPwatch1.Active:=true;
//showmessage(IdIPwatch1.LocalIP);
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
//IdIPwatch1.Active:=false;
end;

procedure TService1.Timer1Timer(Sender: TObject);
var Stre : TfileStream;
    s : string;
begin
if not(fileexists('C:\Users\mohamed\Documents\Embarcadero\Studio\Projets\PServerService\Win32\Debug\t.txt')) then
stre :=TfileStream.Create('C:\Users\mohamed\Documents\Embarcadero\Studio\Projets\PServerService\Win32\Debug\t.txt',FmOpenWrite or fmcreate);
s:=timetostr(now());
stre.Writebuffer(s,sizeof(s));
end;

end.
