object Form3: TForm3
  Left = 468
  Height = 504
  Top = 45
  Width = 676
  Caption = 'Events Logged'
  ClientHeight = 504
  ClientWidth = 676
  DesignTimePPI = 150
  LCLVersion = '7.0'
  object Button1: TButton
    Left = 0
    Height = 48
    Top = 456
    Width = 679
    Caption = 'Close'
    OnClick = Button1Click
    TabOrder = 0
  end
  object StringGrid1: TStringGrid
    Left = 2
    Height = 400
    Top = 48
    Width = 671
    ParentFont = False
    ScrollBars = ssAutoVertical
    TabOrder = 1
    ColWidths = (
      273
      441
      100
      100
      100
    )
    Cells = (
      2
      0
      0
      'DateTime Stamp'
      1
      0
      'Event Description'
    )
  end
end
