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
    Timer1: TTimer;

    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
    procedure IdIPAddrMon1StatusChanged(ASender: TObject; AAdapter: Integer;
      AOldIP, ANewIP: string);
    procedure TextFileApp();
    procedure IdIPWatch1StatusChanged(Sender: TObject);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceShutdown(Sender: TService);
  private
    { Déclarations privées }
      MyServiceThread : TThread1;
  public
    function GetServiceController: TServiceController; override;

    { Déclarations publiques }
  end;
//const  FileName = 'c:\logfile.txt';

var
  Service1: TService1;
//  pass,s : string;
//    F: TextFile;

implementation

{$R *.dfm}



procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;

begin
  Result := ServiceController;
end;

procedure TService1.IdIPAddrMon1StatusChanged(ASender: TObject;
  AAdapter: Integer; AOldIP, ANewIP: string);
begin

//pass := AOldIP;
//s := ANewIP;
//showmessage(s);
//timer1.Enabled:=true;
//TextFileApp;
end;

procedure TService1.IdIPWatch1StatusChanged(Sender: TObject);
begin
//pass:=IdIPwatch1.LocalIP;
end;

procedure TService1.ServiceCreate(Sender: TObject);
begin
//pass:=IdIPwatch1.LocalIP;
//s:=pass;
//timer1.Enabled:=true;
end;

procedure TService1.ServiceExecute(Sender: TService);

begin

AssignFile(f,FileName);
      if FileExists(FileName) then
          Append(f)
      else
          Rewrite(f);


if not(Assigned(MyServiceThread)) then
   begin
    try
        try
          MyServiceThread := TThread1.Create;
          MyServiceThread.Priority:= tpTimeCritical;
          MyServiceThread.Resume;
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
            service1.DoShutdown;
          finally
             writeln(f,DateTimeToStr(Now),' Service Execution Stoped');
             CloseFile(f);
          end;

          end;
     Except
        on e: exception do
           begin
            writeln(f,DateTimeToStr(Now),e.message);
            CloseFile(f);
           end;
     end;
     end;

//timer1.Enabled:=true;
// while (not terminated) do
//   begin
//   idipwatch1..ForceCheck;
//   IdIPAddrMon1.forcecheck;
//        if (pass<>s) then
//          begin
//            TextFileApp();
//            pass := s;
//            timer1.Enabled:=false;
//          end;
       // Service1.TextFileApp
//          ServiceThread.ProcessRequests(true);
//          timer1.Enabled:=false;
  //  ServiceThread.Synchronize( IdIPAddrMon1.OnStatusChanged);
//   end;

end;

procedure TService1.ServiceShutdown(Sender: TService);
begin
AssignFile(f,FileName);
      if FileExists(FileName) then
          Append(f)
      else
          Rewrite(f);

if Assigned(MyServiceThread) then
  begin
    // The TService must WaitFor the thread to finish (and free it)
    // otherwise the thread is simply killed when the TService ends.
    MyServiceThread.Terminate;
    MyServiceThread.WaitFor;
    FreeAndNil(MyServiceThread);
  writeln(f,DateTimeToStr(Now),' Service Shutdown');

  end
else
  writeln(f,DateTimeToStr(Now),'ShutdownError');

  CloseFile(f);

end;

procedure TService1.ServiceStart(Sender: TService; var Started: Boolean);
begin
//timer1.Enabled:=true;
//IdIPwatch1.Active:=true;
//IdIPAddrMon1.Active:=true;
//TextFileApp;
started := true;
end;

procedure TService1.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
AssignFile(f,FileName);
   if FileExists(FileName) then
      Append(f)
   else
      Rewrite(f);

if Assigned(MyServiceThread) then
  begin
    // The TService must WaitFor the thread to finish (and free it)
    // otherwise the thread is simply killed when the TService ends.
    MyServiceThread.Terminate;
    MyServiceThread.WaitFor;
    FreeAndNil(MyServiceThread);
  writeln(f,DateTimeToStr(Now),' Service Stoped');
  end
else
  writeln(f,DateTimeToStr(Now),' Service ne peut pas etre Stoped');

 CloseFile(f);
Stopped:=true;
end;

procedure TService1.TextFileApp;
begin
//  AssignFile(f,FileName);
//   if FileExists(FileName) then
//      Append(f)
//   else
//      Rewrite(f);
//  writeln(f,DateTimeToStr(Now),' Current IP :',s,' Pervuios IP :', pass);
//  CloseFile(f);
//  sleep(1000);
end;

procedure TService1.Timer1Timer(Sender: TObject);

begin
//   idipwatch1.ForceCheck;
//   IdIPAddrMon1.forcecheck;
//        if (pass<>s) then
//          begin
//            TextFileApp();
//            pass := s;
//          end;
//    ServiceThread.ProcessRequests(true);
end;

end.
