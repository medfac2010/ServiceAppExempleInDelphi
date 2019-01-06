unit Uthread1;

interface

uses
  System.Classes, IdIPWatch, Windows, Messages,Dialogs, SysUtils, Graphics;

type
  TThread1 = class(TThread )
//  IdIPwatch1 : TIdIPwatch;
  SecBetweenRuns : integer;
  oldip , newip : string;
  protected
    procedure Execute; override;
    function OpenTextFile(msg: string):boolean;

  public
    constructor Create;
    destructor Destroy; override;
//    function OpenTextFile(msg: string):boolean;
  end;
  const FileName='c:\logfile.txt';
  var
   f : TextFile;

implementation

{ TThread }

uses UFileThread;

constructor TThread1.create;
begin
  inherited Create(false);
//  FreeOnTerminate := false;
  Priority:= tpNormal;
//  IdIPwatch1 := TIdIPwatch.Create(nil);
//  IdIPwatch1.Active:= true;
//  IdIPwatch1.WatchInterval:=1;
//  oldip:=IdIPwatch1.LocalIP;
//  newip:=oldip;
//  TextFileApp;
//  showmessage( oldip);
end;


destructor TThread1.destroy;
begin
//IdIPwatch1.Active:=false;
//IdIPwatch1.FreeOnRelease;
inherited destroy;
end;



procedure TThread1.Execute;
const
  SecBetweenRuns = 10;
var
  Count: Integer;
begin
  count :=0;
  while not (self.CheckTerminated) do  // loop around until we should stop
  begin
    Inc(Count);
  //  synchronize(procedure begin IdIpwatch1.OnStatusChanged := OnStatusChanged end);
    if oldip<>newip  then
        begin
          OpenTextFile(' Current IP :'+'newip'+' Pervuios IP :'+'oldip');
          oldip:=newip
        end;
    if Count >= SecBetweenRuns then
      Count := 0;
    Sleep(1000);
  end;

  end;



//procedure TThread1.OnStatusChanged(sender: TObject);
//begin
//newip := IdIpWatch1.LocalIP;
//end;

function TThread1.OpenTextFile(msg: string):boolean;
var  fth : TFileThread1;
begin
fth := TFileThread1.Create(FileName,msg);
if fth.CheckTerminated then
  fth.Free;
sleep(1000);
result := true;
end;

end.
