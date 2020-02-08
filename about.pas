unit About;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020, by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal
// Redesigned and further Developed at 28th of January 2020, by Initial developer
// to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions
// Developed further for intrusion feeling and logging at 2nd of February 2020, by Initial developer
// Developed for Blacklisting/Whitelisting functions for both camera & audio at 7th of February 2020, by Initial developer

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  TplLabelUnit, LCLIntf;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button2            : TButton;
    Image1             : TImage;
    Image2             : TImage;
    Label1             : TLabel;
    Label2             : TLabel;
    Label3             : TLabel;
    ListBox1           : TListBox;
    plURLLabel1        : TplURLLabel;
    plURLLabel2        : TplURLLabel;
    plURLLabel3        : TplURLLabel;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure plURLLabel1Click(Sender: TObject);
    procedure plURLLabel2Click(Sender: TObject);
    procedure plURLLabel3Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.frm}

{ TForm2 }

procedure TForm2.Button2Click(Sender: TObject);
begin
     Form2.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.plURLLabel1Click(Sender: TObject);
begin
     OpenUrl('https://gitlab.com/psposito/camera-control-webcam-switch-indicator');
end;

procedure TForm2.plURLLabel2Click(Sender: TObject);
begin
     OpenUrl('http://bit.do/linuxer');
end;

procedure TForm2.plURLLabel3Click(Sender: TObject);
begin
     OpenUrl('https://wiki.freepascal.org/FPC_modified_LGPL');
end;

end.