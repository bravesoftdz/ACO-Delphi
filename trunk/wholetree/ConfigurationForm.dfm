object cfgForm: TcfgForm
  Left = 748
  Top = 333
  BorderStyle = bsDialog
  Caption = 'Enter Values'
  ClientHeight = 224
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OkBtn: TBitBtn
    Left = 72
    Top = 176
    Width = 75
    Height = 25
    TabOrder = 0
    Kind = bkOK
  end
  object AntsLblEdit: TLabeledEdit
    Left = 32
    Top = 104
    Width = 121
    Height = 21
    EditLabel.Width = 73
    EditLabel.Height = 13
    EditLabel.Caption = 'Number of Ants'
    TabOrder = 1
    Text = '20'
  end
  object BetaLblEdit: TLabeledEdit
    Left = 176
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Beta Value'
    TabOrder = 2
    Text = '-2'
  end
  object AlphaLblEdit: TLabeledEdit
    Left = 32
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 57
    EditLabel.Height = 13
    EditLabel.Caption = 'Alpha Value'
    TabOrder = 3
    Text = '2'
  end
  object PherInitLblEdit: TLabeledEdit
    Left = 176
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 81
    EditLabel.Height = 13
    EditLabel.Caption = 'Initial Pheromone'
    TabOrder = 4
    Text = '0.1'
  end
  object PherDecayLblEdit: TLabeledEdit
    Left = 32
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 102
    EditLabel.Height = 13
    EditLabel.Caption = 'Decaying Pheromone'
    TabOrder = 5
    Text = '0.1'
  end
  object CancelBtn: TBitBtn
    Left = 176
    Top = 176
    Width = 75
    Height = 25
    TabOrder = 6
    Kind = bkCancel
  end
  object PherAddLblEdit: TLabeledEdit
    Left = 176
    Top = 104
    Width = 121
    Height = 21
    EditLabel.Width = 88
    EditLabel.Height = 13
    EditLabel.Caption = 'Laying Pheromone'
    TabOrder = 7
    Text = '0.5'
  end
  object AntFacEdit: TLabeledEdit
    Left = 104
    Top = 144
    Width = 121
    Height = 21
    EditLabel.Width = 90
    EditLabel.Height = 13
    EditLabel.Caption = 'Antennation Factor'
    TabOrder = 8
    Text = '0.1'
  end
end
