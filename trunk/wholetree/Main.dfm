object ACOForm: TACOForm
  Left = 495
  Top = 160
  Width = 987
  Height = 785
  Caption = 'Whole tree Antennation'
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
    Left = 504
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
    Left = 648
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
  object AntMeetLbl: TLabel
    Left = 808
    Top = 40
    Width = 65
    Height = 13
    Caption = 'Ant Meetings:'
  end
  object oneTourBtn: TButton
    Left = 32
    Top = 96
    Width = 75
    Height = 25
    Caption = 'One Tour'
    Enabled = False
    TabOrder = 0
    OnClick = oneTourBtnClick
  end
  object initBtn: TButton
    Left = 168
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Initialise'
    Enabled = False
    TabOrder = 1
    OnClick = initBtnClick
  end
  object loadBtn: TButton
    Left = 72
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Load Map'
    TabOrder = 2
    OnClick = loadBtnClick
  end
  object nTourBtn: TButton
    Left = 128
    Top = 96
    Width = 75
    Height = 25
    Caption = 'N Tours'
    Enabled = False
    TabOrder = 3
    OnClick = nTourBtnClick
  end
  object batchBtn: TButton
    Left = 32
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Batch'
    Enabled = False
    TabOrder = 4
    OnClick = batchBtnClick
  end
  object pChart: TChart
    Left = 8
    Top = 184
    Width = 345
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
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Run'
    Enabled = False
    TabOrder = 6
    OnClick = runBtnClick
  end
  object resetBtn: TButton
    Left = 128
    Top = 144
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
    Left = 224
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Restart'
    TabOrder = 9
    OnClick = restartBtnClick
  end
  object BPrgsBar: TProgressBar
    Left = 360
    Top = 688
    Width = 601
    Height = 49
    TabOrder = 10
  end
  object SettingsPnl: TPanel
    Left = 8
    Top = 376
    Width = 345
    Height = 361
    Caption = ' '
    TabOrder = 11
    object Label1: TLabel
      Left = 32
      Top = 20
      Width = 283
      Height = 13
      Caption = 'City Move Probability:= Pheromone ^ Beta * Distance^Alpha'
    end
    object BetaEdit: TLabeledEdit
      Left = 184
      Top = 60
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Beta Value'
      TabOrder = 0
      Text = '-2'
      OnExit = BetaEditExit
    end
    object AlphaEdit: TLabeledEdit
      Left = 32
      Top = 60
      Width = 121
      Height = 21
      EditLabel.Width = 57
      EditLabel.Height = 13
      EditLabel.Caption = 'Alpha Value'
      TabOrder = 1
      Text = '2'
      OnExit = AlphaEditExit
    end
    object AntTypeGrp: TRadioGroup
      Left = 56
      Top = 232
      Width = 233
      Height = 105
      Caption = 'Antennation Factor'
      ItemIndex = 0
      Items.Strings = (
        'None'
        '1 - AF'
        '1 - AF *(path taken/total Ants) '
        '1 - AF *(path taken/total Ants)^2 '
        '1 - AF *(path taken/total Ants) ^1/2'
        '1 - AF *Tanh(path taken/total Ants^1/2) '
        '1/(1+sqrt(path taken))')
      TabOrder = 2
      OnClick = AntTypeGrpClick
    end
    object PherInitEdit: TLabeledEdit
      Left = 32
      Top = 108
      Width = 121
      Height = 21
      EditLabel.Width = 81
      EditLabel.Height = 13
      EditLabel.Caption = 'Initial Pheromone'
      TabOrder = 3
      Text = '0.1'
      OnExit = PherInitEditExit
    end
    object PherDecayEdit: TLabeledEdit
      Left = 32
      Top = 148
      Width = 121
      Height = 21
      EditLabel.Width = 102
      EditLabel.Height = 13
      EditLabel.Caption = 'Decaying Pheromone'
      TabOrder = 4
      Text = '0.1'
      OnExit = PherDecayEditExit
    end
    object PherAddEdit: TLabeledEdit
      Left = 184
      Top = 108
      Width = 121
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = 'Laying Pheromone'
      TabOrder = 5
      Text = '0.5'
      OnExit = PherAddEditExit
    end
    object AntFEdit: TLabeledEdit
      Left = 104
      Top = 193
      Width = 121
      Height = 21
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Antennation Factor'
      TabOrder = 6
      Text = '0.1'
      OnExit = AntFEditExit
    end
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
