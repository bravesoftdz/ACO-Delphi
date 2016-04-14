object BForm: TBForm
  Left = 586
  Top = 96
  BorderStyle = bsDialog
  Caption = 'Batch Values'
  ClientHeight = 785
  ClientWidth = 515
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
  object BatchControl: TPageControl
    Left = 4
    Top = 56
    Width = 505
    Height = 289
    ActivePage = ACSTab
    TabOrder = 0
    object ASTab: TTabSheet
      Caption = 'ASTab'
      TabVisible = False
      object ASStartBox: TGroupBox
        Left = 16
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Start Values'
        TabOrder = 0
        object ASnaB: TLabeledEdit
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
        object ASpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 2
          Text = '0.5'
        end
        object ASpdB: TLabeledEdit
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
        object ASafB: TLabeledEdit
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
        object ASpiB: TLabeledEdit
          Tag = 1
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
      object ASStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Step By'
        TabOrder = 1
        object ASpaS: TLabeledEdit
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
        object ASpdS: TLabeledEdit
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
        object ASnaS: TLabeledEdit
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
        object ASafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.05'
        end
        object ASpiS: TLabeledEdit
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
      object ASEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 233
        Caption = 'End Values'
        TabOrder = 2
        object ASnaE: TLabeledEdit
          Left = 16
          Top = 40
          Width = 121
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'Number of Ants'
          TabOrder = 0
          Text = '26'
        end
        object ASpaE: TLabeledEdit
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
        object ASpdE: TLabeledEdit
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
        object ASafE: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.96'
        end
        object ASpiE: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '1'
        end
      end
    end
    object ACSTab: TTabSheet
      Caption = 'ACSTab'
      ImageIndex = 1
      TabVisible = False
      object ACSStartbox: TGroupBox
        Left = 16
        Top = 0
        Width = 153
        Height = 273
        Caption = 'Start Values'
        TabOrder = 0
        object ACSnaB: TLabeledEdit
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
        object ACSpaB: TLabeledEdit
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
        object ACSpdB: TLabeledEdit
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
        object ACSafB: TLabeledEdit
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
        object ACSpiB: TLabeledEdit
          Tag = 1
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '2.2e-5'
        end
        object ACSgpB: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Greedy Probability'
          TabOrder = 5
          Text = '0.9'
        end
      end
      object ACSStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 273
        Caption = 'Step By'
        TabOrder = 1
        object ACSpaS: TLabeledEdit
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
        object ACSpdS: TLabeledEdit
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
        object ACSnaS: TLabeledEdit
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
        object ACSafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.05'
        end
        object ACSpiS: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '0.2e-5'
        end
        object ACSgpS: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Gready Probability'
          TabOrder = 5
          Text = '0.01'
        end
      end
      object ACSEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 273
        Caption = 'End Values'
        TabOrder = 2
        object ACSnaE: TLabeledEdit
          Left = 16
          Top = 40
          Width = 121
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'Number of Ants'
          TabOrder = 0
          Text = '26'
        end
        object ACSpaE: TLabeledEdit
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
        object ACSpdE: TLabeledEdit
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
        object ACSafE: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.96'
        end
        object ACSpiE: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '3e-5'
        end
        object ACSgpE: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Greedy Probability'
          TabOrder = 5
          Text = '0.99'
        end
      end
    end
    object AMTSTab: TTabSheet
      Caption = 'AMTSTab'
      ImageIndex = 2
      TabVisible = False
      object AMTSStartBox: TGroupBox
        Left = 16
        Top = 0
        Width = 153
        Height = 273
        Caption = 'Start Values'
        TabOrder = 0
        object AMTSnaB: TLabeledEdit
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
        object AMTSpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 2
          Text = '0.5'
        end
        object AMTSpdB: TLabeledEdit
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
        object AMTSafB: TLabeledEdit
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
        object AMTSpiB: TLabeledEdit
          Tag = 1
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
        object AMTSmaB: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Maximum Ant Age'
          TabOrder = 5
          Text = '6'
        end
      end
      object AMTSStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 273
        Caption = 'Step By'
        ParentBackground = False
        TabOrder = 1
        object AMTSpaS: TLabeledEdit
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
        object AMTSpdS: TLabeledEdit
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
        object AMTSnaS: TLabeledEdit
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
        object AMTSafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.05'
        end
        object AMTSpiS: TLabeledEdit
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
        object AMTSmaS: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Maximum Ant Age'
          TabOrder = 5
          Text = '1'
        end
      end
      object AMTSEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 273
        Caption = 'End Values'
        TabOrder = 2
        object AMTSnaE: TLabeledEdit
          Left = 16
          Top = 40
          Width = 121
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'Number of Ants'
          TabOrder = 0
          Text = '26'
        end
        object AMTSpaE: TLabeledEdit
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
        object AMTSpdE: TLabeledEdit
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
        object AMTSafE: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.96'
        end
        object AMTSpiE: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '1'
        end
        object AMTSmaE: TLabeledEdit
          Left = 16
          Top = 240
          Width = 121
          Height = 21
          EditLabel.Width = 85
          EditLabel.Height = 13
          EditLabel.Caption = 'Maximum Ant Age'
          TabOrder = 5
          Text = '10'
        end
      end
    end
    object MMTab: TTabSheet
      Caption = 'MMTab'
      ImageIndex = 3
      TabVisible = False
      object MMStartBox: TGroupBox
        Left = 16
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Start Values'
        TabOrder = 0
        object MMnaB: TLabeledEdit
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
        object MMpaB: TLabeledEdit
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
        object MMpdB: TLabeledEdit
          Left = 16
          Top = 160
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Decayed'
          TabOrder = 3
          Text = '0.3'
        end
        object MMafB: TLabeledEdit
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
        object MMpiB: TLabeledEdit
          Tag = 1
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '3.3'
        end
      end
      object MMStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Step By'
        TabOrder = 1
        object MMpaS: TLabeledEdit
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
        object MMpdS: TLabeledEdit
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
        object MMnaS: TLabeledEdit
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
        object MMpiS: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '0.5'
        end
        object MMafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.05'
        end
      end
      object MMEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 233
        Caption = 'End Values'
        TabOrder = 2
        object MMnaE: TLabeledEdit
          Left = 16
          Top = 40
          Width = 121
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'Number of Ants'
          TabOrder = 0
          Text = '26'
        end
        object MMpaE: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 2
          Text = '2'
        end
        object MMpdE: TLabeledEdit
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
        object MMpiE: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          TabOrder = 1
          Text = '5'
        end
        object MMafE: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 4
          Text = '0.96'
        end
      end
    end
  end
  object genEdit: TLabeledEdit
    Left = 48
    Top = 408
    Width = 121
    Height = 21
    EditLabel.Width = 102
    EditLabel.Height = 13
    EditLabel.Caption = 'Generation Threshold'
    TabOrder = 1
    Text = '50'
  end
  object iterEdit: TLabeledEdit
    Left = 200
    Top = 408
    Width = 121
    Height = 21
    EditLabel.Width = 95
    EditLabel.Height = 13
    EditLabel.Caption = 'Number of Iterations'
    TabOrder = 2
    Text = '1000'
  end
  object OkBtn: TBitBtn
    Left = 312
    Top = 612
    Width = 81
    Height = 25
    TabOrder = 3
    Kind = bkOK
  end
  object txtNameEdit: TLabeledEdit
    Left = 200
    Top = 456
    Width = 121
    Height = 21
    EditLabel.Width = 68
    EditLabel.Height = 13
    EditLabel.Caption = 'TextFile Name'
    TabOrder = 4
    Text = 'mapText.txt'
  end
  object AntenTypeRadGrp: TRadioGroup
    Left = 48
    Top = 481
    Width = 217
    Height = 168
    Caption = 'Antennation Method'
    ItemIndex = 0
    Items.Strings = (
      'None'
      '1 - AF'
      '1 - AF * (path taken/ants met)'
      '1 - AF * (path taken/ants met) ^ 2'
      '1 - AF * (path taken/ants met) ^ 0.5'
      '1 - AF * Tanh(path taken/ants met^0.5) '
      '1 - (AF * path^0.5) / (1 + AF * path^0.5)'
      '1 - (AF * path) / (1 + AF * path)'
      'ALL')
    TabOrder = 5
    OnClick = AntenTypeRadGrpClick
  end
  object cancelBtn: TBitBtn
    Left = 412
    Top = 612
    Width = 81
    Height = 25
    TabOrder = 6
    Kind = bkCancel
  end
  object ExcludeBox: TGroupBox
    Left = 356
    Top = 356
    Width = 153
    Height = 181
    Caption = 'Exclude which Parameters?'
    TabOrder = 7
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
    object GreedCheck: TCheckBox
      Left = 8
      Top = 136
      Width = 121
      Height = 17
      Caption = 'Greedy Probability'
      TabOrder = 5
      OnClick = GreedCheckClick
    end
    object AgeCheck: TCheckBox
      Left = 8
      Top = 160
      Width = 97
      Height = 17
      Caption = 'Maximum Age'
      TabOrder = 6
      OnClick = AgeCheckClick
    end
  end
  object AlphaEdit: TLabeledEdit
    Left = 48
    Top = 360
    Width = 121
    Height = 21
    EditLabel.Width = 123
    EditLabel.Height = 13
    EditLabel.Caption = 'Alpha (Pheromone Power)'
    TabOrder = 8
    Text = '2'
  end
  object BetaEdit: TLabeledEdit
    Left = 200
    Top = 360
    Width = 121
    Height = 21
    EditLabel.Width = 106
    EditLabel.Height = 13
    EditLabel.Caption = 'Beta (Distance Power)'
    TabOrder = 9
    Text = '2'
  end
  object AlgRadGrp: TRadioGroup
    Left = 4
    Top = 16
    Width = 505
    Height = 41
    Caption = 'Ant Colony Algorithm to use'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Ant Systems'
      'Ant Colony Systems'
      'Ant Multi Tour Systems'
      'Max-Min Ant Systems')
    TabOrder = 10
    OnClick = AlgRadGrpClick
  end
  object iterGlobalEdit: TLabeledEdit
    Left = 48
    Top = 456
    Width = 121
    Height = 21
    EditLabel.Width = 112
    EditLabel.Height = 13
    EditLabel.Caption = 'Iteration VS Global Best'
    TabOrder = 11
    Text = '0.9'
  end
  object AntenDirRadGrp: TRadioGroup
    Left = 48
    Top = 656
    Width = 129
    Height = 65
    Caption = 'Antennation Direction'
    ItemIndex = 0
    Items.Strings = (
      'Bidirectional'
      'Unidirectional'
      'Both')
    TabOrder = 12
  end
end
