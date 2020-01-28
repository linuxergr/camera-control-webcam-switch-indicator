unit Main;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020, by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal
// Redesigned and further Developed at 28th of January 2020, by Linuxer (https://gitlab.com/psposito)
// to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, UTF8Process, Unix, process, About;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1            : TButton;
    Button2            : TButton;
    ImageListCam       : TImageList;
    ImageListMic       : TImageList;
    AProcess           : TProcessUTF8;
    MenuItem1          : TMenuItem;
    MenuItem10         : TMenuItem;
    MenuItem11         : TMenuItem;
    MenuItem2          : TMenuItem;
    MenuItem3          : TMenuItem;
    MenuItem4          : TMenuItem;
    MenuItem5          : TMenuItem;
    MenuItem6          : TMenuItem;
    MenuItem7          : TMenuItem;
    MenuItem8          : TMenuItem;
    MenuItem9          : TMenuItem;
    PopupMenu1         : TPopupMenu;
    ProcessUTF8_1      : TProcessUTF8;
    TrayIcon1          : TTrayIcon;
    TrayIcon2          : TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon2Click(Sender: TObject);
  private
    CamImageIndex    : integer;
    MicImageIndex    : integer;

  public

  end;

var
   Form1               : TForm1;
   S                   : LongInt;
   MicSwitchStr        : String;
   Password            : String;
   isMicOn             : boolean;
   HasPassword         : boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure GetMicCaptureStatus;
var
     AStringList : TStringList;
     AProcess    : TProcess;
begin
     AProcess := TProcess.Create(nil);
     AProcess.Executable := '/bin/sh';
     AProcess.Parameters.Add('-c');
     AProcess.Parameters.Add('amixer get Capture control');
     AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];
     AProcess.Execute;
     AStringList := TStringList.Create;
     AStringList.LoadFromStream(AProcess.Output);
     //showmessage(Astringlist.Text) ;
     MicSwitchStr := TrimLeft(RightStr(AStringList.Strings[AstringList.Count-1], 5));
     //showmessage(AStringList.Strings[AstringList.Count-1]);
     //showmessage(MicSwitchStr);
     if CompareText(MicSwitchStr,'[On]') = 0 then
        isMicOn := true
     //if CompareText(MicSwitchStr,'[Off]') = 0 then
     else
        isMicOn := false;
     //if isMicOn = true then
     //   showmessage('Mic is on');
     //if isMicOn = false then
     //   showmessage('Mic is off');
     AStringList.Free;
     AProcess.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);  // Toggle Camera On/Off
begin
     CamImageIndex := (CamImageIndex + 1) mod 2;
     //If ImageIndex=0 then
     //   ShowMessage('Camera is On')
     //else
     //   ShowMessage('Camera is Off');
     //GetImageList.GetIcon(ImageIndex, TrayIcon1.Icon);
     ImageListCam.GetIcon(CamImageIndex, TrayIcon1.Icon);
end;

procedure TForm1.Button2Click(Sender: TObject);  // Toggle Microphne On/Off
begin
     MicImageIndex := (MicImageIndex + 1) mod 2;
     //If ImageIndex=0 then
     //   ShowMessage('Camera is On')
     //else
     //   ShowMessage('Camera is Off');
     //GetImageList.GetIcon(ImageIndex, TrayIcon1.Icon);
     ImageListMic.GetIcon(MicImageIndex, TrayIcon2.Icon);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     application.showmainform    := false;    // Hide Main form
     HasPassword                 := false;
     CamImageIndex               := 0;
     MicImageIndex               := 0;

     GetMicCaptureStatus;

     if DirectoryExists('/dev/v4l/') then
        begin
             ImageListCam.GetIcon(0, TrayIcon1.Icon);
             //ShowMessage('Camera is On');
        end
     else
        begin
             ImageListCam.GetIcon(1, TrayIcon1.Icon);
             //ShowMessage('Camera is Off');
        end;

     if isMicOn = true then
        begin
             ImageListMic.GetIcon(0, TrayIcon2.Icon);
        end;

     if isMicOn = false then
        begin
             ImageListMic.GetIcon(1, TrayIcon2.Icon);
        end;
     //ImageListCam.GetIcon(0, TrayIcon1.Icon);
     //ImageListMic.GetIcon(0, TrayIcon2.Icon);
     //ShowMessage('Press Ok');
     //ImageListCam.GetIcon(1, TrayIcon1.Icon);
     //ImageListMic.GetIcon(1, TrayIcon2.Icon);
     //GetImageList.GetIcon(ImageIndex, TrayIcon1.Icon);
end;

procedure TForm1.MenuItem10Click(Sender: TObject);   // Exit
begin
     ImageListCam.Free;
     ImageListMic.Free;
     PopupMenu1.Free;
     TrayIcon1.Free;
     TrayIcon2.Free;
     Halt (0);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
     HasPassword := false;
     ShowMessage('Passsword, has been reset');
end;

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

procedure TForm1.MenuItem3Click(Sender: TObject);   // Camera On
begin
     if HasPassword then
       begin
           CameraOn;
           ImageListCam.GetIcon(0, TrayIcon1.Icon);
       end
    else
        begin
          AskPassword;
          CameraOn;
          if HasPassword then
             ImageListCam.GetIcon(0, TrayIcon1.Icon);
        end;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);   // Camera Off
begin
     if HasPassword then
       begin
           CameraOff;
           ImageListCam.GetIcon(1, TrayIcon1.Icon);
       end
    else
        begin
          AskPassword;
          CameraOff;
          if HasPassword then
             ImageListCam.GetIcon(1, TrayIcon1.Icon);
        end;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);   // Microphone Mute
begin
     S := fpsystem('amixer set Capture nocap');
     //ShowMessage('Microphone has been mutted');
     ImageListMic.GetIcon(1, TrayIcon2.Icon);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);  // Microphone Unmute
begin
     S := fpsystem('amixer set Capture cap');
     //ShowMessage('Microphone has been mutted');
     ImageListMic.GetIcon(0, TrayIcon2.Icon);
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
     About.Form2.Label1.Caption:='Developer';
     About.Form2.Label2.Caption:='Licence';
     About.Form2.Label3.Caption:='Project';
     About.Form2.ListBox1.Items.Clear;
     About.Form2.ListBox1.Items.Add('Camera & Microphone Control Switches for Linux is');
     About.Form2.ListBox1.Items.Add('an LGPL2 Free Pascal Project with LCL components,');
     About.Form2.ListBox1.Items.Add('completely developed from scratch, at 23th, of');
     About.Form2.ListBox1.Items.Add('January 2020 by Linuxer パスカリス スポシト');
     About.Form2.ListBox1.Items.Add('Redesigned and further Developed at 28th of January');
     About.Form2.ListBox1.Items.Add('2020, by Linuxer (https://gitlab.com/psposito), to ');
     About.Form2.ListBox1.Items.Add('provide Camera and Mic status alone with On/Off and');
     About.Form2.ListBox1.Items.Add('Mute/Unmute fuctions');
     About.Form2.Show;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
     PopUpMenu1.PopUp;
end;

procedure TForm1.TrayIcon2Click(Sender: TObject);
begin
     PopUpMenu1.PopUp;
end;

end.

