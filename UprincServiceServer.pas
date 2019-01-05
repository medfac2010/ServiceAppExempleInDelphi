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
    procedure TextFileApp();
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
  private
    { Déclarations privées }
      MyServiceThread : TThread1;
  public
    function GetServiceController: TServiceController; override;
    procedure OpenTextFile(msg: string);
    { Déclarations publiques }
  end;

var
  Service1: TService1;

implementation

{$R *.dfm}

uses UFileThread;

procedure TService1.OpenTextFile(msg: string);
var  fth : TFileThread1;
begin
msg:= DateTimeToStr(Now)+msg;
fth := TFileThread1.Create(FileName,msg);
if fth.CheckTerminated then
  fth.Free;

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
OpenTextFile(' Service Started');
sleep(1000);
if not(Assigned(MyServiceThread)) then
   begin
    try
        try
          MyServiceThread := TThread1.Create;
          sleep(2000);
        finally
            writeln(f,DateTimeToStr(Now),' Service threads Created');
            CloseFile(f);
        end;
    except
    on e: exception do
     begin
     writeln(f,DateTimeToStr(Now),e.message);
     CloseFile(f);
     end;
    end;
   end
else
     begin
     try
       service1.ReportStatus;
      if (service1.Status = csStopped) or (service1.Status = csStopPending) then
        begin
          try
           service1.DoStop;
           //service1.DoShutdown;
          finally
             writeln(f,DateTimeToStr(Now),' Service Execution Stoped');
             CloseFile(f);
          end;

        end;
     Except
        on e: exception do
           begin
            writeln(f,DateTimeToStr(Now),'Erreur dans le DoStop ->'+e.message);
            CloseFile(f);
           end;
     end;
     end;

end;

procedure TService1.ServiceShutdown(Sender: TService);
  var msg : string;
  fth : TFileThread1;
begin
//  OpenTextFile;
//  writeln(f,DateTimeToStr(Now),' Fichier Log crée dans :-->>Start');
//sleep(2000);
msg:= DateTimeToStr(Now)+' Fichier Log crée dans :-->>Start';
fth := TFileThread1.Create(FileName,msg);
fth.Terminate;
if Assigned(MyServiceThread) then
  begin
    MyServiceThread.Terminate;
    MyServiceThread.free;
    writeln(f,DateTimeToStr(Now),' Service Shutdown');
  end
else
  writeln(f,DateTimeToStr(Now),'MyServiceThread Not assigned');

CloseFile(f);

end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
var msg : string;
  fth : TFileThread1;
begin
//  OpenTextFile;
//  writeln(f,DateTimeToStr(Now),' Fichier Log crée dans :-->>Start');
//sleep(2000);
msg:= DateTimeToStr(Now)+' Fichier Log crée dans :-->>Start';
fth := TFileThread1.Create(FileName,msg);
if fth.CheckTerminated then
started:=true;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin

//  OpenTextFile;
//  writeln(f,DateTimeToStr(Now),' Fichier Log crée dans :-->>Stop');

if Assigned(MyServiceThread) then
  begin
    MyServiceThread.Terminate;
    MyServiceThread.Free;
    writeln(f,DateTimeToStr(Now),' Service Stoped');
  end
else
 begin
   MyServiceThread.Destroy
 end;
 writeln(f,DateTimeToStr(Now),' Service ne peut pas etre Stoped');
 CloseFile(f);
//Stopped:=true;
end;

procedure TService1.TextFileApp;

begin

// OpenTextFile;
//  writeln(f,DateTimeToStr(Now),' Current IP :',s,' Pervuios IP :', pass);
//  CloseFile(f);
//  sleep(1000);
end;

end.
