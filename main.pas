unit Main;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020 by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal

interface

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus, Unix,
  unitAbout;

type

  { TForm1 }

  TForm1 = class(TForm)
    MenuItem1          : TMenuItem;
    MenuItem2          : TMenuItem;
    MenuItem3          : TMenuItem;
    MenuItem4          : TMenuItem;
    MenuItem5          : TMenuItem;
    PopupMenu1         : TPopupMenu;
    TrayIcon1          : TTrayIcon;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  Form1                 : TForm1;
  //FormAbout             : TFormAbout;
  S                     : LongInt;
  n                     : Integer;
  HasPassword           : Boolean;
  Password              : String;

implementation

{$R *.frm}

{ TForm1 }

procedure CameraOn;
begin
    S := fpsystem(concat('echo ', Password, ' | sudo -S modprobe uvcvideo'));
    if (S <> 0) then
       begin
           ShowMessage('Incorrect password');
           HasPassword := false;
       end;
end;

procedure CameraOff;
begin
    S := fpsystem(concat('echo ', Password, ' | sudo -S modprobe -r uvcvideo'));
    if (S <> 0) then
       begin
           ShowMessage('Incorrect password');
           HasPassword := false;
       end;
end;

procedure AskPassword;
begin
    Password := PasswordBox('Authorization Needed / User Input','Please Enter Password');
    HasPassword := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    S                           := fpsystem('echo off');
    HasPassword                 := false;
    application.showmainform    := false;
    TrayIcon1.Hint              := 'Camera Switch';
    TrayIcon1.ShowIcon          := True;
    TrayIcon1.Show;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
    if HasPassword then
       begin
           CameraOn;
       end
    else
        begin
          AskPassword;
          CameraOn;
        end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
    if HasPassword then
       begin
           CameraOff;
       end
    else
        begin
          AskPassword;
          CameraOff;
        end;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
    TrayIcon1.Hide;
    PopupMenu1.Free;
    TrayIcon1.Free;
    Halt (0);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
    HasPassword := false;
    ShowMessage('Password has been forgotten');
end;

procedure TForm1.MenuItem5Click(Sender: TObject);

begin
    FormAbout.Label1.Caption:='Project';
    FormAbout.Label2.Caption:='Developer';
    FormAbout.Label3.Caption:='Licence';
    FormAbout.ListBox1.Items.Clear;
    FormAbout.ListBox1.Items.Add('Camera Control On/Off Switch for Linux is a');
    FormAbout.ListBox1.Items.Add('LGPL2 Free Pascal Project with LCL components,');
    FormAbout.ListBox1.Items.Add('completely developed from scratch, at 23th, of');
    FormAbout.ListBox1.Items.Add('January 2020 by Linuxer パスカリス スポシト');
    FormAbout.Show;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
    PopupMenu1.PopUp;
end;

end.