unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, IniFiles, Menus, StdActns, ActnList;

type
  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    btnGenerateTex: TButton;
    edtLehrername: TEdit;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    MainMenu1: TMainMenu;
    Datei1: TMenuItem;
    Bearbeiten1: TMenuItem;
    Einstellungen1: TMenuItem;
    ActionList1: TActionList;
    EditCopy1: TEditCopy;
    EditCut1: TEditCut;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    Optionen1: TMenuItem;
    Kopieren: TMenuItem;
    Ausschneiden1: TMenuItem;
    Einfgen1: TMenuItem;
    Allesmarkieren1: TMenuItem;
    N1: TMenuItem;
    Rckgngig1: TMenuItem;
    Beenden1: TMenuItem;
    OpenDialog2: TOpenDialog;
    RichEdit1: TRichEdit;
    cbKlassen: TComboBox;
    lblKlassen: TLabel;
    cbSprechstunden: TComboBox;
    RichEdit2: TRichEdit;
    GroupBox1: TGroupBox;
    lblAnredeEltern: TLabel;
    lblText1: TLabel;
    lblText2: TLabel;
    lblBetreff: TLabel;
    lblSprStd1: TLabel;
    lblSprStd2: TLabel;
    lblText3: TLabel;
    lblLehrername: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure btnGenerateTexClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Einstellungen1Click(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure cbKlassenClick(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    procedure winsdeinlesen;
    function SuchInGrid(StringGrid1: TStringGrid;S: String;
             SelZeile: Boolean): String;
    procedure Spaltenbreite;
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Startordner, texify, winsd, vorlage, Sprechstunden, tso:string;
  Col, Row:integer;
  val, wal: boolean;
  ATStringlist:TStringlist;

implementation

uses Unit2;

{$R *.DFM}

TYPE Tschueler = record     //Feld für Schülerdaten erstellen
  Klasse : string[3];
  Name : string[40];
  Vorname : string[30];
  Strasse : string[40];
  Postleitzahl: string[5];
  Ort: string[30];
  Nachname2: string[40];
  Vorname2: string[30];
  Status1: string[5];
  Nachname3: string[40];
  Vorname3: string[30];
  Geschlecht: string[15];
  Status2: string[20];
end;

tab = array of Tschueler;
var t : tab;

procedure TForm1.FormCreate(Sender: TObject);  //Programmstart
var pfad, zeile : string;
    Ini: TIniFile;
    dat: TextFile;
begin
pfad := ExtractFilePath(ParamStr(0));      //Programmpfad einlesen
Caption := 'Briefverwaltung: ' + pfad;
btnGenerateTex.Enabled := False;
 //StringGrid generieren
StringGrid1.Cells[1,0]:='Klasse';
StringGrid1.Cells[2,0]:='Name Kind';
StringGrid1.Cells[3,0]:='Vorname Kind';
StringGrid1.Cells[4,0]:='Straße';
StringGrid1.Cells[5,0]:='PLZ';
StringGrid1.Cells[6,0]:='Ort';
StringGrid1.Cells[7,0]:='Geschlecht Kind';
StringGrid1.Cells[8,0]:='Name Elt.teil 1';
StringGrid1.Cells[9,0]:='Vorname Elt.teil 1';
StringGrid1.Cells[10,0]:='Status';
StringGrid1.Cells[11,0]:='Name Elt.teil 2';
StringGrid1.Cells[12,0]:='Vorname Elt.teil 2';
StringGrid1.Cells[13,0]:='Erz.Ber.';
  try                                                 //config.ini auslesen
   Ini := TIniFile.Create(pfad + 'config.ini');
   texify := Ini.ReadString('Texify','texify', texify);
   winsd := Ini.ReadString('Import WinSD','winsd', winsd);
   wal := Ini.ReadBool('WinSD auto laden','wal', wal);
   vorlage := Ini.ReadString('Tex-Briefvorlage','vorlage', vorlage);
   val := Ini.ReadBool('Vorlage auto laden','val', val);
   tso := Ini.ReadString('Tex Speicherort','tso', tso);
  finally
   Ini.Free;
  end;
  //ggf. Schülerdatei einlesen
  if wal then begin OpenDialog1.FileName := winsd; winsdeinlesen end;
  try                                          //Klassenliste einlesen
  AssignFile(dat, pfad + 'klassenliste.txt');
  Reset(dat);
  Repeat
  Readln(dat,zeile);
  cbKlassen.Items.Add(zeile);
  Until EOF(dat);
  CloseFile(dat);
  except
  Application.MessageBox('Klassenliste konnte nicht geöffnet werden!',
                                       'Fehler',MB_OKCANCEL);
  Exit;
  end;
end;

 //Manuelles Einlesen der Schülerdatei
procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := winsd;
  if OpenDialog1.Execute then winsdeinlesen;
end;

 //Funktion für Einlesen der Schülerdatei
procedure TForm1.winsdeinlesen;
var dat: TextFile;
    i,j,position: integer;
    zeile: string;
begin
Form1.Caption := 'Briefverwaltung: ' + OpenDialog1.FileName;
try
AssignFile(dat, OpenDialog1.FileName);
Reset(dat);
 i:=0;
Repeat  //Zeilenweises Einlesen
  SetLength(t,i+1);
  Readln(dat,zeile);
  With t[i] do
    begin
      //Tabs entfernen
      zeile := StringReplace(zeile, #09, ' ', [rfReplaceAll]);

      position:=Pos('"', zeile); //Bis nächstes Anführungszeichen gehen
      Delete(zeile,1,position); //Samt Anführungszeichen abschneiden
      position:=Pos('"', zeile);
      Klasse := copy(zeile,1,position-1); //Teil in Variable schreiben
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Name := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Vorname := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Strasse := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Postleitzahl := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Ort := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Nachname2 := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Vorname2 := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Status1 := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Nachname3 := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Vorname3 := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Geschlecht := copy(zeile,1,position-1);
      Delete(zeile,1,position);

      position:=Pos('"', zeile);
      Delete(zeile,1,position);
      position:=Pos('"', zeile);
      Status2 := copy(zeile,1,position-1);
      Delete(zeile,1,position);
    end;
  inc(i);
Until EOF(dat);
CloseFile(dat);
StringGrid1.RowCount := i+1;   //Zeilenanzahl des Stringgrids setzen

for j:=1 to i do               //Datensatznummerierung
begin
    StringGrid1.Cells[0,j]:=IntToStr(j);
end;

for j:=0 to i do               //In Stringgrid einlesen
  begin
    With t[j] do
      begin
      if Geschlecht = '' then
      begin
      Geschlecht := Nachname3;
      Status2 := Vorname3;
      Nachname3 := '';
      Vorname3 := '';
      end;
        StringGrid1.Cells[1,j+1]:=Klasse;
        StringGrid1.Cells[2,j+1]:=Name;
        StringGrid1.Cells[3,j+1]:=Vorname;
        StringGrid1.Cells[4,j+1]:=Strasse;
        StringGrid1.Cells[5,j+1]:=Postleitzahl;
        StringGrid1.Cells[6,j+1]:=Ort;
        StringGrid1.Cells[7,j+1]:=Geschlecht;
        StringGrid1.Cells[8,j+1]:=Nachname2;
        StringGrid1.Cells[9,j+1]:=Vorname2;
        StringGrid1.Cells[10,j+1]:=Status1;
        StringGrid1.Cells[11,j+1]:=Nachname3;
        StringGrid1.Cells[12,j+1]:=Vorname3;
        StringGrid1.Cells[13,j+1]:=Status2;
      end;
  end;
  Spaltenbreite;
btnGenerateTex.Enabled := True;  //Exportbutton aktivieren
except
Application.MessageBox('Schülerdatei konnte nicht geöffnet werden!',
                                     'Fehler', 52);
Exit;
end
end;

 //Funktion für Export
procedure TForm1.btnGenerateTexClick(Sender: TObject);
var f: TStringList;
    StartUpInfo: TStartupInfo;
    ProcessInfo: TProcessInformation;
    Anrede, Anrede2, AnredeKind, pfad, Inhalt, Inhalt2, brief,
    Lehrer, zeile, Name, Vorname, Strasse, Klasse, Postleitzahl,
    Ort, Nachname2, Vorname2, Status1, Geschlecht, Vorname3,
    Nachname3, Status2: string;
    dat: TextFile;
begin
     //Alles in Variablen schreiben
     Row := StringGrid1.Row;
     Klasse := StringGrid1.Cells[1, Row];
     Name := StringGrid1.Cells[2, Row];
     Vorname := StringGrid1.Cells[3, Row];
     Strasse := StringGrid1.Cells[4, Row];
     Postleitzahl := StringGrid1.Cells[5, Row];
     Ort := StringGrid1.Cells[6, Row];
     Geschlecht := StringGrid1.Cells[7, Row];
     Nachname2 := StringGrid1.Cells[8, Row];
     Vorname2 := StringGrid1.Cells[9, Row];
     Status1 := StringGrid1.Cells[10, Row];
     Nachname3 := StringGrid1.Cells[11, Row];
     Vorname3 := StringGrid1.Cells[12, Row];
     Status2 := StringGrid1.Cells[13, Row];
     Sprechstunden := cbSprechstunden.Items[cbSprechstunden.ItemIndex];
     Inhalt := lblText1.Caption + RichEdit1.Text + lblText2.Caption;
     Inhalt2 := RichEdit2.Text + ' ' + lblSprStd1.Caption + Sprechstunden
             + ' ' + lblSprStd2.Caption;
     Lehrer := edtLehrername.Text;

    if ((RichEdit1.Text = '') or (RichEdit2.Text = '')
       or (edtLehrername.Text = '')
       or (cbSprechstunden.Items[cbSprechstunden.ItemIndex] = '')) then
    Application.MessageBox('Sie haben noch nicht alle notwendigen Felder ausgefüllt!','Hinweis',16)
    else
    begin

     //Status der Eltern bestimmen und Anrede anpassen
     if Status1 = 'U' then begin
     Anrede := 'Sehr geehrte Frau, ' + Nachname3 + '\\ Sehr geehrter Herr ' + Nachname2;
     Anrede2 := 'Frau und Herr ' + Nachname3;
     end;

     if Status1 = 'H' then begin
     Anrede := 'Sehr geehrter Herr ' + Nachname2;
     Anrede2 := 'Herrn \\' + Vorname2 + ' ' + Nachname2;
     end;

     if Status1 = 'F' then begin
     Anrede := 'Sehr geehrte Frau ' + Nachname2;
     Anrede2 := 'Frau \\' + Vorname2 + ' ' + Nachname2;
     end;

     //Geschlecht Schüler bestimmen
     if Geschlecht = 'Ihr Sohn' then AnredeKind := 'Ihrem Sohn '
     else AnredeKind := 'Ihrer Tochter ';

     //Platzhalter in Vorlage durch Variableninhalte ersetzen
     f := TStringList.Create;
     OpenDialog2.FileName := vorlage;
     try
      AssignFile(dat, OpenDialog2.FileName);
      Reset(dat);
     Repeat
      Readln(dat,zeile);
      f.Add(zeile);
     Until EOF(dat);
      CloseFile(dat);
     except
      Application.MessageBox('Briefvorlage konnte nicht geöffnet werden!','Fehler', MB_OKCANCEL);
      Exit;
     end;
     brief := f.Text;
     brief := StringReplace(brief, '%Nachname2%', Nachname2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Vorname2%', Vorname2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Strasse%', Strasse,[rfReplaceAll]);
     brief := StringReplace(brief, '%Postleitzahl%', Postleitzahl,
           [rfReplaceAll]);
     brief := StringReplace(brief, '%Ort%', Ort,[rfReplaceAll]);
     brief := StringReplace(brief, '%Status2%', Status2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Anrede%', Anrede,[rfReplaceAll]);
     brief := StringReplace(brief, '%Anrede2%', Anrede2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Inhalt%', Inhalt,[rfReplaceAll]);
     brief := StringReplace(brief, '%Inhalt2%', Inhalt2,[rfReplaceAll]);
     brief := StringReplace(brief, '%NameKind%', Name,[rfReplaceAll]);
     brief := StringReplace(brief, '%VornameKind%', Vorname,[rfReplaceAll]);
     brief := StringReplace(brief, '%Nachname2%', Nachname2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Vorname2%', Vorname2,[rfReplaceAll]);
     brief := StringReplace(brief, '%Nachname3%', Nachname3,[rfReplaceAll]);
     brief := StringReplace(brief, '%Vorname3%', Vorname3,[rfReplaceAll]);
     brief := StringReplace(brief, '%Klasse%', Klasse,[rfReplaceAll]);
     brief := StringReplace(brief, '%Lehrer%', Lehrer,[rfReplaceAll]);
     brief := StringReplace(brief, '%AnredeKind%', AnredeKind,
           [rfReplaceAll]);
     brief := StringReplace(brief, 'ß', '{\ss}',[rfReplaceAll]);
     brief := StringReplace(brief, 'ä', '\"{a}',[rfReplaceAll]);
     brief := StringReplace(brief, 'ü', '\"{u}',[rfReplaceAll]);
     brief := StringReplace(brief, 'ö', '\"{o}',[rfReplaceAll]);
     brief := StringReplace(brief, 'Ä', '\"{A}',[rfReplaceAll]);
     brief := StringReplace(brief, 'Ü', '\"{U}',[rfReplaceAll]);
     brief := StringReplace(brief, 'Ö', '\"{O}',[rfReplaceAll]);
     f.Text := brief;

     SaveDialog1.InitialDir := tso;
     SaveDialog1.DefaultExt := 'tex';
     if SaveDialog1.Execute              //Als .tex speichern
     then begin
     pfad := SaveDialog1.FileName;
     try
     f.SaveToFile(SaveDialog1.FileName);
     except
     ShowMessage('Fehler beim Erzeugen der Datei!'); Exit
     end;
     Form1.Caption := pfad;

     //Per texify in PDF umwandeln
     FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
     StartupInfo.cb := Sizeof(TStartupInfo);
     if CreateProcess(nil, PChar(texify + ' ' + pfad), nil, nil, False,
                           CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS,
                           nil, nil, StartupInfo, ProcessInfo)
     then begin
          WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
          CloseHandle(ProcessInfo.hProcess);
          ShowMessage('In PDF umgewandelt!');
          end else ShowMessage('Datei konnte nicht umgewandelt werden!');
      f.Free;
     end
 end;
end;

//Optionen-Menü anzeigen
procedure TForm1.Einstellungen1Click(Sender: TObject);
begin Form2.Show; end;

//Programm beenden
procedure TForm1.Beenden1Click(Sender: TObject);
begin close end;

 //Suchfunktion für Stringgrid
function TForm1.SuchInGrid(StringGrid1: TStringGrid;S: String;
         SelZeile: Boolean): String;
var r: Integer;
    Abbr: Boolean;
begin  
  Abbr := False;      //Abbruchbedingung
  S := LowerCase(S);  //Nicht Case-sensitive Suche
  //Reihenanzahl bestimmen
  for r := StringGrid1.FixedRows to
      StringGrid1.RowCount-StringGrid1.FixedRows-1 do
      if LowerCase(StringGrid1.Cells[1,r]) = S then  //Treffer
      begin
        if SelZeile then
        begin
        //Treffer wird markiert
        StringGrid1.Selection := TGridRect(Rect(StringGrid1.ColCount-1,r,
                                StringGrid1.FixedCols,r));
        StringGrid1.Toprow := r   //Trefferzeile als Oberste anzeigen
        end
        else
         StringGrid1.Selection := TGridRect(Rect(1,r,1,r));
         Abbr := True;
         break;
      end;
  if Abbr = False then
  //Meldung kein Treffer
  Result := '"'+S+'"nicht in der Schülerdatei gefunden!';
end;  

 //Bei Klick auf Eintrag wird Suchfunktion gestartet
procedure TForm1.cbKlassenClick(Sender: TObject);
var sErg : String;
begin
 sErg := SuchInGrid(StringGrid1,cbKlassen.Items[cbKlassen.ItemIndex],True);
 if sErg <> '' then showmessage(sErg);
end;

 //Briefvorschau aktualisieren bei Klick auf Datenzeile
procedure TForm1.StringGrid1Click(Sender: TObject);
  var AnredeKind, AnredeKind2, Anrede, AnredeKind3, Status1,
  Vorname, Klasse, Nachname2, Geschlecht, Nachname3:string;
begin
     //In Variablen schreiben
     Row := StringGrid1.Row;
     Klasse := StringGrid1.Cells[1, Row];
     Vorname := StringGrid1.Cells[3, Row];
     Geschlecht := StringGrid1.Cells[7, Row];
     Nachname2 := StringGrid1.Cells[8, Row];
     Status1 := StringGrid1.Cells[10, Row];
     Nachname3 := StringGrid1.Cells[11, Row];

     //Geschlecht Schüler bestimmen - Anrede anpassen
     if Geschlecht = 'Ihr Sohn' then
     begin
     AnredeKind := 'Ihrem Sohn ';
     AnredeKind2 := 'Ihm ';
     AnredeKind3:= 'Ihren Sohn ';
     end
     else
     begin
     AnredeKind := 'Ihrer Tochter ';
     AnredeKind2 := 'Ihr ';
     AnredeKind3:= 'Ihre Tochter ';
     end;

     //Status der Eltern bestimmen und Anrede anpassen
     if Status1 = 'U' then begin
     Anrede := 'Sehr geehrte Frau ' + Nachname3 + ', Sehr geehrter Herr ' + Nachname2;
     end;

     if Status1 = 'H' then begin
     Anrede := 'Sehr geehrter Herr ' + Nachname2;
     end;

     if Status1 = 'F' then begin
     Anrede := 'Sehr geehrte Frau ' + Nachname2;
     end;

     lblText1.Caption := 'bei ' + AnredeKind + Vorname + ', Klasse '
                      + Klasse + ', ';
     lblText2.Caption := ' Daher erteile ich ' + AnredeKind2 + 'einen';
     lblAnredeEltern.Caption := Anrede + ',';
     lblText3.Caption := 'Bitte geben Sie dieses Schreiben umgehend über '
                      + AnredeKind3 + 'wieder an mich zurück.';
end;

 //Zellenbreite anpassen
procedure TForm1.Spaltenbreite;
var  
  z,x,Breite: Integer;
begin
  with StringGrid1 do   
  begin
  for x := 0 to ColCount-1 do
  begin
   for z := 0 to RowCount-1 do
   begin  
    if Canvas.TextWidth(Cells[x, z]) > 0 then
    Breite := Canvas.TextWidth(Cells[x, z]);    //Neue Spaltenbreite
   end;  
   ColWidths[x] := Breite + 15;
  end;
  end;  
end; 


end.
