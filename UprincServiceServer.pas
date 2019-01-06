unit UprincServiceServer;

interface

uses
  Winapi.Windows, Uthread1, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
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

    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
  private
    { Déclarations privées }
  public
    function GetServiceController: TServiceController; override;
    function OpenTextFile(msg: string): boolean;
    { Déclarations publiques }
  end;

var
  Service1: TService1;
       MyServiceThread : TThread1 = nil;

implementation

{$R *.dfm}

uses UFileThread;

function TService1.OpenTextFile(msg: string):boolean;
var  fth : TFileThread1;
begin
fth := TFileThread1.Create(FileName,msg);
if fth.CheckTerminated then
  fth.Free;
sleep(1000);
result := true;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;

begin
  Result := ServiceController;
end;

procedure TService1.ServiceExecute(Sender: TService);

begin
   service1.ReportStatus;
  if (service1.Status = csStopped) then
  begin
      try
       MyServiceThread.Terminate;
      finally
        OpenTextFile('Service Execution Terminer');
        if MyServiceThread.CheckTerminated then
            MyServiceThread.Free;
      end;
   end;
   while not terminated do
      service1.ServiceThread.ProcessRequests(true);
end;

procedure TService1.ServiceShutdown(Sender: TService);
begin
 Service1.DoStop;
end;


procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);

begin
OpenTextFile(' --->>Stop<<---');
    MyServiceThread.FreeOnTerminate:=true;
    MyServiceThread.Terminate;
if (MyServiceThread.CheckTerminated) then
   OpenTextFile(' --->>FIN DE STOOOOOP <<---');
Stopped:=true;
end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
OpenTextFile(' Fichier Log crée dans :-->>Start');
  if not(Assigned(MyServiceThread)) then
    begin
        try
            try
              MyServiceThread := TThread1.Create;
              sleep(2000);
            finally
              OpenTextFile(' Service Started');
            end;
        except
            on e: exception do OpenTextFile(e.message);
        end;
    end;
started:=true;
end;

end.
