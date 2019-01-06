unit UFileThread;

interface

uses
  System.Classes, sysutils, dialogs;

type
  TFileThread1 = class(TThread)
  f : TextFile;
  FileName : string;
  Msg : string;
  protected
    procedure Execute; override;
    public
    constructor Create( FileNamen, Msgs : string);
    procedure update;
  end;

implementation

constructor TFileThread1.Create( FileNamen, Msgs : string);
begin
  inherited create(false);
  Freeonterminate := true;
  priority := tpHigher;
  FileName:=FileNamen;
Msg := Msgs;
end;

procedure TFileThread1.Execute;
begin
Synchronize(update);
terminate;
end;

procedure TFileThread1.update;
begin
try
 AssignFile(f,FileName);
      if FileExists(FileName) then
          Append(f)
      else
          Rewrite(f);
writeln(f,DateTimeToStr(Now),Msg);
finally
CloseFile(f);
end;


end;

end.
