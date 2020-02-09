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
    Button1            : TButton;
    Button2            : TButton;
    ListBox1           : TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public
        LastAction     : byte;
        Password       : String;
        HasPassword    : boolean;

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

procedure UndoAudioBlacklist;
begin
     CmdString     := '';
     Password      := Form4.Password;
     FileDestDir   := '/etc/modprobe.d/blacklistaudio.conf';
     CmdString     := Concat(Concat(Concat('echo ', Password), ' | sudo -S rm -f '), FileDestDir);
     ShowMessage(CmdString);
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
   LastAction       : byte;
   //LastActionString : Array [0..3] of String;
begin
     //LastActionString[0] := 'Camera was Blacklisted';
     //LastActionString[1] := 'Camera was Whitelisted';
     //LastActionString[2] := 'Audio was Blacklisted';
     //LastActionString[3] := 'Audio was Whitelisted';
     //LastAction := Form4.LastAction;
     Form4.Hide;
     if (LastAction = 0) then
        begin
             UndoCameraBlacklist;
        end;
     if (LastAction = 1) then
        begin
             UndoCameraWhitelist;
        end;
     if (LastAction = 2) then
        begin
             UndoAudioBlacklist;
        end;
     if (LastAction = 3) then
        begin
             UndoAudioWhitelist;
        end;
     if (S = 0) then
        begin
             ShowMessage('Your last Action was undone, successfuly!');
        end;
     Form4.Close;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
     UndoLastAction;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
     FpSystem('reboot');
end;

end.