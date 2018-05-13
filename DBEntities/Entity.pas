unit Entity;

interface

uses
  SysUtils, 
  Generics.Collections, 
  Aurelius.Mapping.Attributes, 
  Aurelius.Types.Blob, 
  Aurelius.Types.DynamicProperties, 
  Aurelius.Types.Nullable, 
  Aurelius.Types.Proxy, 
  Aurelius.Criteria.Dictionary;

type
  TBadanie = class;
  TJednostkaOrganizacyjna = class;
  TOsoba = class;
  TOsobaTableDictionary = class;
  TBadanieTableDictionary = class;
  TJednostkaOrganizacyjnaTableDictionary = class;
  
  [Entity]
  [Table('Badanie')]
  [Automapping]
  [Id('FBadanieId', TIdGenerator.IdentityOrSequence)]
  TBadanie = class
  private
    [Column('BadanieId', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FBadanieId: Int64;

    [Column('DataBadania', [TColumnProp.Required])]
    FDataBadania: TDateTime;

    [Column('Aktywny', [])]
    FAktywny: Nullable<Integer>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('OsobaId', [], 'OsobaId')]
    FOsobaId: Proxy<TOsoba>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('JednostkaOrganizacyjnaId', [], 'JednostkaOrganizacyjnaId')]
    FJednostkaOrganizacyjnaId: Proxy<TJednostkaOrganizacyjna>;
    function GetOsobaId: TOsoba;
    procedure SetOsobaId(const Value: TOsoba);
    function GetJednostkaOrganizacyjnaId: TJednostkaOrganizacyjna;
    procedure SetJednostkaOrganizacyjnaId(const Value: TJednostkaOrganizacyjna);
  public
    property BadanieId: Int64 read FBadanieId write FBadanieId;
    property DataBadania: TDateTime read FDataBadania write FDataBadania;
    property Aktywny: Nullable<Integer> read FAktywny write FAktywny;
    property OsobaId: TOsoba read GetOsobaId write SetOsobaId;
    property JednostkaOrganizacyjnaId: TJednostkaOrganizacyjna read GetJednostkaOrganizacyjnaId write SetJednostkaOrganizacyjnaId;
  end;

  [Entity]
  [Table('JednostkaOrganizacyjna')]
  [Automapping]
  [Id('FJednostkaOrganizacyjnaId', TIdGenerator.IdentityOrSequence)]
  TJednostkaOrganizacyjna = class
  private
    [Column('JednostkaOrganizacyjnaId', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FJednostkaOrganizacyjnaId: Int64;

    [Column('Nazwa', [], 250)]
    FNazwa: Nullable<string>;

    [Column('Aktywny', [])]
    FAktywny: Nullable<Integer>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('JednostkaOrganizacyjnaIdId', [], 'JednostkaOrganizacyjnaId')]
    FJednostkaOrganizacyjnaIdId: Proxy<TJednostkaOrganizacyjna>;
    function GetJednostkaOrganizacyjnaIdId: TJednostkaOrganizacyjna;
    procedure SetJednostkaOrganizacyjnaIdId(const Value: TJednostkaOrganizacyjna);
  public
    property JednostkaOrganizacyjnaId: Int64 read FJednostkaOrganizacyjnaId write FJednostkaOrganizacyjnaId;
    property Nazwa: Nullable<string> read FNazwa write FNazwa;
    property Aktywny: Nullable<Integer> read FAktywny write FAktywny;
    property JednostkaOrganizacyjnaIdId: TJednostkaOrganizacyjna read GetJednostkaOrganizacyjnaIdId write SetJednostkaOrganizacyjnaIdId;
  end;

  [Entity]
  [Table('Osoba')]
  [Automapping]
  [Id('FOsobaId', TIdGenerator.IdentityOrSequence)]
  TOsoba = class
  private
    [Column('OsobaId', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    FOsobaId: Int64;

    [Column('Nazwisko', [], 100)]
    FNazwisko: Nullable<string>;

    [Column('Imie', [], 50)]
    FImie: Nullable<string>;

    [Column('Identyfikator', [], 50)]
    FIdentyfikator: Nullable<string>;

    [Column('Aktywny', [])]
    FAktywny: Nullable<Integer>;

    [Association([TAssociationProp.Lazy], CascadeTypeAll - [TCascadeType.Remove])]
    [JoinColumn('OsobaIdId', [], 'OsobaId')]
    FOsobaIdId: Proxy<TOsoba>;
    function GetOsobaIdId: TOsoba;
    procedure SetOsobaIdId(const Value: TOsoba);
  public
    property OsobaId: Int64 read FOsobaId write FOsobaId;
    property Nazwisko: Nullable<string> read FNazwisko write FNazwisko;
    property Imie: Nullable<string> read FImie write FImie;
    property Identyfikator: Nullable<string> read FIdentyfikator write FIdentyfikator;
    property Aktywny: Nullable<Integer> read FAktywny write FAktywny;
    property OsobaIdId: TOsoba read GetOsobaIdId write SetOsobaIdId;
  end;

  TDicDictionary = class
  private
    FOsoba: TOsobaTableDictionary;
    FBadanie: TBadanieTableDictionary;
    FJednostkaOrganizacyjna: TJednostkaOrganizacyjnaTableDictionary;
    function GetOsoba: TOsobaTableDictionary;
    function GetBadanie: TBadanieTableDictionary;
    function GetJednostkaOrganizacyjna: TJednostkaOrganizacyjnaTableDictionary;
  public
    destructor Destroy; override;
    property Osoba: TOsobaTableDictionary read GetOsoba;
    property Badanie: TBadanieTableDictionary read GetBadanie;
    property JednostkaOrganizacyjna: TJednostkaOrganizacyjnaTableDictionary read GetJednostkaOrganizacyjna;
  end;

  TOsobaTableDictionary = class
  private
    FOsobaId: TDictionaryAttribute;
    FNazwisko: TDictionaryAttribute;
    FImie: TDictionaryAttribute;
    FIdentyfikator: TDictionaryAttribute;
    FAktywny: TDictionaryAttribute;
    FOsobaIdId: TDictionaryAssociation;
  public
    constructor Create;
    property OsobaId: TDictionaryAttribute read FOsobaId;
    property Nazwisko: TDictionaryAttribute read FNazwisko;
    property Imie: TDictionaryAttribute read FImie;
    property Identyfikator: TDictionaryAttribute read FIdentyfikator;
    property Aktywny: TDictionaryAttribute read FAktywny;
    property OsobaIdId: TDictionaryAssociation read FOsobaIdId;
  end;
  
  TBadanieTableDictionary = class
  private
    FBadanieId: TDictionaryAttribute;
    FDataBadania: TDictionaryAttribute;
    FAktywny: TDictionaryAttribute;
    FOsobaId: TDictionaryAssociation;
    FJednostkaOrganizacyjnaId: TDictionaryAssociation;
  public
    constructor Create;
    property BadanieId: TDictionaryAttribute read FBadanieId;
    property DataBadania: TDictionaryAttribute read FDataBadania;
    property Aktywny: TDictionaryAttribute read FAktywny;
    property OsobaId: TDictionaryAssociation read FOsobaId;
    property JednostkaOrganizacyjnaId: TDictionaryAssociation read FJednostkaOrganizacyjnaId;
  end;
  
  TJednostkaOrganizacyjnaTableDictionary = class
  private
    FJednostkaOrganizacyjnaId: TDictionaryAttribute;
    FNazwa: TDictionaryAttribute;
    FAktywny: TDictionaryAttribute;
    FJednostkaOrganizacyjnaIdId: TDictionaryAssociation;
  public
    constructor Create;
    property JednostkaOrganizacyjnaId: TDictionaryAttribute read FJednostkaOrganizacyjnaId;
    property Nazwa: TDictionaryAttribute read FNazwa;
    property Aktywny: TDictionaryAttribute read FAktywny;
    property JednostkaOrganizacyjnaIdId: TDictionaryAssociation read FJednostkaOrganizacyjnaIdId;
  end;
  
function Dic: TDicDictionary;

implementation

var
  __Dic: TDicDictionary;

function Dic: TDicDictionary;
begin
  if __Dic = nil then __Dic := TDicDictionary.Create;
  result := __Dic
end;

{ TBadanie }

function TBadanie.GetOsobaId: TOsoba;
begin
  result := FOsobaId.Value;
end;

procedure TBadanie.SetOsobaId(const Value: TOsoba);
begin
  FOsobaId.Value := Value;
end;

function TBadanie.GetJednostkaOrganizacyjnaId: TJednostkaOrganizacyjna;
begin
  result := FJednostkaOrganizacyjnaId.Value;
end;

procedure TBadanie.SetJednostkaOrganizacyjnaId(const Value: TJednostkaOrganizacyjna);
begin
  FJednostkaOrganizacyjnaId.Value := Value;
end;

{ TJednostkaOrganizacyjna }

function TJednostkaOrganizacyjna.GetJednostkaOrganizacyjnaIdId: TJednostkaOrganizacyjna;
begin
  result := FJednostkaOrganizacyjnaIdId.Value;
end;

procedure TJednostkaOrganizacyjna.SetJednostkaOrganizacyjnaIdId(const Value: TJednostkaOrganizacyjna);
begin
  FJednostkaOrganizacyjnaIdId.Value := Value;
end;

{ TOsoba }

function TOsoba.GetOsobaIdId: TOsoba;
begin
  result := FOsobaIdId.Value;
end;

procedure TOsoba.SetOsobaIdId(const Value: TOsoba);
begin
  FOsobaIdId.Value := Value;
end;

{ TDicDictionary }

destructor TDicDictionary.Destroy;
begin
  if FJednostkaOrganizacyjna <> nil then FJednostkaOrganizacyjna.Free;
  if FBadanie <> nil then FBadanie.Free;
  if FOsoba <> nil then FOsoba.Free;
  inherited;
end;

function TDicDictionary.GetOsoba: TOsobaTableDictionary;
begin
  if FOsoba = nil then FOsoba := TOsobaTableDictionary.Create;
  result := FOsoba;
end;

function TDicDictionary.GetBadanie: TBadanieTableDictionary;
begin
  if FBadanie = nil then FBadanie := TBadanieTableDictionary.Create;
  result := FBadanie;
end;

function TDicDictionary.GetJednostkaOrganizacyjna: TJednostkaOrganizacyjnaTableDictionary;
begin
  if FJednostkaOrganizacyjna = nil then FJednostkaOrganizacyjna := TJednostkaOrganizacyjnaTableDictionary.Create;
  result := FJednostkaOrganizacyjna;
end;

{ TOsobaTableDictionary }

constructor TOsobaTableDictionary.Create;
begin
  inherited;
  FOsobaId := TDictionaryAttribute.Create('OsobaId');
  FNazwisko := TDictionaryAttribute.Create('Nazwisko');
  FImie := TDictionaryAttribute.Create('Imie');
  FIdentyfikator := TDictionaryAttribute.Create('Identyfikator');
  FAktywny := TDictionaryAttribute.Create('Aktywny');
  FOsobaIdId := TDictionaryAssociation.Create('OsobaIdId');
end;

{ TBadanieTableDictionary }

constructor TBadanieTableDictionary.Create;
begin
  inherited;
  FBadanieId := TDictionaryAttribute.Create('BadanieId');
  FDataBadania := TDictionaryAttribute.Create('DataBadania');
  FAktywny := TDictionaryAttribute.Create('Aktywny');
  FOsobaId := TDictionaryAssociation.Create('OsobaId');
  FJednostkaOrganizacyjnaId := TDictionaryAssociation.Create('JednostkaOrganizacyjnaId');
end;

{ TJednostkaOrganizacyjnaTableDictionary }

constructor TJednostkaOrganizacyjnaTableDictionary.Create;
begin
  inherited;
  FJednostkaOrganizacyjnaId := TDictionaryAttribute.Create('JednostkaOrganizacyjnaId');
  FNazwa := TDictionaryAttribute.Create('Nazwa');
  FAktywny := TDictionaryAttribute.Create('Aktywny');
  FJednostkaOrganizacyjnaIdId := TDictionaryAssociation.Create('JednostkaOrganizacyjnaIdId');
end;

initialization
  RegisterEntity(TOsoba);
  RegisterEntity(TBadanie);
  RegisterEntity(TJednostkaOrganizacyjna);

finalization
  if __Dic <> nil then __Dic.Free

end.