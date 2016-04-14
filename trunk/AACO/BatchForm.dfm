object BForm: TBForm
  Left = 586
  Top = 96
  BorderStyle = bsDialog
  Caption = 'Batch Values'
  ClientHeight = 786
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
    ActivePage = ASTab
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
        object Label3: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ASpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 1
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
          TabOrder = 2
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
          TabOrder = 3
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
          TabOrder = 0
          Text = '0.1'
        end
        object ASnaB: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          TabOrder = 4
        end
      end
      object ASStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Step By'
        TabOrder = 1
        object Label4: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ASpaS: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
          Text = '0.1'
        end
        object ASafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
          Text = '0.1'
        end
        object ASnaS: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 2
          Enabled = False
          TabOrder = 4
        end
      end
      object ASEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 233
        Caption = 'End Values'
        TabOrder = 2
        object Label5: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ASpaE: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
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
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
          Text = '1'
        end
        object ASnaE: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 25
          Enabled = False
          TabOrder = 4
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
        object Label6: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ACSpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 1
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
          TabOrder = 2
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
          TabOrder = 3
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
          TabOrder = 0
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
          Enabled = False
          TabOrder = 4
          Text = '0.9'
        end
        object ACSnaB: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          TabOrder = 5
        end
      end
      object ACSStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 273
        Caption = 'Step By'
        TabOrder = 1
        object Label7: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ACSpaS: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
          Text = '0.1'
        end
        object ACSafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
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
          Enabled = False
          TabOrder = 4
          Text = '0.01'
        end
        object ACSnaS: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 5
        end
      end
      object ACSEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 273
        Caption = 'End Values'
        TabOrder = 2
        object Label8: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object ACSpaE: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
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
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
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
          Enabled = False
          TabOrder = 4
          Text = '0.99'
        end
        object ACSnaE: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 5
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
        object Label9: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object AMTSpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 1
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
          TabOrder = 2
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
          TabOrder = 3
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
          TabOrder = 0
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
          TabOrder = 4
          Text = '6'
        end
        object AMTSnaB: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          TabOrder = 5
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
        object Label10: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object AMTSpaS: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
          Text = '0.1'
        end
        object AMTSafS: TLabeledEdit
          Left = 16
          Top = 200
          Width = 121
          Height = 21
          EditLabel.Width = 90
          EditLabel.Height = 13
          EditLabel.Caption = 'Antennation Factor'
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
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
          Enabled = False
          TabOrder = 4
          Text = '1'
        end
        object AMTSnaS: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 5
        end
      end
      object AMTSEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 273
        Caption = 'End Values'
        TabOrder = 2
        object Label11: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object AMTSpaE: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
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
          TabOrder = 3
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
          Enabled = False
          TabOrder = 0
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
          Enabled = False
          TabOrder = 4
          Text = '10'
        end
        object AMTSnaE: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 5
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
        object Label12: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object MMpaB: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          TabOrder = 1
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
          TabOrder = 2
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
          TabOrder = 3
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
          TabOrder = 0
          Text = '3.3'
        end
        object MMnaB: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          TabOrder = 4
        end
      end
      object MMStepBox: TGroupBox
        Left = 168
        Top = 0
        Width = 153
        Height = 233
        Caption = 'Step By'
        TabOrder = 1
        object Label13: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object MMpaS: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
          Text = '0.1'
        end
        object MMpiS: TLabeledEdit
          Left = 16
          Top = 80
          Width = 121
          Height = 21
          EditLabel.Width = 100
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Initialised'
          Enabled = False
          TabOrder = 0
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
          TabOrder = 3
          Text = '0.05'
        end
        object MMnaS: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 4
        end
      end
      object MMEndBox: TGroupBox
        Left = 320
        Top = 0
        Width = 153
        Height = 233
        Caption = 'End Values'
        TabOrder = 2
        object Label14: TLabel
          Left = 17
          Top = 20
          Width = 73
          Height = 13
          Caption = 'Number of Ants'
        end
        object MMpaE: TLabeledEdit
          Left = 16
          Top = 120
          Width = 121
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Pheromone Added'
          Enabled = False
          TabOrder = 1
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
          Enabled = False
          TabOrder = 2
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
          Enabled = False
          TabOrder = 0
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
          TabOrder = 3
          Text = '0.96'
        end
        object MMnaE: TESBPosSpinEdit
          Left = 16
          Top = 36
          Width = 129
          Max = 200
          MaxLength = 0
          Step = 2
          Value = 10
          Enabled = False
          TabOrder = 4
        end
      end
    end
  end
  object OkBtn: TBitBtn
    Left = 128
    Top = 748
    Width = 81
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object cancelBtn: TBitBtn
    Left = 300
    Top = 748
    Width = 81
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
  object ExcludeBox: TGroupBox
    Left = 244
    Top = 352
    Width = 145
    Height = 185
    Caption = 'Exclude which Parameters?'
    TabOrder = 3
    object AntCheck: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Ants'
      Checked = True
      Ctl3D = True
      ParentCtl3D = False
      State = cbChecked
      TabOrder = 0
      OnClick = AntCheckClick
    end
    object PherAddCheck: TCheckBox
      Left = 8
      Top = 64
      Width = 113
      Height = 17
      Caption = 'Pheromone Added'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = PherAddCheckClick
    end
    object PherDecayCheck: TCheckBox
      Left = 8
      Top = 88
      Width = 121
      Height = 17
      Caption = 'Pheromone Decayed'
      Checked = True
      State = cbChecked
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
      Width = 129
      Height = 17
      Caption = 'Pheromone Initialised'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = PherInitCheckClick
    end
    object GreedCheck: TCheckBox
      Left = 8
      Top = 136
      Width = 121
      Height = 17
      Caption = 'Greedy Probability'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = GreedCheckClick
    end
    object AgeCheck: TCheckBox
      Left = 8
      Top = 160
      Width = 97
      Height = 17
      Caption = 'Maximum Age'
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = AgeCheckClick
    end
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
    TabOrder = 4
    OnClick = AlgRadGrpClick
  end
  object AntenDirRadGrp: TRadioGroup
    Left = 392
    Top = 352
    Width = 116
    Height = 65
    Caption = 'Antennation Direction'
    ItemIndex = 0
    Items.Strings = (
      'Bidirectional'
      'Unidirectional'
      'Both')
    TabOrder = 5
  end
  object AntenCheckGrp: TGroupBox
    Left = 16
    Top = 352
    Width = 225
    Height = 185
    Caption = 'Antennation Type'
    TabOrder = 6
    object AF1: TCheckBox
      Left = 16
      Top = 16
      Width = 97
      Height = 17
      Caption = '1 - AF'
      TabOrder = 0
      OnClick = AF1Click
    end
    object AF5: TCheckBox
      Left = 16
      Top = 112
      Width = 206
      Height = 17
      Caption = '1 - AF * Tanh(path taken/ants met^0.5)'
      TabOrder = 1
      OnClick = AF5Click
    end
    object AF2: TCheckBox
      Left = 16
      Top = 40
      Width = 169
      Height = 17
      Caption = '1 - AF * (path taken/ants met)'
      TabOrder = 2
      OnClick = AF2Click
    end
    object AF4: TCheckBox
      Left = 16
      Top = 88
      Width = 185
      Height = 17
      Caption = '1 - AF * (path taken/ants met) ^ 0.5'
      TabOrder = 3
      OnClick = AF4Click
    end
    object AF3: TCheckBox
      Left = 16
      Top = 64
      Width = 185
      Height = 17
      Caption = '1 - AF * (path taken/ants met) ^ 2'
      TabOrder = 4
      OnClick = AF3Click
    end
    object AF6: TCheckBox
      Left = 16
      Top = 136
      Width = 206
      Height = 17
      Caption = '1 - (AF * path^0.5) / (1 + AF * path^0.5)'
      TabOrder = 5
      OnClick = AF6Click
    end
    object AF7: TCheckBox
      Left = 16
      Top = 160
      Width = 169
      Height = 17
      Caption = '1 - (AF * path) / (1 + AF * path)'
      TabOrder = 6
      OnClick = AF7Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 392
    Top = 424
    Width = 113
    Height = 57
    Caption = 'Random Seed'
    TabOrder = 7
    object randSeedEdit: TESBPosSpinEdit
      Left = 8
      Top = 24
      Width = 97
      MaxLength = 0
      Value = 100
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 16
    Top = 544
    Width = 473
    Height = 113
    Caption = 'Other ACO parameters'
    TabOrder = 8
    object Label1: TLabel
      Left = 8
      Top = 60
      Width = 133
      Height = 13
      Caption = 'Generations with no change'
    end
    object Label2: TLabel
      Left = 152
      Top = 60
      Width = 95
      Height = 13
      Caption = 'Number of Iterations'
    end
    object txtNameEdit: TLabeledEdit
      Left = 296
      Top = 76
      Width = 121
      Height = 21
      EditLabel.Width = 68
      EditLabel.Height = 13
      EditLabel.Caption = 'TextFile Name'
      TabOrder = 0
      Text = 'mapText.txt'
    end
    object AlphaEdit: TLabeledEdit
      Left = 8
      Top = 36
      Width = 121
      Height = 21
      EditLabel.Width = 123
      EditLabel.Height = 13
      EditLabel.Caption = 'Alpha (Pheromone Power)'
      TabOrder = 1
      Text = '2'
    end
    object BetaEdit: TLabeledEdit
      Left = 152
      Top = 36
      Width = 121
      Height = 21
      EditLabel.Width = 106
      EditLabel.Height = 13
      EditLabel.Caption = 'Beta (Distance Power)'
      TabOrder = 2
      Text = '2'
    end
    object iterGlobalEdit: TLabeledEdit
      Left = 296
      Top = 36
      Width = 121
      Height = 21
      EditLabel.Width = 112
      EditLabel.Height = 13
      EditLabel.Caption = 'Iteration VS Global Best'
      TabOrder = 3
      Text = '0.9'
    end
    object genEdit: TESBPosSpinEdit
      Left = 8
      Top = 76
      Width = 121
      Max = 1000
      MaxLength = 0
      Step = 50
      Value = 50
      TabOrder = 4
    end
    object iterEdit: TESBPosSpinEdit
      Left = 152
      Top = 76
      Width = 121
      Max = 1000
      MaxLength = 0
      Step = 200
      Value = 1000
      TabOrder = 5
    end
  end
  object GroupBox4: TGroupBox
    Left = 16
    Top = 664
    Width = 345
    Height = 73
    Caption = 'Local Search'
    TabOrder = 9
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
end
