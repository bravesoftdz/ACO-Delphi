object ACOForm: TACOForm
  Left = 214
  Top = 60
  Width = 981
  Height = 796
  Caption = 'Expanded AAS'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
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
    Left = 368
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
  object IterLbl: TLabel
    Left = 592
    Top = 672
    Width = 52
    Height = 13
    Caption = 'Iterations : '
  end
  object IterNumLbl: TLabel
    Left = 648
    Top = 672
    Width = 51
    Height = 13
    Caption = 'IterNumLbl'
  end
  object oneTourBtn: TButton
    Left = 16
    Top = 224
    Width = 75
    Height = 25
    Caption = 'One Tour'
    Enabled = False
    TabOrder = 0
    OnClick = oneTourBtnClick
  end
  object nTourBtn: TButton
    Left = 96
    Top = 224
    Width = 75
    Height = 25
    Caption = 'N Tours'
    Enabled = False
    TabOrder = 1
    OnClick = nTourBtnClick
  end
  object pChart: TChart
    Left = 0
    Top = 288
    Width = 345
    Height = 185
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Pheromone Chart')
    View3D = False
    TabOrder = 2
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
    Left = 176
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Run'
    Enabled = False
    TabOrder = 3
    OnClick = runBtnClick
  end
  object resetBtn: TButton
    Left = 56
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Reset'
    Enabled = False
    TabOrder = 4
    OnClick = resetBtnClick
  end
  object mapPnl: TPanel
    Left = 368
    Top = 64
    Width = 600
    Height = 600
    BorderWidth = 3
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 5
    object mapImg: TImage
      Left = -8
      Top = 0
      Width = 600
      Height = 600
    end
  end
  object restartBtn: TButton
    Left = 136
    Top = 256
    Width = 75
    Height = 25
    Caption = 'Restart'
    TabOrder = 6
    OnClick = restartBtnClick
  end
  object BPrgsBar: TProgressBar
    Left = 368
    Top = 688
    Width = 600
    Height = 49
    TabOrder = 7
  end
  object SetMemo: TMemo
    Left = 0
    Top = 0
    Width = 297
    Height = 217
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'SetMemo')
    ParentFont = False
    TabOrder = 8
  end
  object AntenGrp: TGroupBox
    Left = 8
    Top = 480
    Width = 345
    Height = 185
    Caption = 'Antennation Factor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    object Label1: TLabel
      Left = 16
      Top = 160
      Width = 123
      Height = 13
      Caption = 'Antennation Value (0 -> 1)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object AntenTypeRadGrp: TRadioGroup
      Left = 8
      Top = 16
      Width = 217
      Height = 137
      Caption = 'Antennation Type'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'None'
        '1 - AF'
        '1 - AF * (path taken/ants met) '
        '1 - AF * (path taken/ants met)^2 '
        '1 - AF * (path taken/ants met) ^0.5'
        '1 - AF * Tanh(path taken/ants met^0.5) '
        '1-  (AF * path^0.5) / (1 +AF * path^0.5))'
        '1 - (AF * path) / (1 + AF * path)')
      ParentFont = False
      TabOrder = 0
      OnClick = AntenTypeRadGrpClick
    end
    object AntenDirRadGrp: TRadioGroup
      Left = 232
      Top = 16
      Width = 105
      Height = 49
      Caption = 'Direction?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemIndex = 0
      Items.Strings = (
        'Bi-directional'
        'Uni-directional')
      ParentFont = False
      TabOrder = 1
      OnClick = AntenDirRadGrpClick
    end
    object AntFEdit: TESBFloatSpinEdit
      Left = 144
      Top = 157
      Max = 1.000000000000000000
      MaxLength = 0
      PageStep = 10.000000000000000000
      Step = 0.100000000000000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 672
    Width = 345
    Height = 73
    Caption = 'Local Search'
    TabOrder = 10
    object lSCheckBox: TCheckBox
      Left = 8
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Use Local Search?'
      TabOrder = 0
      OnClick = lSCheckBoxClick
    end
    object lSEdit: TESBPosSpinEdit
      Left = 10
      Top = 36
      Max = 20
      MaxLength = 0
      Value = 5
      OnChange = lSEditChange
      Enabled = False
      TabOrder = 1
    end
    object lSRadGrp: TRadioGroup
      Left = 152
      Top = 8
      Width = 185
      Height = 57
      Caption = 'Local Search Technique'
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Exponential Distribution'
        'Linear Distribution')
      TabOrder = 2
    end
  end
  object tspOpen: TOpenDialog
    Left = 312
    Top = 80
  end
  object SaveMapDialog: TSavePictureDialog
    Left = 312
    Top = 48
  end
  object MainMenu1: TMainMenu
    Left = 312
    Top = 8
    object PMenu: TMenuItem
      Caption = 'Project...'
      object PMenuLoad: TMenuItem
        Caption = 'Load ACO Map'
        OnClick = PMenuLoadClick
      end
      object PMenuSet: TMenuItem
        Caption = 'Settings'
        OnClick = PMenuSetClick
      end
      object PMenuQuit: TMenuItem
        Caption = 'Quit'
        OnClick = PMenuQuitClick
      end
    end
    object OMenu: TMenuItem
      Caption = 'Options...'
      object OMenuBat: TMenuItem
        Caption = 'Run Batch'
        OnClick = OMenuBatClick
      end
      object OMenuAbout: TMenuItem
        Caption = 'About'
        OnClick = OMenuAboutClick
      end
    end
  end
end
