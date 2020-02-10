unit Main;

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
  Menus, PopupNotifier, UTF8Process, VpClock, Unix, process, About, Logs, Reboot;

type

  { TForm1 }

  TForm1 = class(TForm)
    ImageListCam       : TImageList;
    ImageListStatus    : TImageList;
    ImageListMic       : TImageList;
    AProcess           : TProcessUTF8;
    ImageListSystem    : TImageList;
    MenuItem1          : TMenuItem;
    MenuItem10         : TMenuItem;
    MenuItem11         : TMenuItem;
    MenuItem12         : TMenuItem;
    MenuItem13         : TMenuItem;
    MenuItem14         : TMenuItem;
    MenuItem15         : TMenuItem;
    MenuItem16         : TMenuItem;
    MenuItem17         : TMenuItem;
    MenuItem18         : TMenuItem;
    MenuItem19         : TMenuItem;
    MenuItem2          : TMenuItem;
    MenuItem20         : TMenuItem;
    MenuItem21         : TMenuItem;
    MenuItem22         : TMenuItem;
    MenuItem23         : TMenuItem;
    MenuItem24         : TMenuItem;
    MenuItem25         : TMenuItem;
    MenuItem26         : TMenuItem;
    MenuItem27         : TMenuItem;
    MenuItem28         : TMenuItem;
    MenuItem29         : TMenuItem;
    MenuItem3          : TMenuItem;
    MenuItem30         : TMenuItem;
    MenuItem31         : TMenuItem;
    MenuItem32         : TMenuItem;
    MenuItem33         : TMenuItem;
    MenuItem35         : TMenuItem;
    MenuItem39         : TMenuItem;
    MenuItem4          : TMenuItem;
    MenuItem40         : TMenuItem;
    MenuItem41         : TMenuItem;
    MenuItem42         : TMenuItem;
    MenuItem43         : TMenuItem;
    MenuItem44         : TMenuItem;
    MenuItem45         : TMenuItem;
    MenuItem5          : TMenuItem;
    MenuItem6          : TMenuItem;
    MenuItem7          : TMenuItem;
    MenuItem8          : TMenuItem;
    MenuItem9          : TMenuItem;
    PopupMenu1         : TPopupMenu;
    PopupMenu2         : TPopupMenu;
    PopupMenu3         : TPopupMenu;
    PopupMenu4         : TPopupMenu;
    PopupMenu5         : TPopupMenu;
    ProcessUTF8_1      : TProcessUTF8;
    TrayIcon1          : TTrayIcon;
    TrayIcon2          : TTrayIcon;
    TrayIcon3          : TTrayIcon;
    TrayIcon4          : TTrayIcon;
    VpClock1           : TVpClock;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem29Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon2Click(Sender: TObject);
    procedure TrayIcon3Click(Sender: TObject);
    procedure TrayIcon4Click(Sender: TObject);
    procedure VpClock1SecondChange(Sender: TObject);
  private
    CamImageIndex    : integer;
    MicImageIndex    : integer;

  public

  end;

var
   ReleaseNo           : String;
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
   SndCardsStringList  : TStringList;
   SndCardsCountNumber : Integer;
   n                   : Integer;
   HomeDir             : String;
   CmdString           : String;
   FileString          : String;
   FileDestDir         : String;
   LastAction          : byte;
// RebootCancelled     : boolean;

implementation

procedure RebootSystem; forward;

{$R *.frm}

{ TForm1 }

procedure SetReleaseNo;
begin
     ReleaseNo := '1.2.3';
end;

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
     MicSwitchStr := TrimLeft(RightStr(AStringList.Strings[AstringList.Count-1], 5));
     if CompareText(MicSwitchStr,'[On]') = 0 then
        begin
             isMicOn := true;
        end
     //if CompareText(MicSwitchStr,'[Off]') = 0 then
     else
        begin
             isMicOn := false;
        end;
     AStringList.Free;
     AProcess.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     SetReleaseNo;
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

     ImageListStatus.GetIcon(0, TrayIcon3.Icon);

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
             //ShowMessage('Camera is Off or No Camera exists');
        end;

     GetMicCaptureStatus;

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

     ImageListSystem.GetIcon(0, TrayIcon4.Icon);
end;

procedure CheckSStatus;
begin
     if (S <> 0) then
        begin
             if (S = 256) then
                begin
                     ShowMessage('Incorrect password');
                end;
             if (S <> 256) then
                begin
                     ShowMessage('Error Number: ' + IntToStr(S));
                end;
           HasPassword := false;
       end;
end;

procedure GetSoundCards;            // GetSoundCards Unique Driver Names
var
     AStringList : TStringList;
     AProcess    : TProcess;
     m           : Integer;
     n           : Integer;
     RightChar   : Integer;

