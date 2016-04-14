object SForm: TSForm
  Left = 362
  Top = 85
  Width = 695
  Height = 602
  Caption = 'Settings'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SetPanel: TPanel
    Left = 0
    Top = 256
    Width = 681
    Height = 313
    TabOrder = 0
    object Label4: TLabel
      Left = 56
      Top = 16
      Width = 88
      Height = 13
      Caption = 'Number of Ants'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object SetNumAntsEdit: TEdit
      Left = 152
      Top = 11
      Width = 89
      Height = 21
      TabOrder = 0
    end
  end
  object ParGrpBox: TGroupBox
    Left = 24
    Top = 344
    Width = 625
    Height = 169
    Caption = 'Parameters'
    TabOrder = 1
  end
  object SettingsControl: TPageControl
    Left = 32
    Top = 360
    Width = 609
    Height = 145
    ActivePage = MinMaxTab
    TabOrder = 2
    object ASTab: TTabSheet
      Caption = 'ASTab'
      TabVisible = False
      object Label1: TLabel
        Left = 32
        Top = 24
        Width = 150
        Height = 16
        Caption = 'Heuristic Parameters:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ASAlphaEdit: TLabeledEdit
        Left = 216
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone: Alpha'
        EditLabel.Color = clBtnFace
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '2'
      end
      object ASBetaEdit: TLabeledEdit
        Left = 376
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 120
        EditLabel.Height = 13
        EditLabel.Caption = 'Local Heuristic: Beta'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 1
        Text = '2'
      end
      object ASPherInitEdit: TLabeledEdit
        Left = 56
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 110
        EditLabel.Height = 13
        EditLabel.Caption = 'Initial Pheromone Level'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 2
        Text = '0.1'
      end
      object ASPherDecayEdit: TLabeledEdit
        Left = 216
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 121
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Decay Factor'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 3
        Text = '0.1'
      end
      object ASPherAddEdit: TLabeledEdit
        Left = 376
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 92
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Update'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 4
        Text = '0.5'
      end
    end
    object ACSTab: TTabSheet
      Caption = 'ACSTab'
      ImageIndex = 1
      TabVisible = False
      object Label2: TLabel
        Left = 32
        Top = 24
        Width = 150
        Height = 16
        Caption = 'Heuristic Parameters:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ACSAlphaEdit: TLabeledEdit
        Left = 216
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone: Alpha'
        EditLabel.Color = clBtnFace
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '1'
      end
      object ACSBetaEdit: TLabeledEdit
        Left = 376
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 120
        EditLabel.Height = 13
        EditLabel.Caption = 'Local Heuristic: Beta'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 1
        Text = '2'
      end
      object ACSPherInitEdit: TLabeledEdit
        Left = 32
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 110
        EditLabel.Height = 13
        EditLabel.Caption = 'Initial Pheromone Level'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 2
        Text = '2.2e-5'
      end
      object ACSPherDecayEdit: TLabeledEdit
        Left = 176
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 121
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Decay Factor'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 3
        Text = '0.1'
      end
      object ACSPherAddEdit: TLabeledEdit
        Left = 320
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 92
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Update'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 4
        Text = '0.1'
      end
      object ACSGreedyEdit: TLabeledEdit
        Left = 464
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 85
        EditLabel.Height = 13
        EditLabel.Caption = 'Greedy Probability'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 5
        Text = '0.9'
      end
    end
    object AMTSTab: TTabSheet
      Caption = 'AMTSTab'
      ImageIndex = 2
      TabVisible = False
      object Label3: TLabel
        Left = 32
        Top = 24
        Width = 150
        Height = 16
        Caption = 'Heuristic Parameters:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object AMTSAlphaEdit: TLabeledEdit
        Left = 216
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone: Alpha'
        EditLabel.Color = clBtnFace
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '2'
      end
      object AMTSBetaEdit: TLabeledEdit
        Left = 376
        Top = 32
        Width = 113
        Height = 21
        EditLabel.Width = 120
        EditLabel.Height = 13
        EditLabel.Caption = 'Local Heuristic: Beta'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 1
        Text = '2'
      end
      object AMTSPherInitEdit: TLabeledEdit
        Left = 16
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 110
        EditLabel.Height = 13
        EditLabel.Caption = 'Initial Pheromone Level'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 2
        Text = '0.1'
      end
      object AMTSPherDecayEdit: TLabeledEdit
        Left = 160
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 121
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Decay Factor'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 3
        Text = '0.1'
      end
      object AMTSPherAddEdit: TLabeledEdit
        Left = 312
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 92
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone Update'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 4
        Text = '0.5'
      end
      object AMTSAntLife: TLabeledEdit
        Left = 456
        Top = 88
        Width = 113
        Height = 21
        EditLabel.Width = 102
        EditLabel.Height = 13
        EditLabel.Caption = 'Maximum Age of Ants'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 5
        Text = '6'
      end
    end
    object MinMaxTab: TTabSheet
      Caption = 'MinMaxTab'
      ImageIndex = 3
      TabVisible = False
      object Label5: TLabel
        Left = 16
        Top = 24
        Width = 150
        Height = 16
        Caption = 'Heuristic Parameters:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object MMAlphaEdit: TLabeledEdit
        Left = 176
        Top = 24
        Width = 113
        Height = 21
        EditLabel.Width = 104
        EditLabel.Height = 13
        EditLabel.Caption = 'Pheromone: Alpha'
        EditLabel.Color = clBtnFace
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '1'
      end
      object MMBetaEdit: TLabeledEdit
        Left = 312
        Top = 24
        Width = 113
        Height = 21
        EditLabel.Width = 120
        EditLabel.Height = 13
        EditLabel.Caption = 'Local Heuristic: Beta'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 1
        Text = '2'
      end
      object MMPherDecayEdit: TLabeledEdit
        Left = 112
        Top = 88
        Width = 89
        Height = 21
        EditLabel.Width = 88
        EditLabel.Height = 26
        EditLabel.Caption = 'Pheromone Decay Factor'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        EditLabel.WordWrap = True
        TabOrder = 2
        Text = '0.3'
      end
      object MMPherInitEdit: TLabeledEdit
        Left = 264
        Top = 88
        Width = 89
        Height = 21
        EditLabel.Width = 84
        EditLabel.Height = 26
        EditLabel.Caption = 'Initial Pheromone Level'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        EditLabel.WordWrap = True
        TabOrder = 3
        Text = '3.3'
      end
      object MMPherAddEdit: TLabeledEdit
        Left = 408
        Top = 88
        Width = 89
        Height = 21
        EditLabel.Width = 54
        EditLabel.Height = 26
        EditLabel.Caption = 'Pheromone Update'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clActiveCaption
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        EditLabel.WordWrap = True
        TabOrder = 4
        Text = '1'
      end
      object MMIterGlobalEdit: TLabeledEdit
        Left = 448
        Top = 24
        Width = 113
        Height = 21
        EditLabel.Width = 145
        EditLabel.Height = 13
        EditLabel.Caption = ' Iteration VS Global Best:'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clMaroon
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        TabOrder = 5
        Text = '0.9'
      end
    end
  end
  object CancelBtn: TBitBtn
    Left = 344
    Top = 528
    Width = 75
    Height = 25
    TabOrder = 3
    Kind = bkCancel
  end
  object AcceptBtn: TBitBtn
    Left = 216
    Top = 528
    Width = 75
    Height = 25
    TabOrder = 4
    Kind = bkOK
  end
  object AlgRadGrp: TRadioGroup
    Left = 24
    Top = 296
    Width = 625
    Height = 41
    BiDiMode = bdLeftToRight
    Caption = 'Ant Colony Algorithm to use'
    Columns = 4
    ItemIndex = 0
    Items.Strings = (
      'Ant Systems'
      'Ant Colony Systems'
      'Ant Multi Tour Systems '
      'Max-Min Ant Systems')
    ParentBiDiMode = False
    TabOrder = 5
    OnClick = AlgRadGrpClick
  end
  object SetMemo: TMemo
    Left = 0
    Top = 8
    Width = 681
    Height = 249
    Lines.Strings = (
      '')
    ReadOnly = True
    TabOrder = 6
  end
end
