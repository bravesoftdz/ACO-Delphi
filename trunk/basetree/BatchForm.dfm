object BForm: TBForm
  Left = 516
  Top = 164
  BorderStyle = bsDialog
  Caption = 'Batch Values'
  ClientHeight = 589
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object startBox: TGroupBox
    Left = 0
    Top = 0
    Width = 153
    Height = 233
    Caption = 'Start Values'
    TabOrder = 0
    object NumAntsB: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = 'Number of Ants'
      TabOrder = 0
      Text = '10'
    end
    object PherAddB: TLabeledEdit
      Left = 16
      Top = 120
      Width = 121
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Added'
      TabOrder = 2
      Text = '0.1'
    end
    object PherDecayB: TLabeledEdit
      Left = 16
      Top = 160
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Decayed'
      TabOrder = 3
      Text = '0.1'
    end
    object AntFacB: TLabeledEdit
      Left = 16
      Top = 200
      Width = 121
      Height = 21
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Antennation Factor'
      TabOrder = 4
      Text = '0'
    end
    object PherInitB: TLabeledEdit
      Tag = 1
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Initialised'
      TabOrder = 1
      Text = '0.01'
    end
  end
  object stepBox: TGroupBox
    Left = 152
    Top = 0
    Width = 153
    Height = 233
    Caption = 'Step By'
    TabOrder = 1
    object pherAddS: TLabeledEdit
      Left = 16
      Top = 120
      Width = 121
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Added'
      TabOrder = 2
      Text = '0.1'
    end
    object PherDecayS: TLabeledEdit
      Left = 16
      Top = 160
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Decayed'
      TabOrder = 3
      Text = '0.1'
    end
    object NumAntsS: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = 'Number of Ants'
      TabOrder = 0
      Text = '2'
    end
    object AntFacS: TLabeledEdit
      Left = 16
      Top = 200
      Width = 121
      Height = 21
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Antennation Factor'
      TabOrder = 4
      Text = '0.1'
    end
    object PherInitS: TLabeledEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Initialised'
      TabOrder = 1
      Text = '0.01'
    end
  end
  object endBox: TGroupBox
    Left = 304
    Top = 0
    Width = 153
    Height = 233
    Caption = 'End Values'
    TabOrder = 2
    object NumAntsE: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = 'Number of Ants'
      TabOrder = 0
      Text = '30'
    end
    object PherAddE: TLabeledEdit
      Left = 16
      Top = 120
      Width = 121
      Height = 21
      EditLabel.Width = 88
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Added'
      TabOrder = 2
      Text = '1'
    end
    object PherDecayE: TLabeledEdit
      Left = 16
      Top = 160
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Decayed'
      TabOrder = 3
      Text = '0.5'
    end
    object AntFacE: TLabeledEdit
      Left = 16
      Top = 200
      Width = 121
      Height = 21
      EditLabel.Width = 90
      EditLabel.Height = 13
      EditLabel.Caption = 'Antennation Factor'
      TabOrder = 4
      Text = '0.8'
    end
    object PherInitE: TLabeledEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      EditLabel.Width = 100
      EditLabel.Height = 13
      EditLabel.Caption = 'Pheromone Initialised'
      TabOrder = 1
      Text = '0.1'
    end
  end
  object genEdit: TLabeledEdit
    Left = 16
    Top = 256
    Width = 121
    Height = 21
    EditLabel.Width = 102
    EditLabel.Height = 13
    EditLabel.Caption = 'Generation Threshold'
    TabOrder = 3
    Text = '50'
  end
  object iterEdit: TLabeledEdit
    Left = 168
    Top = 256
    Width = 121
    Height = 21
    EditLabel.Width = 95
    EditLabel.Height = 13
    EditLabel.Caption = 'Number of Iterations'
    TabOrder = 4
    Text = '100'
  end
  object OkBtn: TBitBtn
    Left = 128
    Top = 512
    Width = 81
    Height = 25
    TabOrder = 7
    Kind = bkOK
  end
  object txtNameEdit: TLabeledEdit
    Left = 320
    Top = 256
    Width = 121
    Height = 21
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = 'TextFile Name'
    TabOrder = 5
    Text = 'mapText.txt'
  end
  object AntenRadGrp: TRadioGroup
    Left = 16
    Top = 336
    Width = 225
    Height = 145
    Caption = 'Antennation Method'
    ItemIndex = 0
    Items.Strings = (
      'None'
      '1 - AF'
      '1 - AF * (path taken/ants met)'
      '1 - AF * (path taken/ants met) ^ 2'
      '1 - AF * (path taken/ants met) ^ 0.5'
      '1 - AF * Tanh(path taken/ants met^0.5) '
      '1 / (1 + path taken^0.5) (AMTS)')
    TabOrder = 6
    OnClick = AntenRadGrpClick
  end
  object cancelBtn: TBitBtn
    Left = 248
    Top = 512
    Width = 81
    Height = 25
    TabOrder = 8
    Kind = bkCancel
  end
  object ExcludeBox: TGroupBox
    Left = 304
    Top = 336
    Width = 153
    Height = 145
    Caption = 'Exclude which Parameters?'
    TabOrder = 9
    object AntCheck: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Ants'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      OnClick = AntCheckClick
    end
    object PherAddCheck: TCheckBox
      Left = 8
      Top = 64
      Width = 113
      Height = 17
      Caption = 'Pheromone Added'
      TabOrder = 2
      OnClick = PherAddCheckClick
    end
    object PherDecayCheck: TCheckBox
      Left = 8
      Top = 88
      Width = 137
      Height = 17
      Caption = 'Pheromone Decayed'
      TabOrder = 3
      OnClick = PherDecayCheckClick
    end
    object AntFacCheck: TCheckBox
      Left = 8
      Top = 112
      Width = 121
      Height = 17
      Caption = 'Antennation Factor'
      TabOrder = 4
      OnClick = AntFacCheckClick
    end
    object PherInitCheck: TCheckBox
      Left = 8
      Top = 40
      Width = 137
      Height = 17
      Caption = 'Pheromone Initialised'
      TabOrder = 1
      OnClick = PherInitCheckClick
    end
  end
  object AlphaEdit: TLabeledEdit
    Left = 16
    Top = 296
    Width = 121
    Height = 21
    EditLabel.Width = 123
    EditLabel.Height = 13
    EditLabel.Caption = 'Alpha (Pheromone Power)'
    TabOrder = 10
    Text = '2'
  end
  object BetaEdit: TLabeledEdit
    Left = 168
    Top = 296
    Width = 121
    Height = 21
    EditLabel.Width = 106
    EditLabel.Height = 13
    EditLabel.Caption = 'Beta (Distance Power)'
    TabOrder = 11
    Text = '-2'
  end
end