begin
     AProcess                      := TProcess.Create(nil);
     AProcess.Executable           := '/bin/sh';
     AProcess.Parameters.Add('-c');
     AProcess.Parameters.Add('cat /proc/asound/modules ');
     AProcess.Options              := AProcess.Options + [poWaitOnExit, poUsePipes];
     AProcess.Execute;
     AStringList                   := TStringList.Create;
     SndCardsStringList            := TStringList.Create;
     SndCardsStringList.Sorted     := true;
     SndCardsStringList.Duplicates := dupIgnore;
     AStringList.LoadFromStream(AProcess.Output);

     m                   := AStringList.Count - 1;
     n                   := 0;
     SndCardsCountNumber := 0;

     While (n <= m) do
           begin
                RightChar           := Pos(' ', AStringList.Strings[n]) + 1;
                SndCardsStringList.AddStrings(Copy(AStringList.Strings[n], RightChar + 2, (Length(AStringList.Strings[n]))));
                n := n + 1;
           end;
     SndCardsCountNumber := SndCardsStringList.Count - 1;
     AStringList.Free;
     AProcess.Free;
end;

procedure AskPassword;
begin
    Password       := PasswordBox('Authorization Needed / User Input','Please Enter Password');
    HasPassword    := True;
end;

procedure TForm1.MenuItem10Click(Sender: TObject);   // Exit
begin
     Form1.Close;
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

procedure TForm1.MenuItem27Click(Sender: TObject);  // Blaclist Camera and Reboot
var
     BlackListStr  : String;
begin
     Password := '';
     AskPassword;
     CmdString     := '';
     HomeDir       := expandfilename('~/');
     FileString    := Concat(HomeDir,'.blacklistuvcvideo ');
     FileDestDir   := '/etc/modprobe.d/blacklistuvcvideo.conf ';
     BlackListStr  := '''blacklist uvcvideo''';

     if (FileExists(FileDestDir) = false) then
        begin
             if (HasPassword = false) then
                begin
                     AskPassword;
                end;

             CmdString := Concat('rm ', FileString);
             S := FpSystem(CmdString);

             CmdString := Concat(Concat(Concat('echo ', BlackListStr),' >> '), FileString);
             S := FpSystem(CmdString);

             CmdString := Concat(Concat(Concat(Concat('echo ', Password), ' | sudo -S cp '), FileString), FileDestDir);
             S := FpSystem(CmdString);

             CheckSStatus;
             if (S = 0) then
                begin
                     LastAction := 0;
                     RebootSystem;
                end;
        end
     else
         begin
              ShowMessage('Camera was not Whitelisted');
         end;
     CmdString     := '';
end;

procedure TForm1.MenuItem29Click(Sender: TObject);  // Whitelist Camera and Reboot
begin
     Password := '';
     AskPassword;
     CmdString     := '';
     FileDestDir   := '/etc/modprobe.d/blacklistuvcvideo.conf';
     if (FileExists(FileDestDir) = true) then
        begin
        If (HasPassword = false) then
           begin
                AskPassword;
           end;
           CmdString   := Concat(Concat(Concat('echo ', Password), ' | sudo -S rm '), FileDestDir);
           S := FpSystem(CmdString);
           CheckSStatus;
           if (S = 0) then
              begin
                   LastAction := 1;
                   RebootSystem;
              end;
        end
     else
         begin
              ShowMessage('Camera was not Blacklisted');
         end;
     CmdString     := '';
end;

procedure TForm1.MenuItem2Click(Sender: TObject);   // Password Reset
begin
     HasPassword := false;
     ShowMessage('Passsword, has been reset');
end;


