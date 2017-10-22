object Form1: TForm1
  Left = 292
  Top = 113
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Briefverwaltung'
  ClientHeight = 609
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblKlassen: TLabel
    Left = 280
    Top = 560
    Width = 79
    Height = 13
    Caption = 'Klassensuche'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 528
    Top = 0
    Width = 369
    Height = 601
    Caption = 'Briefvorschau'
    TabOrder = 8
    object lblAnredeEltern: TLabel
      Left = 8
      Top = 16
      Width = 141
      Height = 13
      Caption = 'Sehr geehrte Frau/Herr, '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblText1: TLabel
      Left = 8
      Top = 56
      Width = 228
      Height = 13
      Caption = 'Bei Ihrem Sohn/Ihrer Tochter , Klasse , '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblText2: TLabel
      Left = 8
      Top = 232
      Width = 175
      Height = 13
      Caption = 'Daher erteile ich Ihm/Ihr einen'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblBetreff: TLabel
      Left = 120
      Top = 264
      Width = 64
      Height = 20
      Caption = 'Verweis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSprStd1: TLabel
      Left = 8
      Top = 400
      Width = 212
      Height = 13
      Caption = 'Gerne stehe ich Ihnen diesbezüglich '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSprStd2: TLabel
      Left = 8
      Top = 448
      Width = 224
      Height = 13
      Caption = 'oder nach Vereinbarung zur Verfügung.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblText3: TLabel
      Left = 8
      Top = 488
      Width = 317
      Height = 26
      Caption = 
        'Bitte geben Sie dieses Schreiben umgehend über Ihren Sohn/Ihre T' +
        'ochter wieder an mich zurück.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
    end
    object lblLehrername: TLabel
      Left = 8
      Top = 536
      Width = 103
      Height = 13
      Caption = 'Name des Lehrers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Button1: TButton
    Left = 8
    Top = 576
    Width = 105
    Height = 25
    Hint = 'Schülerdatei importieren'
    Caption = 'Import Schülerdaten'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 497
    Height = 545
    Hint = 'Schülerdaten'
    ColCount = 14
    DefaultColWidth = 90
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = StringGrid1Click
  end
  object btnGenerateTex: TButton
    Left = 120
    Top = 576
    Width = 75
    Height = 25
    Hint = 'Brief erzeugen'
    Caption = 'Brief erstellen'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = btnGenerateTexClick
  end
  object edtLehrername: TEdit
    Left = 536
    Top = 560
    Width = 353
    Height = 21
    Hint = 'Geben Sie hier ihre Anrede an'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object RichEdit1: TRichEdit
    Left = 536
    Top = 72
    Width = 353
    Height = 153
    Hint = 'Hier kommt Ihr freier Brieftext hin'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object cbKlassen: TComboBox
    Left = 280
    Top = 576
    Width = 97
    Height = 21
    Hint = 'Hier können Sie eine Klasse auswählen'
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = cbKlassenClick
  end
  object cbSprechstunden: TComboBox
    Left = 536
    Top = 424
    Width = 225
    Height = 21
    Hint = 'Suchen Sie einen Sprechstundentermin aus'
    Style = csDropDownList
    ItemHeight = 13
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Items.Strings = (
      'montags von 7:45 Uhr bis 8:30 Uhr'
      'montags von 8:30 Uhr bis 9:15 Uhr '
      'montags von 9:30 Uhr bis 10:15 Uhr'
      'montags von 10:15 Uhr bis 11:00 Uhr'
      'montags von 11:15 Uhr bis 12:00 Uhr'
      'montags von 12:00 Uhr bis 12:45 Uhr'
      'dienstags von 7:45 Uhr bis 8:30 Uhr'
      'dienstags von 8:30 Uhr bis 9:15 Uhr '
      'dienstags von 9:30 Uhr bis 10:15 Uhr'
      'dienstags von 10:15 Uhr bis 11:00 Uhr'
      'dienstags von 11:15 Uhr bis 12:00 Uhr'
      'dienstags von 12:00 Uhr bis 12:45 Uhr'
      'mittwochs von 7:45 Uhr bis 8:30 Uhr'
      'mittwochs von 8:30 Uhr bis 9:15 Uhr '
      'mittwochs von 9:30 Uhr bis 10:15 Uhr'
      'mittwochs von 10:15 Uhr bis 11:00 Uhr'
      'mittwochs von 11:15 Uhr bis 12:00 Uhr'
      'mittwochs von 12:00 Uhr bis 12:45 Uhr'
      'donnerstags von 7:45 Uhr bis 8:30 Uhr'
      'donnerstags von 8:30 Uhr bis 9:15 Uhr '
      'donnerstags von 9:30 Uhr bis 10:15 Uhr'
      'donnerstags von 10:15 Uhr bis 11:00 Uhr'
      'donnerstags von 11:15 Uhr bis 12:00 Uhr'
      'donnerstags von 12:00 Uhr bis 12:45 Uhr'
      'freitags von 7:45 Uhr bis 8:30 Uhr'
      'freitags von 8:30 Uhr bis 9:15 Uhr '
      'freitags von 9:30 Uhr bis 10:15 Uhr'
      'freitags von 10:15 Uhr bis 11:00 Uhr'
      'freitags von 11:15 Uhr bis 12:00 Uhr'
      'freitags von 12:00 Uhr bis 12:45 Uhr')
  end
  object RichEdit2: TRichEdit
    Left = 536
    Top = 296
    Width = 353
    Height = 97
    Hint = 'Hier kommt weiterer freier Brieftext hinein'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
  end
  object SaveDialog1: TSaveDialog
    Filter = '.tex|*.tex|Alle Dateien|*.*'
    Title = 'Speichern in Datei:'
    Left = 448
    Top = 600
  end
  object OpenDialog1: TOpenDialog
    Filter = '.txt|*.txt|Alle  Dateien|*.*'
    Title = 'WinSD-Datei öffnen:'
    Left = 416
    Top = 600
  end
  object MainMenu1: TMainMenu
    Left = 416
    Top = 568
    object Datei1: TMenuItem
      Caption = 'Datei'
      object Beenden1: TMenuItem
        Caption = 'Beenden'
        OnClick = Beenden1Click
      end
    end
    object Bearbeiten1: TMenuItem
      Caption = 'Bearbeiten'
      object Kopieren: TMenuItem
        Action = EditCopy1
      end
      object Ausschneiden1: TMenuItem
        Action = EditCut1
      end
      object Einfgen1: TMenuItem
        Action = EditPaste1
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Allesmarkieren1: TMenuItem
        Action = EditSelectAll1
        ShortCut = 16449
      end
      object Rckgngig1: TMenuItem
        Action = EditUndo1
        ShortCut = 16474
      end
    end
    object Optionen1: TMenuItem
      Caption = 'Optionen'
      object Einstellungen1: TMenuItem
        Caption = 'Einstellungen'
        OnClick = Einstellungen1Click
      end
    end
  end
  object ActionList1: TActionList
    Left = 480
    Top = 568
    object EditCopy1: TEditCopy
      Category = 'Bearbeiten'
      Caption = '&Kopieren'
      Hint = 'Kopieren'
      ImageIndex = 1
      ShortCut = 16451
    end
    object EditCut1: TEditCut
      Category = 'Bearbeiten'
      Caption = '&Ausschneiden'
      Hint = 'Ausschneiden'
      ImageIndex = 0
      ShortCut = 16472
    end
    object EditPaste1: TEditPaste
      Category = 'Bearbeiten'
      Caption = '&Einfügen'
      Hint = 'Einfügen'
      ImageIndex = 2
      ShortCut = 16470
    end
    object EditSelectAll1: TEditSelectAll
      Category = 'Bearbeiten'
      Caption = 'Alles &markieren'
    end
    object EditUndo1: TEditUndo
      Category = 'Bearbeiten'
      Caption = '&Rückgängig'
      ImageIndex = 3
      ShortCut = 32776
    end
  end
  object OpenDialog2: TOpenDialog
    Filter = '.tex|*.tex|Alle Dateien|*.*'
    Title = 'Brief-Vorlage laden:'
    Left = 448
    Top = 568
  end
end
