unit Logs;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020, by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal
// Redesigned and further Developed at 28th of January 2020, by Linuxer (https://gitlab.com/psposito)
// to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions
// Developed further for intrusion feeling and logging at 2nd of February 2020 by Linuxer (https://gitlab.com/psposito)

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1            : TButton;
    StringGrid1        : TStringGrid;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation

{$R *.frm}

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
     Form3.Close;
end;

end.
