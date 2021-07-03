unit MapDataSetField;

interface

uses
  System.SysUtils, System.Classes, Vcl.DBCtrls, Data.DB, MapEvent, Vcl.Controls,
  System.UITypes, System.Generics.Collections, DBDateTime;

type
  TMapDataSetField = class(TComponent)
  private
    FDataSource: TDataSource;
    FLimitEditCharacters: Integer;
    FOnCreateDbEdit: TOnCreateDbEdit;
    FConteiner: TWinControl;
    FOnCreateDbMemo: TOnCreateDbMemo;
    FCharCase: TEditCharCase;
    FOnCreateDbDateTime: TOnCreateDbDateTime;
    FOnCreateDbCheckBox: TOnCreateDbCheckBox;
    FMultipleSelection: TStrings;
    FOnCreateDbComboBox: TOnCreateDbComboBox;
    procedure SetDataSource(const Value: TDataSource);
    procedure SetOnCreateDbEdit(const Value: TOnCreateDbEdit);
    procedure SetLimitEditCharacters(const Value: Integer);
    procedure SetConteiner(const Value: TWinControl);
    procedure SetOnCreateDbMemo(const Value: TOnCreateDbMemo);
    procedure SetCharCase(const Value: TEditCharCase);
    procedure SetOnCreateDbDateTime(const Value: TOnCreateDbDateTime);
    procedure SetOnCreateDbCheckBox(const Value: TOnCreateDbCheckBox);
    procedure SetMultipleSelection(const Value: TStrings);
    procedure SetOnCreateDbComboBox(const Value: TOnCreateDbComboBox);

  strict private
    FListDbEdit: TList<TDBEdit>;
    FListDbMemo: TList<TDBMemo>;
    FListDbDateTime: TList<TDBDateTime>;
    FListDbComboBox: TList<TDBComboBox>;
    FListDbCheckBox: TList<TDBCheckBox>;
    procedure CreateDbEdit(AField: TField);
    procedure CreateDbMemo(AField: TField);
    procedure CreateDbDateTime(AField: TField);
    procedure CreateDbComboBox(AField: TField);
    procedure CreateDbCheckBox(AField: TField);

  protected

  public
    procedure Open();
    procedure Close();
    procedure MapDataSet(AActive: Boolean = False);
    procedure SetValueField(AFieldName: string; AValue: string);

    function GetDataSet: TDataSet;
    function GetDbEdit(AName: string): TDBEdit;
    function GetDbMemo(AName: string): TDBMemo;
    function GetDbDateTime(AName: string): TDBDateTime;
    function GetDbCombobox(AName: string): TDBComboBox;
    function GetDbCheckBox(AName: string): TDBCheckBox;

    function GetField(AFieldName: string): TField;
    function GetValueField(AFieldName: string): string;

    property ListDbEdit: TList<TDBEdit> read FListDbEdit;
    property ListDbMemo: TList<TDBMemo> read FListDbMemo;
    property ListDbDateTime: TList<TDBDateTime> read FListDbDateTime;
    property ListDbComboBox: TList<TDBComboBox> read FListDbComboBox;
    property ListDbCheckBox: TList<TDBCheckBox> read FListDbCheckBox;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CharCase: TEditCharCase read FCharCase write SetCharCase
      default TEditCharCase.ecNormal;
    property MultipleSelection: TStrings read FMultipleSelection
      write SetMultipleSelection;
    property Conteiner: TWinControl read FConteiner write SetConteiner;
    property LimitEditCharacters: Integer read FLimitEditCharacters
      write SetLimitEditCharacters;
    property DataSource: TDataSource read FDataSource write SetDataSource;
    property OnCreateDbEdit: TOnCreateDbEdit read FOnCreateDbEdit
      write SetOnCreateDbEdit;
    property OnCreateDbMemo: TOnCreateDbMemo read FOnCreateDbMemo
      write SetOnCreateDbMemo;
    property OnCreateDbDateTime: TOnCreateDbDateTime read FOnCreateDbDateTime
      write SetOnCreateDbDateTime;
    property OnCreateDbComboBox: TOnCreateDbComboBox read FOnCreateDbComboBox
      write SetOnCreateDbComboBox;
    property OnCreateDbCheckBox: TOnCreateDbCheckBox read FOnCreateDbCheckBox
      write SetOnCreateDbCheckBox;
  end;

implementation

uses
  Vcl.StdCtrls;

