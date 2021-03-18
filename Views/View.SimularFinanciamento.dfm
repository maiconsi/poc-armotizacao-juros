object FormSimularFinanciamento: TFormSimularFinanciamento
  Left = 0
  Top = 0
  Caption = 'Simular Financiamento'
  ClientHeight = 439
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Visible = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object PanCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 673
    Height = 109
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanCabecalho'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      673
      109)
    object Label3: TLabel
      Left = 361
      Top = 53
      Width = 108
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Meses para pagar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdtValorCapital: TLabeledEdit
      Left = 10
      Top = 73
      Width = 160
      Height = 25
      EditLabel.Width = 72
      EditLabel.Height = 17
      EditLabel.Caption = 'Capital (R$)'
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      TextHint = 'Valor do capital'
      OnExit = EdtValorCapitalExit
      OnKeyPress = EdtValorCapitalKeyPress
    end
    object EdtTaxaJuros: TLabeledEdit
      Left = 184
      Top = 73
      Width = 160
      Height = 25
      Anchors = [akTop]
      EditLabel.Width = 107
      EditLabel.Height = 17
      EditLabel.Caption = 'Taxa de juros (%)'
      EditLabel.Font.Charset = ANSI_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -13
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      TextHint = 'Taxa de juros %'
      OnExit = EdtTaxaJurosExit
      OnKeyPress = EdtTaxaJurosKeyPress
    end
    object EdtMesesPagar: TSpinEdit
      Left = 357
      Top = 73
      Width = 160
      Height = 27
      Anchors = [akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      MaxValue = 60
      MinValue = 1
      ParentFont = False
      TabOrder = 3
      Value = 5
      OnChange = EdtMesesPagarChange
    end
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 673
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      Padding.Top = 10
      ShowCaption = False
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 10
        Width = 673
        Height = 31
        Align = alClient
        Alignment = taCenter
        Caption = 'Simulador de financiamento  - Sistema de Pagamento  '#250'nico'
        Font.Charset = ANSI_CHARSET
        Font.Color = 10485760
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 595
        ExplicitHeight = 30
      end
    end
    object BtnSimular: TButton
      Left = 525
      Top = 72
      Width = 138
      Height = 28
      Action = AcSimularFinanciamento
      Anchors = [akTop, akRight]
      TabOrder = 4
    end
  end
  object PanResultado: TPanel
    Left = 0
    Top = 109
    Width = 673
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanResultado'
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ShowCaption = False
    TabOrder = 1
    object stgSimulacao: TStringGrid
      Left = 10
      Top = 0
      Width = 653
      Height = 320
      Align = alClient
      DefaultRowHeight = 20
      DefaultDrawing = False
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goColMoving, goRowSelect]
      TabOrder = 0
      OnDrawCell = stgSimulacaoDrawCell
      ExplicitTop = -3
      ColWidths = (
        44
        89
        205
        118
        165)
    end
  end
  object ActionList1: TActionList
    Left = 728
    Top = 16
    object AcSimularFinanciamento: TAction
      Caption = 'Simular financiamento'
      OnExecute = AcSimularFinanciamentoExecute
    end
  end
end
