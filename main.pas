unit Main;

{$mode objfpc}{$H+}
{$warnings off}
{$hints off}

// Created at 23th of January 2020 by Linuxer (https://gitlab.com/psposito), from scratch with Free Pascal

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Menus, Unix,
  unitAbout, PopupNotifier;

type

  { TForm1 }

  TForm1 = class(TForm)
    ImageList2: TImageList;
    MenuItem1          : TMenuItem;
    MenuItem2          : TMenuItem;
    MenuItem3          : TMenuItem;
    MenuItem4          : TMenuItem;
    MenuItem5          : TMenuItem;
    MenuItem6          : TMenuItem;
    MenuItem7          : TMenuItem;
    MenuItem8          : TMenuItem;
    MenuItem9          : TMenuItem;
    PopupMenu1         : TPopupMenu;
    TrayIcon1          : TTrayIcon;
    ImageList1         : TImageList;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
  private

  public

  end;

var
  Form1                 : TForm1;
  S                     : LongInt;
  n                     : Integer;
  HasPassword           : Boolean;
  Password              : String;
  Bitmap                : TBitMap;

implementation

{$R *.frm}

{ TForm1 }

procedure ScaleImageList(ImgList: TImageList; NewWidth, NewHeight: Integer);
var
  TempImgList: TImageList;
  TempBmp1: TBitmap;
  TempBmp2: TBitmap;
  I: Integer;
begin
  TempImgList := TImageList.Create(nil);
  TempBmp1 := TBitmap.Create;
  TempBmp1.PixelFormat := pf32bit;
  TempBmp2 := TBitmap.Create;
  TempBmp2.PixelFormat := pf32bit;
  TempBmp2.SetSize(NewWidth, NewHeight);
  try
    TempImgList.Width := NewWidth;
    TempImgList.Height := NewHeight;

    for I := 0 to ImgList.Count - 1 do begin
      // Load image for given index to temporary bitmap
      ImgList.GetBitmap(I, TempBmp1);

      // Clear transparent image background
      TempBmp2.Canvas.Brush.Style := bsSolid;
      TempBmp2.Canvas.Brush.Color := TempBmp2.TransparentColor;
      TempBmp2.Canvas.FillRect(0, 0, TempBmp2.Width, TempBmp2.Height);

      // Stretch image to new size
      TempBmp2.Canvas.StretchDraw(Rect(0, 0, TempBmp2.Width, TempBmp2.Height), TempBmp1);
      TempImgList.Add(TempBmp2, nil);
    end;

    ImgList.Assign(TempImgList);
  finally
    TempImgList.Free;
    TempBmp1.Free;
    TempBmp2.Free;
  end;
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

procedure TForm1.FormCreate(Sender: TObject);
begin
    S                           := fpsystem('echo off');
    ImageList1.Width            := 64;
    ImageList1.Height           := 64;
    ImageList1.Scaled           := true;
    //ImageList2.Width            := 64;
    //ImageList2.Height           := 64;
    //ImageList2.Scaled           := true;

    HasPassword                 := false;
    application.showmainform    := false;
    TrayIcon1.Hint              := 'Camera Switcher';

    if DirectoryExists('/dev/v4l/') then
       begin
            ImageList1.GetIcon(0, TrayIcon1.Icon);
            ShowMessage('Camera is On');
       end
    else
       begin
            ImageList1.GetIcon(1, TrayIcon1.Icon);
            ShowMessage('Camera is Off');
       end;
    TrayIcon1.ShowIcon          := True;
    TrayIcon1.Show;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
    if HasPassword then
       begin
           CameraOn;
           ImageList1.GetIcon(0, TrayIcon1.Icon);
       end
    else
        begin
          AskPassword;
          CameraOn;
          if HasPassword then
             ImageList1.GetIcon(0, TrayIcon1.Icon);
        end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
    if HasPassword then
       begin
           CameraOff;
           ImageList1.GetIcon(1, TrayIcon1.Icon);
       end
    else
        begin
          AskPassword;
          CameraOff;
          if HasPassword then
             ImageList1.GetIcon(1, TrayIcon1.Icon);
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
    FormAbout.ListBox1.Items.Add('Camera Control On/Off Switch for Linux is an');
    FormAbout.ListBox1.Items.Add('LGPL2 Free Pascal Project with LCL components,');
    FormAbout.ListBox1.Items.Add('completely developed from scratch, at 23th, of');
    FormAbout.ListBox1.Items.Add('January 2020 by Linuxer パスカリス スポシト');
    FormAbout.Show;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
     S := fpsystem('amixer set Capture cap');
     ShowMessage('Microphone has been unmutted');
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
    S := fpsystem('amixer set Capture nocap');
    ShowMessage('Microphone has been mutted');
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
    PopupMenu1.PopUp;
end;

end.