const
  DB_NAME_EDIT = 'edt';
  DB_NAME_MEMO = 'mmo';
  DB_NAME_DATETIME = 'dtm';
  DB_NAME_COMBOBOX = 'cbx';
  DB_NAME_CHECKBOX = 'chx';

  { TMapDataSetField }

procedure TMapDataSetField.Close;
begin
  GetDataSet.Close;
end;

constructor TMapDataSetField.Create(AOwner: TComponent);
begin
  inherited;
  FListDbEdit := TList<TDBEdit>.Create;
  FListDbMemo := TList<TDBMemo>.Create;
  FListDbDateTime := TList<TDBDateTime>.Create;
  FListDbComboBox := TList<TDBComboBox>.Create;
  FListDbCheckBox := TList<TDBCheckBox>.Create;

  FMultipleSelection := TStringList.Create;
end;

procedure TMapDataSetField.CreateDbCheckBox(AField: TField);
var
  LConteiner: TWinControl;
  LDbCheckBox: TDBCheckBox;
begin
  LDbCheckBox := TDBCheckBox.Create(Self);
  LDbCheckBox.AlignWithMargins := True;
  LDbCheckBox.DataSource := DataSource;
  LDbCheckBox.DataField := AField.FieldName;
  LDbCheckBox.Caption := AField.DisplayLabel;
  LDbCheckBox.Name := DB_NAME_CHECKBOX + LowerCase(AField.FieldName);

  LConteiner := TWinControl.Create(Conteiner);
  LConteiner.Width := AField.DisplayWidth * 4;
  LConteiner.Height := 48;
  LDbCheckBox.Parent := LConteiner;
  LConteiner.Parent := Conteiner;

  FListDbCheckBox.Add(LDbCheckBox);

  LDbCheckBox.Align := TAlign.alBottom;

  if Assigned(FOnCreateDbCheckBox) then
    OnCreateDbCheckBox(LDbCheckBox, LConteiner);
end;

procedure TMapDataSetField.CreateDbComboBox(AField: TField);
var
  LLabel: TLabel;
  LDbComboBox: TDBComboBox;
  LConteiner: TWinControl;
begin
  LLabel := TLabel.Create(Self);
  LLabel.Align := TAlign.alTop;
  LLabel.AlignWithMargins := True;
  LLabel.Caption := AField.DisplayLabel;

  LDbComboBox := TDBComboBox.Create(Self);
  LDbComboBox.Align := TAlign.alTop;
  LDbComboBox.AlignWithMargins := True;
  LDbComboBox.DataSource := DataSource;
  LDbComboBox.DataField := AField.FieldName;
  LDbComboBox.Name := DB_NAME_COMBOBOX + LowerCase(AField.FieldName);

  FListDbComboBox.Add(LDbComboBox);

  LConteiner := TWinControl.Create(Conteiner);
  LConteiner.Width := AField.DisplayWidth * 4;
  LConteiner.Height := LLabel.Height + LDbComboBox.Height + 10;
  LLabel.Parent := LConteiner;
  LDbComboBox.Parent := LConteiner;
  LConteiner.Parent := Conteiner;

  if Assigned(FOnCreateDbComboBox) then
    OnCreateDbComboBox(LDbComboBox, LLabel, LConteiner);
end;

procedure TMapDataSetField.CreateDbDateTime(AField: TField);
var
  LLabel: TLabel;
  LDbDateTime: TDBDateTime;
  LConteiner: TWinControl;
begin
  LLabel := TLabel.Create(Self);
  LLabel.Align := TAlign.alTop;
  LLabel.AlignWithMargins := True;
  LLabel.Caption := AField.DisplayLabel;

  LDbDateTime := TDBDateTime.Create(Self);
  LDbDateTime.Align := TAlign.alTop;
  LDbDateTime.AlignWithMargins := True;
  LDbDateTime.DataSource := DataSource;
  LDbDateTime.DataField := AField.FieldName;
  LDbDateTime.Name := DB_NAME_DATETIME + LowerCase(AField.FieldName);

  FListDbDateTime.Add(LDbDateTime);

  LConteiner := TWinControl.Create(Conteiner);
  LConteiner.Width := AField.DisplayWidth * 4;
  LConteiner.Height := LLabel.Height + LDbDateTime.Height + 10;
  LLabel.Parent := LConteiner;
  LDbDateTime.Parent := LConteiner;
  LConteiner.Parent := Conteiner;

  if Assigned(FOnCreateDbDateTime) then
    OnCreateDbDateTime(LDbDateTime, LLabel, LConteiner);
