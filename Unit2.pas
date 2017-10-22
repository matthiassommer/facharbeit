unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, IniFiles;

type
  TForm2 = class(TForm)
    edtTexify: TEdit;
    edtWinSD: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbWinSD: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edtVorlage: TEdit;
    Label2: TLabel;
    cbVorlage: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    edtTso: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;
  pfad, startordner, winsd, texify, vorlage, tso: string;
  val, wal: boolean;
implementation

{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
var Ini: TIniFile;
begin
     pfad := ExtractFilePath(ParamStr(0)) + 'config.ini';
     Caption := 'Optionen: ' + pfad; 
     try
     Ini := TIniFile.Create(pfad);
     edtTexify.Text := Ini.ReadString('Texify','texify', texify);
     edtWinSD.Text := Ini.ReadString('Import WinSD','winsd', winsd);
     cbWinSD.Checked := Ini.ReadBool('WinSD auto laden','wal', wal);
     edtVorlage.Text := Ini.ReadString('Tex-Briefvorlage','vorlage', vorlage);
     cbVorlage.Checked := Ini.ReadBool('Vorlage auto laden','val', val);
     edtTso.Text := Ini.ReadString('Tex Speicherort','tso', tso);
     finally
     Ini.Free;
     end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var Ini: TIniFile;
begin
     texify := edtTexify.Text;
     winsd := edtWinSD.Text;
     wal := cbWinSD.Checked;
     vorlage := edtVorlage.Text;
     val := cbVorlage.Checked;
     tso := edtTso.Text;

     pfad := ExtractFilePath(ParamStr(0)) + 'config.ini';
     try
     Ini := TIniFile.Create(pfad);
     Ini.WriteString('Texify','texify', texify);
     Ini.WriteString('Import WinSD','winsd', winsd);
     Ini.WriteBool('WinSD auto laden','wal', wal);
     Ini.WriteString('Tex-Briefvorlage','vorlage', vorlage);
     Ini.WriteBool('Vorlage auto laden','val', val);
     Ini.WriteString('Tex Speicherort','tso', tso);
     finally
     Ini.Free;
     end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin Close; end;

end.
