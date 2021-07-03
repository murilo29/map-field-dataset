object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  ClientHeight = 560
  ClientWidth = 902
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object flwpnlEmployee: TFlowPanel
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 896
    Height = 66
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 0
      Top = 0
      Width = 145
      Height = 21
      DataField = 'Remuneatrion'
      DataSource = dtmdlDemo.dsEmployee
      TabOrder = 0
    end
  end
  object dbgrdEmployee: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 135
    Width = 896
    Height = 158
    Align = alTop
    DataSource = dtmdlDemo.dsEmployee
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 896
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object btnGetField: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 75
      Height = 48
      Align = alLeft
      Caption = 'Get Field'
      TabOrder = 0
      OnClick = btnGetFieldClick
    end
    object btnSetValueField: TButton
      AlignWithMargins = True
      Left = 84
      Top = 3
      Width = 101
      Height = 48
      Align = alLeft
      Caption = 'Set Value Field'
      TabOrder = 1
      OnClick = btnSetValueFieldClick
    end
    object btnGetValueField: TButton
      AlignWithMargins = True
      Left = 191
      Top = 3
      Width = 101
      Height = 48
      Align = alLeft
      Caption = 'Get Value Field'
      TabOrder = 2
      OnClick = btnGetValueFieldClick
    end
    object btnGetDbEdit: TButton
      AlignWithMargins = True
      Left = 298
      Top = 3
      Width = 101
      Height = 48
      Align = alLeft
      Caption = 'Get DBEdit'
      TabOrder = 3
      OnClick = btnGetDbEditClick
    end
    object btnListDBEdit: TButton
      AlignWithMargins = True
      Left = 405
      Top = 3
      Width = 101
      Height = 48
      Align = alLeft
      Caption = 'List DBEdit'
      TabOrder = 4
      OnClick = btnListDBEditClick
    end
  end
  object dbgrdTelephone: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 390
    Width = 896
    Height = 167
    Align = alClient
    DataSource = dtmdlDemo.dsTelephone
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object flwpnlTelephone: TFlowPanel
    AlignWithMargins = True
    Left = 3
    Top = 299
    Width = 896
    Height = 54
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
  end
  object dbnvgrTelephone: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 359
    Width = 896
    Height = 25
    DataSource = dtmdlDemo.dsTelephone
    Align = alTop
    TabOrder = 5
  end
  object mpdtstfldEmployee: TMapDataSetField
    CharCase = ecUpperCase
    MultipleSelection.Strings = (
      'Department')
    Conteiner = flwpnlEmployee
    LimitEditCharacters = 100
    DataSource = dtmdlDemo.dsEmployee
    OnCreateDbComboBox = mpdtstfldEmployeeCreateDbComboBox
    Left = 520
    Top = 64
  end
  object mpdtstfldTelephone: TMapDataSetField
    CharCase = ecUpperCase
    Conteiner = flwpnlTelephone
    LimitEditCharacters = 120
    DataSource = dtmdlDemo.dsTelephone
    OnCreateDbEdit = mpdtstfldTelephoneCreateDbEdit
    Left = 624
    Top = 64
  end
end