end;

procedure TMapDataSetField.CreateDbEdit(AField: TField);
var
  LLabel: TLabel;
  LDbEdit: TDBEdit;
  LConteiner: TWinControl;
begin
  LLabel := TLabel.Create(Self);
  LLabel.Align := TAlign.alTop;
  LLabel.AlignWithMargins := True;
  LLabel.Caption := AField.DisplayLabel;

  LDbEdit := TDBEdit.Create(Self);
  LDbEdit.Align := TAlign.alTop;
  LDbEdit.AlignWithMargins := True;
  LDbEdit.DataSource := DataSource;
  LDbEdit.DataField := AField.FieldName;
  LDbEdit.CharCase := CharCase;
  LDbEdit.Name := DB_NAME_EDIT + LowerCase(AField.FieldName);

  FListDbEdit.Add(LDbEdit);

  LConteiner := TWinControl.Create(Conteiner);
  LConteiner.Width := AField.DisplayWidth * 4;
  LConteiner.Height := LLabel.Height + LDbEdit.Height + 10;
  LLabel.Parent := LConteiner;
  LDbEdit.Parent := LConteiner;
  LConteiner.Parent := Conteiner;

  if Assigned(FOnCreateDbEdit) then
    OnCreateDbEdit(LDbEdit, LLabel, LConteiner);
end;

procedure TMapDataSetField.CreateDbMemo(AField: TField);
var
  LLabel: TLabel;
  LDbMemo: TDBMemo;
  LConteiner: TWinControl;
begin
  LLabel := TLabel.Create(Self);
  LLabel.Align := TAlign.alTop;
  LLabel.AlignWithMargins := True;
  LLabel.Caption := AField.DisplayLabel;

  LDbMemo := TDBMemo.Create(Self);
  LDbMemo.Align := TAlign.alTop;
  LDbMemo.AlignWithMargins := True;
  LDbMemo.DataSource := DataSource;
  LDbMemo.DataField := AField.FieldName;
  LDbMemo.Name := DB_NAME_MEMO + LowerCase(AField.FieldName);

  FListDbMemo.Add(LDbMemo);

  LConteiner := TWinControl.Create(Conteiner);
  LConteiner.Width := AField.DisplayWidth * 4;
  LConteiner.Height := LLabel.Height + LDbMemo.Height + 10;
  LLabel.Parent := LConteiner;
  LDbMemo.Parent := LConteiner;
  LConteiner.Parent := Conteiner;

  if Assigned(FOnCreateDbMemo) then
    OnCreateDbMemo(LDbMemo, LLabel, LConteiner);
end;

destructor TMapDataSetField.Destroy;
begin
  FreeAndNil(FListDbEdit);
  FreeAndNil(FListDbMemo);
  FreeAndNil(FListDbDateTime);
  FreeAndNil(FListDbComboBox);
  FreeAndNil(FListDbCheckBox);
  FreeAndNil(FMultipleSelection);
  inherited;
end;

function TMapDataSetField.GetDataSet: TDataSet;
begin
  Result := DataSource.DataSet;
end;

function TMapDataSetField.GetDbCheckBox(AName: string): TDBCheckBox;
var
  LDB: TDBCheckBox;
begin
  Result := nil;

  for LDB in FListDbCheckBox do
  begin
    if LDB.Name = DB_NAME_CHECKBOX + LowerCase(AName) then
      Result := LDB;
  end;

  if Result = nil then
    raise Exception.Create('BDCheckBox ' + AName + ' Not Found');
end;

function TMapDataSetField.GetDbCombobox(AName: string): TDBComboBox;
var
  LDB: TDBComboBox;
begin
  Result := nil;

  for LDB in FListDbComboBox do
  begin
    if LDB.Name = DB_NAME_COMBOBOX + LowerCase(AName) then
      Result := LDB;
  end;

  if Result = nil then
    raise Exception.Create('DBComboBox ' + AName + ' Not Found');
end;

function TMapDataSetField.GetDbDateTime(AName: string): TDBDateTime;
var
  LDB: TDBDateTime;
begin
  Result := nil;

  for LDB in FListDbDateTime do
  begin
    if LDB.Name = DB_NAME_DATETIME + LowerCase(AName) then
      Result := LDB;
  end;

  if Result = nil then
    raise Exception.Create('DBDateTime ' + AName + ' Not Found');
end;

function TMapDataSetField.GetDbEdit(AName: string): TDBEdit;
var
  LDB: TDBEdit;
