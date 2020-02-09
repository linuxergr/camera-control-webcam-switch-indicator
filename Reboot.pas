object Form4: TForm4
  Left = 455
  Height = 315
  Top = 45
  Width = 477
  Caption = 'Sytem Reboot'
  ClientHeight = 315
  ClientWidth = 477
  DesignTimePPI = 150
  Position = poScreenCenter
  LCLVersion = '7.0'
  object ListBox1: TListBox
    Left = 0
    Height = 248
    Top = 16
    Width = 472
    Font.Style = [fsBold]
    ItemHeight = 0
    ParentFont = False
    ScrollWidth = 468
    TabOrder = 0
    TopIndex = -1
  end
  object Button1: TButton
    Left = 56
    Height = 39
    Top = 272
    Width = 117
    Caption = 'Reboot'
    OnClick = Button1Click
    TabOrder = 1
  end
  object Button2: TButton
    Left = 288
    Height = 39
    Top = 272
    Width = 117
    Caption = 'Cancel'
    OnClick = Button2Click
    TabOrder = 2
  end
end