procedure TForm1.MenuItem32Click(Sender: TObject); // Blacklist Audio and Reboot
begin
     Password := '';
     HasPassword := false;
     CmdString     := '';
     AskPassword;
     GetSoundCards;
     HomeDir       := expandfilename('~/');
     FileString    := Concat(HomeDir,'.blacklistaudio ');
     FileDestDir   := '/etc/modprobe.d/blacklistaudio.conf ';
     S             := FpSystem(CmdString);

     if  SndCardsStringList <> Nil then
         begin
              CmdString := Concat(Concat('rm ', HomeDir),'.blacklistaudio');
              S := FpSystem(CmdString);
              //ShowMessage(SndCardsStringList.Text);
              for n := 0 to SndCardsStringList.Count - 1 do
                  begin
                       CmdString  := Concat(Concat(Concat(Concat('echo blacklist ''', SndCardsStringList.Strings[n])), ''' >> '), FileString);
                       S:= FpSystem(CmdString);
                  end;
              If (HasPassword = false) then
                 begin
                      AskPassword;
                 end;
              CmdString  := Concat(Concat(Concat(Concat('echo ', Password), ' | sudo -S cp '), FileString), FileDestDir);
              S:= FpSystem(CmdString);
              CheckSStatus;
               if (S = 0) and (HasPassword = true) then
                  begin
                       LastAction := 2;
                       RebootSystem;
                  end;
         end
     else
         begin
              ShowMessage('Audio Card(s) not Whitelisted before');
         end;
     CmdString     := '';
end;

procedure TForm1.MenuItem33Click(Sender: TObject); // Whitelistlist Audio and Reboot
begin
     Password := '';
     HasPassword := false;
     CmdString     := '';
     AskPassword;
     FileString    := '/etc/modprobe.d/blacklistaudio.conf';
     CmdString     := Concat(Concat(Concat('echo ', Password), ' | sudo -S rm '), FileString);

     if (FileExists(FileString) = true) then
        begin
             If (HasPassword = false) then
                begin
                     AskPassword;
                end;
             S:= FpSystem(CmdString);
             CheckSStatus;
             if (S = 0) and (HasPassword = true) then
                begin
                     LastAction := 3;
                     RebootSystem;
                end;
        end
     else
         begin
              ShowMessage('Audio Card(s) not Blacklisted before');
         end;
     CmdString     := '';
end;

procedure RebootSystem;
begin
     Reboot.Form4.Button2.Default   := true;
     Reboot.Form4.ListBox1.Items.Add('      System will now Reboot!!!     ');
     Reboot.Form4.ListBox1.Items.Add(' ');
     Reboot.Form4.ListBox1.Items.Add('Please make sure that you have saved');
     Reboot.Form4.ListBox1.Items.Add('all of your files and closed all open');
     Reboot.Form4.ListBox1.Items.Add('Windows, before pressing the Reboot ');
     Reboot.Form4.ListBox1.Items.Add('Button below.');
     Form4.Password     := Password;
     Form4.HasPassword  := HasPassword;
     Form4.LastAction   := LastAction;
     Reboot.Form4.Show;
end;

procedure CameraOn;
begin
    S := FpSystem(Concat('echo ', Password, ' | sudo -S modprobe uvcvideo'));
    CheckSStatus;
end;

procedure CameraOff;
begin
    S := FpSystem(Concat('echo ', Password, ' | sudo -S rmmod -f uvcvideo'));
    //S := FpSystem(Concat('echo ', Password, ' | sudo -S modprobe -r uvcvideo'));
    CheckSStatus;
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
     S := FpSystem('amixer set Capture nocap');
     //ShowMessage('Microphone has been mutted');
     ImageListMic.GetIcon(1, TrayIcon2.Icon);
     MicClicked       := true;
     MicClicksCounter := 1;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);  // Microphone Unmute
begin
     S := FpSystem('amixer set Capture cap');
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
     About.Form2.ListBox1.Items.Add(Concat('Camera & Microphone Control Switches for Linux Rel. ', ReleaseNo));
     About.Form2.ListBox1.Items.Add('is an LGPL2 Free Pascal Project with LCL components,');
     About.Form2.ListBox1.Items.Add('completely developed from scratch, at 23th, of January 2020 by');
     About.Form2.ListBox1.Items.Add('Linuxer パスカリス スポシト');
     About.Form2.ListBox1.Items.Add(' ');
     About.Form2.ListBox1.Items.Add('Redesigned and further Developed at 28th of January 2020,');
     About.Form2.ListBox1.Items.Add('in order to provide Camera and Mic statuses alone with On/Off and');
     About.Form2.ListBox1.Items.Add('Mute/Unmute fuctions');
     About.Form2.ListBox1.Items.Add(' ');
     About.Form2.ListBox1.Items.Add('Final Development Stage at 6th of February 2020, for System ');
     About.Form2.ListBox1.Items.Add('Blacklist/Whitelist Modules functions for Camera and Audio');
     About.Form2.Show;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
     PopUpMenu4.PopUp;
end;

procedure TForm1.TrayIcon2Click(Sender: TObject);
begin
     PopUpMenu3.PopUp;
end;

procedure TForm1.TrayIcon3Click(Sender: TObject);
begin
     PopUpMenu2.PopUp;
end;

procedure TForm1.TrayIcon4Click(Sender: TObject);
begin
     PopUpMenu5.PopUp;
end;

procedure TForm1.VpClock1SecondChange(Sender: TObject);    // Check Statuses and External Events Notifications and Logs
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
             //ShowMessage('Camera is On');
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