unit MainTread;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls, ThreadTest1;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  done : integer = 0;
  cs : TRTLCriticalSection;
  MyThread, MyThread1 : TMyThread;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin
  MyThread := TMyThread.Create(True); // Таким способом он не запустится автоматически

    {Здесь расположен код, который инициализирует всё возможное перед запуском потоков}
  MyThread.Resume;
end;

procedure TForm1.Button2Click(Sender: TObject);

begin
  MyThread1 := TMyThread.Create(True); // Таким способом он не запустится автоматически

    {Здесь расположен код, который инициализирует всё возможное перед запуском потоков}
  MyThread1.Resume;
end;

end.

