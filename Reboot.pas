unit Reboot;

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
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Unix;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1                 : TButton;
    Button2                 : TButton;
    ListBox1                : TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
        LastAction          : byte;
        Password            : String;
        HasPassword         : boolean;
        AudioStringList     : TStringList;
        //AudioStringCounter  : integer;
  end;

var
  Form4                : TForm4;
  S                    : LongInt;
  FileString           : String;
  FileDestDir          : String;
  CmdString            : String;
  HomeDir              : String;
  Password             : String;

implementation

{$R *.frm}

{ TForm4 }

procedure UndoCameraBlacklist;
begin
     CmdString     := '';
     Password      := Form4.Password;
     FileDestDir   := '/etc/modprobe.d/blacklistuvcvideo.conf';
     CmdString     := Concat(Concat(Concat('echo ', Password), ' | sudo -S rm -f '), FileDestDir);
     S             := FpSystem(CmdString);
     if (S <> 0) then
        begin
             ShowMessage('Something went wrong with Undo. Please reverse your last action from the Menu!');
        end;
     CmdString     := '';

end;


procedure UndoCameraWhitelist;

begin
     CmdString     := '';
     Password      := Form4.Password;
     HomeDir       := expandfilename('~/');
     FileString    := Concat(HomeDir,'.blacklistuvcvideo ');
     FileDestDir   := '/etc/modprobe.d/blacklistuvcvideo.conf';
     CmdString     := Concat(Concat(Concat(Concat('echo ', Password), ' | sudo -S cp '), FileString), FileDestDir);
     S             := FpSystem(CmdString);
     if (S <> 0) then
        begin
             ShowMessage('Something went wrong with Undo. Please reverse your last action from the Menu!');
        end;
     CmdString     := '';
end;

procedure ReadAudioModulesFile;

var
  FileString  	  : string;
  HomeDir	  : string;
  AudioFileStream : TFileStream;

begin
     HomeDir      := expandfilename('~/');
     FileString   := Concat(HomeDir,'.blacklistaudio');
     //ShowMessage(Concat('Reading the contents of file: ', FileString));

     AudioFileStream :=  TFilestream.Create(FileString, fmOpenRead or fmShareDenyNone);

     try
        Form4.AudioStringList := TStringlist.Create;
        try
           Form4.AudioStringList.LoadFromStream(AudioFileStream);
           //ShowMessage(Form4.AudioStringList.text);
        finally
        end;

     finally
            AudioFileStream.free;
     end;

     //ShowMessage(Form4.AudioStringList.Text);
     //ShowMessage(Concat(Concat('File ', FileString), ' was probably read. Press enter to stop.'));
end;


Procedure ReloadAudioModulesFromDisk;   // Reload Kernel Modules
var
   n               : integer;
   m               : integer;
   Line            : String;

begin
     n := 0;
     m := Form4.AudioStringList.Count - 1;
     while (n <= m) do
          begin
               Line := Copy(Form4.AudioStringList.Strings[n], 11, Length(Form4.AudioStringList.Strings[n]));
               //ShowMessage(Line);
               CmdString     := Concat(Concat(Concat('echo ', Password), ' | sudo -S modprobe '), Line);
               S             := FpSystem(CmdString);
               Inc(n);
          end;

     ShowMessage('Audio Kernel Modules Reloaded. All went Ok.');
end;

procedure UndoAudioBlacklist;
begin
     ReadAudioModulesFile;
     ReloadAudioModulesFromDisk;
     CmdString     := '';
     FileDestDir   := '';
     Password      := Form4.Password;
     FileDestDir   := '/etc/modprobe.d/blacklistaudio.conf';
     CmdString     := Concat(Concat(Concat('echo ', Password), ' | sudo -S rm -f '), FileDestDir);

     S             := FpSystem(CmdString);
     if (S <> 0) then
        begin
             ShowMessage('Something went wrong with Undo. Please reverse your last action from the Menu!');
        end;

     CmdString     := '';
end;

procedure UndoAudioWhitelist;
begin
     CmdString     := '';
     Password      := Form4.Password;
     HomeDir       := expandfilename('~/');
     FileString    := Concat(HomeDir,'.blacklistaudio ');
     FileDestDir   := '/etc/modprobe.d/blacklistaudio.conf ';
     CmdString     := Concat(Concat(Concat(Concat('echo ', Password), ' | sudo -S cp '), FileString), FileDestDir);
     S             := FpSystem(CmdString);
     if (S <> 0) then
        begin
             ShowMessage('Something went wrong with Undo. Please reverse your last Action from the Menu!');
        end;
     CmdString     := '';
end;

procedure UndoLastAction;
var
   LastActionNo       : byte;
   //LastActionString : Array [0..3] of String;
begin
     LastActionNo     := Form4.LastAction;
     //LastActionString[0] := 'Camera was Blacklisted';
     //LastActionString[1] := 'Camera was Whitelisted';
     //LastActionString[2] := 'Audio was Blacklisted';
     //LastActionString[3] := 'Audio was Whitelisted';
     Form4.Hide;
     if (LastActionNo = 0) then
        begin
             UndoCameraBlacklist;
        end;
     if (LastActionNo = 1) then
        begin
             UndoCameraWhitelist;
        end;
     if (LastActionNo = 2) then
        begin
             UndoAudioBlacklist;
        end;
     if (LastActionNo = 3) then
        begin
             UndoAudioWhitelist;
        end;

     Form4.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
     UndoLastAction;
     Form4.AudioStringList.Free;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
     FpSystem('reboot');
end;

end.