begin
  Result := nil;

  for LDB in FListDbEdit do
  begin
    if LDB.Name = DB_NAME_EDIT + LowerCase(AName) then
      Result := LDB;
  end;

  if Result = nil then
    raise Exception.Create('DBEdit ' + AName + ' Not Found');
end;

function TMapDataSetField.GetDbMemo(AName: string): TDBMemo;
var
  LDB: TDBMemo;
begin
  Result := nil;

  for LDB in FListDbMemo do
  begin
    if LDB.Name = DB_NAME_MEMO + LowerCase(AName) then
      Result := LDB;
  end;

  if Result = nil then
    raise Exception.Create('DBMemo ' + AName + ' Not Found');
end;

function TMapDataSetField.GetField(AFieldName: string): TField;
begin
  Result := DataSource.DataSet.FindField(AFieldName);
  if Result = nil then
    raise Exception.Create('Field Not Found');
end;

function TMapDataSetField.GetValueField(AFieldName: string): string;
begin
  Result := GetField(AFieldName).AsString;
end;

procedure TMapDataSetField.MapDataSet(AActive: Boolean);
var
  LField: TField;
  LDataSet: TDataSet;
begin
  if FConteiner = nil then
    raise Exception.Create('Conteiner Not Found');

  if FDataSource = nil then
    raise Exception.Create('DataSource Not Found');

  if FDataSource.DataSet = nil then
    raise Exception.Create('DataSet Not Found');

  LDataSet := GetDataSet;

  for LField in LDataSet.Fields do
  begin
    if LField.Visible = False then
      Continue;

    if FMultipleSelection.IndexOf(LField.FieldName) <> -1 then
      CreateDbComboBox(LField)
    else
    begin
      case LField.DataType of
        ftString, ftSmallint, ftInteger, ftFloat, ftBCD, ftCurrency, ftFmtMemo,
          ftWideString, ftLargeint, ftFMTBcd, ftFixedWideChar, ftWideMemo,
          ftLongWord, ftShortint, ftSingle, ftMemo, ftTime, ftOraTimeStamp,
          ftTimeStamp:
          begin
            if LField.Size <= LimitEditCharacters then
              CreateDbEdit(LField)
            else
              CreateDbMemo(LField);
          end;
        ftBoolean:
          CreateDbCheckBox(LField);
        ftDateTime, ftDate:
          CreateDbDateTime(LField);
      end;
    end;
  end;

  LDataSet.Active := AActive;
end;

procedure TMapDataSetField.Open;
begin
  GetDataSet.Open;
end;

procedure TMapDataSetField.SetCharCase(const Value: TEditCharCase);
begin
  FCharCase := Value;
end;

procedure TMapDataSetField.SetConteiner(const Value: TWinControl);
begin
  FConteiner := Value;
end;

procedure TMapDataSetField.SetDataSource(const Value: TDataSource);
begin
  FDataSource := Value;
end;

procedure TMapDataSetField.SetLimitEditCharacters(const Value: Integer);
begin
  FLimitEditCharacters := Value;
end;

procedure TMapDataSetField.SetMultipleSelection(const Value: TStrings);
begin
  FMultipleSelection.Assign(Value);
end;

procedure TMapDataSetField.SetOnCreateDbCheckBox(const Value
  : TOnCreateDbCheckBox);
begin
  FOnCreateDbCheckBox := Value;
end;

procedure TMapDataSetField.SetOnCreateDbComboBox(const Value
  : TOnCreateDbComboBox);
begin
  FOnCreateDbComboBox := Value;
end;

procedure TMapDataSetField.SetOnCreateDbDateTime(const Value
  : TOnCreateDbDateTime);
begin
  FOnCreateDbDateTime := Value;
end;

procedure TMapDataSetField.SetOnCreateDbEdit(const Value: TOnCreateDbEdit);
begin
  FOnCreateDbEdit := Value;
end;

procedure TMapDataSetField.SetOnCreateDbMemo(const Value: TOnCreateDbMemo);
begin
  FOnCreateDbMemo := Value;
end;

procedure TMapDataSetField.SetValueField(AFieldName, AValue: string);
var
  LDataSet: TDataSet;
begin
  LDataSet := GetDataSet;
  if not LDataSet.Active then
    raise Exception.Create('DataSet Not Active');

  LDataSet.Edit;
  LDataSet.FieldByName(AFieldName).AsString := AValue;
  LDataSet.Post;
end;

end.
