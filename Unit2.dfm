object Form2: TForm2
  Left = 363
  Top = 154
  BorderStyle = bsDialog
  Caption = 'Form2'
  ClientHeight = 315
  ClientWidth = 265
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
  object Label3: TLabel
    Left = 16
    Top = 8
    Width = 86
    Height = 13
    Caption = 'Pfad zu Texify:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 16
    Top = 56
    Width = 129
    Height = 13
    Caption = 'Pfad zur WinSD Datei:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 40
    Top = 96
    Width = 137
    Height = 13
    Caption = 'Beim Start automatisch laden'
  end
  object Label1: TLabel
    Left = 16
    Top = 128
    Width = 153
    Height = 13
    Caption = 'Pfad zur Tex-Briefvorlage: '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 256
    Width = 237
    Height = 13
    Caption = 'Änderungen erst nach Programmneustart wirksam!'
  end
  object Label6: TLabel
    Left = 40
    Top = 168
    Width = 137
    Height = 13
    Caption = 'Beim Start automatisch laden'
  end
  object Label7: TLabel
    Left = 16
    Top = 200
    Width = 229
    Height = 13
    Caption = 'Speicherpfad für Tex- und PDF-Dateien:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtTexify: TEdit
    Left = 16
    Top = 24
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object edtWinSD: TEdit
    Left = 16
    Top = 72
    Width = 233
    Height = 21
    TabOrder = 1
  end
  object cbWinSD: TCheckBox
    Left = 16
    Top = 96
    Width = 17
    Height = 17
    TabStop = False
    TabOrder = 5
  end
  object Button1: TButton
    Left = 176
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Schließen'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 96
    Top = 280
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 4
    OnClick = Button2Click
  end
  object edtVorlage: TEdit
    Left = 16
    Top = 144
    Width = 233
    Height = 21
    TabOrder = 2
  end
  object cbVorlage: TCheckBox
    Left = 16
    Top = 168
    Width = 17
    Height = 17
    TabOrder = 6
  end
  object edtTso: TEdit
    Left = 16
    Top = 216
    Width = 233
    Height = 21
    TabOrder = 7
  end
end
