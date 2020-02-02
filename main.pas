unit Main;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020, by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal
// Redesigned and further Developed at 28th of January 2020, by Linuxer (https://gitlab.com/psposito)
// to provide Camera and Mic status alone with On/Off and Mute/Unmute fuctions
// Developed further for intrusion feeling and logging at 2nd of February 2020 by Linuxer (https://gitlab.com/psposito)

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, PopupNotifier, UTF8Process, VpClock, Unix, process, About, Logs;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1            : TButton;
    Button2            : TButton;
    ImageListCam       : TImageList;
    ImageListStatus    : TImageList;
    ImageListMic       : TImageList;
    AProcess           : TProcessUTF8;
    MenuItem1          : TMenuItem;
    MenuItem10         : TMenuItem;
    MenuItem11         : TMenuItem;
    MenuItem12         : TMenuItem;
    MenuItem13         : TMenuItem;
    MenuItem2          : TMenuItem;
    MenuItem3          : TMenuItem;
    MenuItem4          : TMenuItem;
    MenuItem5          : TMenuItem;
    MenuItem6          : TMenuItem;
    MenuItem7          : TMenuItem;
    MenuItem8          : TMenuItem;
    MenuItem9          : TMenuItem;
    PopupMenu1         : TPopupMenu;
    PopupMenu2         : TPopupMenu;
    ProcessUTF8_1      : TProcessUTF8;
    TrayIcon1          : TTrayIcon;
    TrayIcon2          : TTrayIcon;
    TrayIcon3          : TTrayIcon;
    VpClock1           : TVpClock;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon2Click(Sender: TObject);
    procedure TrayIcon3Click(Sender: TObject);
    procedure VpClock1SecondChange(Sender: TObject);
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
   MicStatus           : boolean;
   CamStatus           : boolean;
   HasPassword         : boolean;
   MicClicked          : boolean;
   CamClicked          : boolean;
   MicClicksCounter    : byte;
   CamClicksCounter    : byte;
   GridLine            : Integer;

implementation

{$R *.frm}

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
        begin
             isMicOn := true;
        end
     //if CompareText(MicSwitchStr,'[Off]') = 0 then
     else
        begin
             isMicOn := false;
        end;
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
     MicClicked                  := false;
     CamClicked                  := false;
     CamClicksCounter            := 0;
     MicClicksCounter            := 0;
     GridLine                    := 1;

     VpClock1.Active             := true;

     GetMicCaptureStatus;

     if (DirectoryExists('/dev/v4l/') or DirectoryExists('/dev/video0')) then
        begin
             ImageListCam.GetIcon(0, TrayIcon1.Icon);
             CamStatus := true;
             //ShowMessage('Camera is On');
        end
     else
        begin
             ImageListCam.GetIcon(1, TrayIcon1.Icon);
             CamStatus := false;
             //ShowMessage('Camera is Off');
        end;

     if isMicOn = true then
        begin
             ImageListMic.GetIcon(0, TrayIcon2.Icon);
             MicStatus := true;
        end;

     if isMicOn = false then
        begin
             ImageListMic.GetIcon(1, TrayIcon2.Icon);
             MicStatus := false;
        end;

     ImageListStatus.GetIcon(0, TrayIcon3.Icon);
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
     PopupMenu2.Free;
     TrayIcon1.Free;
     TrayIcon2.Free;
     TrayIcon3.Free;
     Halt (0);
end;

procedure TForm1.MenuItem12Click(Sender: TObject);  //ShowLogs;
begin
     Logs.Form3.Show;
end;

procedure TForm1.MenuItem13Click(Sender: TObject);  //ClearLogs;
begin
     ImageListStatus.GetIcon(0, TrayIcon3.Icon);
     Logs.Form3.StringGrid1.Clean;
     GridLine := 1;
     Logs.Form3.StringGrid1.InsertRowWithValues(0,['DateTime Stamp', 'Event Description']);
     ImageListStatus.GetIcon(0, TrayIcon3.Icon);
end;

procedure TForm1.MenuItem2Click(Sender: TObject);   // Password Reset
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
           CamClicksCounter := 1;
       end
    else
        begin
             AskPassword;
             CameraOn;
             if HasPassword then
                begin
                     ImageListCam.GetIcon(0, TrayIcon1.Icon);
                     CamClicksCounter := 1;
                end
        end;
    CamClicked := true;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);   // Camera Off
begin
     if HasPassword then
        begin
             CameraOff;
             ImageListCam.GetIcon(1, TrayIcon1.Icon);
             CamClicksCounter := 1;
        end
    else
        begin
             AskPassword;
             CameraOff;
             if HasPassword then
                begin
                     ImageListCam.GetIcon(1, TrayIcon1.Icon);
                     CamClicksCounter := 1;
                end
        end;
    CamClicked := true;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);   // Microphone Mute
