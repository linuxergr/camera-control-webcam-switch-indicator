object Form3: TForm3
  Left = 468
  Height = 508
  Top = 45
  Width = 681
  Caption = 'External Events Logged'
  ClientHeight = 508
  ClientWidth = 681
  DesignTimePPI = 150
  LCLVersion = '2.1.0.0'
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
    Width = 678
    Color = clDefault
    ColCount = 2
    ParentFont = False
    RowCount = 11
    ScrollBars = ssAutoVertical
    TabOrder = 1
    TitleImageList = Form1.ImageListStatus
    ColWidths = (
      273
      441
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
