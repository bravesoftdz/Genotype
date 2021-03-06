{
Program:      Genotyp Projekt WAT
File:         OknoDodajJednostke
Description:  Plik okna administratora - dodawanie jednostek organizacyjnych do bazy
Notes:        Kamil Rutkowski  - formatka, Dodawanie jednostek organizacyjnych
}

unit OknoDodajJednostke;

interface

uses
  ConnectionModule,uDB, Entities, IdGlobal, IdHash, IdHashMessageDigest,
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Rtti, FMX.Grid.Style, System.Hash,
  FMX.ScrollBox, FMX.Grid, System.Generics.Collections, Data.DB,
  Aurelius.Bind.BaseDataset, Aurelius.Bind.Dataset, Aurelius.Criteria.Linq, FMX.Ani, FMX.Layouts,
  FMX.ExtCtrls, FMX.Edit, FMX.ListBox, Windows, Aurelius.Engine.ObjectManager;

type
  TForm9 = class(TForm)
    Zamknij: TButton;
    jednostkaEdit: TEdit;
    ulicaEdit: TEdit;
    budynekEdit: TEdit;
    kodjedenEdit: TEdit;
    miejscowoscEdit: TEdit;
    nazwaLabel: TLabel;
    ulicaLabel: TLabel;
    budynekLabel: TLabel;
    kodLabel: TLabel;
    miejscowoscLabel: TLabel;
    Dodaj: TButton;
    DodawanieJednostki: TLabel;
    koddwaEdit: TEdit;
    myslnikLabel: TLabel;
    procedure ZamknijClick(Sender: TObject);
    procedure DodajClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.fmx}

procedure TForm9.DodajClick(Sender: TObject);
var
newJednostka:Tjednostka;
jednostkiInDB:TList<Tjednostka>;
begin
  if(jednostkaEdit.Text.Equals('') or ulicaEdit.Text.Equals('') or budynekEdit.Text.Equals('')
  or kodjedenEdit.Text.Equals('') or koddwaEdit.Text.Equals('') or miejscowoscEdit.Text.Equals('')) then
  begin
    ShowMessage('Nie wszystkie pola zosta�y uzupe�nione!');
  end
  else
  begin
    jednostkiInDB:=DBConnection.Manager.Find<Tjednostka>().Where(Linq['FnazwaJEDNOSTKA']=jednostkaEdit.Text).List;
    try
        if(jednostkiInDB.Count = 0) then
        begin
          newJednostka:=Tjednostka.Create;
          newJednostka.nazwaJEDNOSTKA:=jednostkaEdit.Text;
          newJednostka.ulica:=ulicaEdit.Text;
          newJednostka.nrBUDYNKU:=budynekEdit.Text;
          newJednostka.kodPOCZTOWY:=kodjedenEdit.Text+'-'+koddwaEdit.Text;
          newJednostka.miejscowosc:=miejscowoscEdit.Text;
          DBConnection.Manager.Save(newJednostka);
          DBConnection.Manager.Flush;
        end
        else
          ShowMessage('Istnieje ju� jednostka o takiej nazwie!');
    finally
        FreeAndNil(jednostkiInDB);
    end;
  end;
end;

procedure TForm9.ZamknijClick(Sender: TObject);
begin
  Close;
end;

end.