begin
     S := fpsystem('amixer set Capture nocap');
     //ShowMessage('Microphone has been mutted');
     ImageListMic.GetIcon(1, TrayIcon2.Icon);
     MicClicked       := true;
     MicClicksCounter := 1;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);  // Microphone Unmute
begin
     S := fpsystem('amixer set Capture cap');
     //ShowMessage('Microphone has been mutted');
     ImageListMic.GetIcon(0, TrayIcon2.Icon);
     MicClicked       := true;
     MicClicksCounter := 1;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);  // About
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

procedure TForm1.TrayIcon3Click(Sender: TObject);
begin
     PopUpMenu2.PopUp;
end;

procedure TForm1.VpClock1SecondChange(Sender: TObject);
var
   HackedTime     : TDateTime;

begin
     GetMicCaptureStatus;

     if (DirectoryExists('/dev/v4l/') or DirectoryExists('/dev/video0')) then
        begin
             ImageListCam.GetIcon(0, TrayIcon1.Icon);
             If ((CamStatus = false) and (CamClicked = true) and (CamClicksCounter = 1)) then
                begin
                     CamClicked       := false;
                     CamClicksCounter := 0;
                     CamStatus        := true;
                end;
             If ((CamStatus = false) and (CamClicked = false) and (CamClicksCounter = 0)) then
                begin
                     HackedTime      := now;
                     ShowMessage('Camera hacked !!! Please Check Log');
                     Logs.Form3.StringGrid1.InsertRowWithValues(GridLine,[FormatDateTime('dd/mm/yyyy, ', HackedTime) + RightStr(DateTimeToStr(VPClock1.Time), 8), 'Camera Hacked to On']);
                     GridLine  := GridLine + 1;
                     CamStatus := true;
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                end;
        end
     else
        begin
             ImageListCam.GetIcon(1, TrayIcon1.Icon);
             If ((CamStatus = true) and (CamClicked = true) and (CamClicksCounter = 1)) then
                begin
                     CamClicked       := false;
                     CamClicksCounter := 0;
                     CamStatus        := false;
                end;
             If ((CamStatus = true) and (CamClicked = false) and (CamClicksCounter = 0)) then
                begin
                     HackedTime      := now;
                     ShowMessage('Camera hacked !!! Please Check Log');
                     Logs.Form3.StringGrid1.InsertRowWithValues(GridLine,[FormatDateTime('dd/mm/yyyy, ', HackedTime) + RightStr(DateTimeToStr(VPClock1.Time), 8), 'Camera Hacked to Off']);
                     CamStatus := false;
                     GridLine  := GridLine + 1;
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                end;
             //ShowMessage('Camera is Off');
        end;

     if isMicOn = true then
        begin
             ImageListMic.GetIcon(0, TrayIcon2.Icon);
             If ((MicStatus = false) and (MicClicked = true) and (MicClicksCounter = 1)) then
                begin
                     MicClicked       := false;
                     MicClicksCounter := 0;
                     MicStatus        := true;
                end;
             If ((MicStatus = false) and (MicClicked = false) and (MicClicksCounter = 0)) then
                begin
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                     HackedTime      := now;
                     ShowMessage('Microphone hacked !!! Please Check Log');
                     Logs.Form3.StringGrid1.InsertRowWithValues(GridLine,[FormatDateTime('dd/mm/yyyy, ', HackedTime) + RightStr(DateTimeToStr(VPClock1.Time), 8), 'Microphone Hacked to Muted']);
                     MicStatus := true;
                     GridLine  := GridLine + 1;
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                end;

        end;

     if isMicOn = false then
        begin
             ImageListMic.GetIcon(1, TrayIcon2.Icon);
             If ((MicStatus = true) and (MicClicked = true) and (MicClicksCounter = 1)) then
                begin
                     MicClicked       := false;
                     MicClicksCounter := 0;
                     MicStatus        := false;
                end;
             If ((MicStatus = true) and (MicClicked = false) and (MicClicksCounter = 0)) then
                begin
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                     HackedTime      := now;
                     ShowMessage('Microphone hacked !!! Please Check Log');
                     Logs.Form3.StringGrid1.InsertRowWithValues(GridLine,[FormatDateTime('dd/mm/yyyy, ', HackedTime) + RightStr(DateTimeToStr(VPClock1.Time), 8), 'Microphone Hacked to Unmuted']);
                     MicStatus := false;
                     GridLine  := GridLine + 1;
                     ImageListStatus.GetIcon(1, TrayIcon3.Icon);
                end;
        end;
end;

end.