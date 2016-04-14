object ACOForm: TACOForm
  Left = 311
  Top = 137
  Width = 977
  Height = 779
  Caption = 'Path Antennation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object DistLbl: TLabel
    Left = 592
    Top = 40
    Width = 72
    Height = 13
    Caption = 'Best Distance: '
  end
  object CityLbl: TLabel
    Left = 360
    Top = 40
    Width = 83
    Height = 13
    Caption = 'Number of Cities: '
  end
  object genLbl: TLabel
    Left = 824
    Top = 40
    Width = 60
    Height = 13
    Caption = 'Generations:'
  end
  object ProgressLbl: TLabel
    Left = 608
    Top = 672
    Width = 55
    Height = 13
    Caption = 'ProgressLbl'
    Visible = False
  end
  object oneTourBtn: TButton
    Left = 32
    Top = 128
    Width = 75
    Height = 25
    Caption = 'One Tour'
    Enabled = False
    TabOrder = 0
    OnClick = oneTourBtnClick
  end
  object configBtn: TButton
    Left = 80
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Config'
    Enabled = False
    TabOrder = 1
    OnClick = configBtnClick
  end
  object loadBtn: TButton
    Left = 176
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Load Map'
    TabOrder = 2
    OnClick = loadBtnClick
  end
  object nTourBtn: TButton
    Left = 128
    Top = 128
    Width = 75
    Height = 25
    Caption = 'N Tours'
    Enabled = False
    TabOrder = 3
    OnClick = nTourBtnClick
  end
  object batchBtn: TButton
    Left = 32
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Batch'
    Enabled = False
    TabOrder = 4
    OnClick = batchBtnClick
  end
  object pChart: TChart
    Left = 16
    Top = 240
    Width = 329
    Height = 185
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Pheromone Chart')
    View3D = False
    TabOrder = 5
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'av P'
      LinePen.Color = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'max P'
      LinePen.Color = clGreen
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object runBtn: TButton
    Left = 224
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Run'
    Enabled = False
    TabOrder = 6
    OnClick = runBtnClick
  end
  object resetBtn: TButton
    Left = 224
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Reset'
    Enabled = False
    TabOrder = 7
    OnClick = resetBtnClick
  end
  object mapPnl: TPanel
    Left = 360
    Top = 64
    Width = 600
    Height = 600
    BorderWidth = 3
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 8
    object mapImg: TImage
      Left = 0
      Top = 0
      Width = 600
      Height = 600
    end
  end
  object restartBtn: TButton
    Left = 128
    Top = 632
    Width = 75
    Height = 25
    Caption = 'Restart'
    TabOrder = 9
    OnClick = restartBtnClick
  end
  object AntenRadGrp: TRadioGroup
    Left = 48
    Top = 440
    Width = 233
    Height = 169
    Caption = 'Antennation Factor'
    ItemIndex = 0
    Items.Strings = (
      'None'
      '1 - AF'
      '1 - AF *(path taken/total Ants) '
      '1 - AF *(path taken/total Ants)^2 '
      '1 - AF *(path taken/total Ants) ^1/2'
      '1 - AF *Tanh(path taken/total Ants^1/2) ')
    TabOrder = 10
    OnClick = AntenRadGrpClick
  end
  object BPrgsBar: TProgressBar
    Left = 360
    Top = 688
    Width = 601
    Height = 49
    TabOrder = 11
  end
  object tspOpen: TOpenDialog
    Left = 8
    Top = 8
  end
  object SaveMapDialog: TSavePictureDialog
    Left = 48
    Top = 8
  end
end
