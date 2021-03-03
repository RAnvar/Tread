unit ThreadTest1;

{$mode objfpc}{$H+}

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Classes,
  SysUtils,
  Controls;
type
  TMyThread = class(TThread)
      private
        capt : integer;
        fStatusText : string;
        answer : integer;
        procedure ShowStatus;
      protected
        procedure Execute; override;
      public
        Constructor Create(CreateSuspended : boolean);
      end;

implementation

uses
  MainTread, StdCtrls;

constructor TMyThread.Create(CreateSuspended : boolean);
  begin
    FreeOnTerminate := True;
    inc(done);
    capt:=done;
    inherited Create(CreateSuspended);
  end;

  procedure TMyThread.ShowStatus;
  // этот метод запущен главным потоком и поэтому может получить доступ ко всем элементам графического интерфейса.
  begin
    case capt of
     1 : Form1.Label1.Caption := fStatusText;
     2 : Form1.Label2.Caption := fStatusText;
    end;
  end;

  procedure TMyThread.Execute;
  var
    newStatus : string;
    i : integer;
  begin
    answer:= 0;
    fStatusText := 'TMyThread Starting...';
    Synchronize(@Showstatus);
    fStatusText := 'TMyThread Running...2';
    while (not Terminated) and (true) do
      begin
        for i:=1 to 200000 do begin
         // answer:=Round(Abs(Sin(Sqrt(i))));
          inc(answer, Round(Abs(Sin(Sqrt(i)))));
          fStatusText:=IntToStr(answer);


        {здесь расположен код цикла главного (основного) потока}
        end;
        Synchronize(@Showstatus);
 {       if NewStatus <> fStatusText then
          begin
            fStatusText := newStatus;
            Synchronize(@Showstatus);
          end;      }
      end;
  end;


end.

