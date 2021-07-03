unit DBDateTime;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ComCtrls, Vcl.DBCtrls,
  Data.DB, Winapi.Messages;

type
  TDBDateTime = class(TDateTimePicker)
  private
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(const Value: TDataSource);

  strict private
    FDataLink: TFieldDataLink;
    procedure UpdateData(ASender:TObject);
    procedure DataChange(ASender: TObject);
    procedure CMExit(var Msg: TMessage); message CM_EXIT;

  protected
    procedure Change; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

{ TDBDateTime }

procedure TDBDateTime.Change;
begin
  if not(FDataLink.Editing) then
    FDataLink.Edit;

  FDataLink.Modified;
  inherited;
end;

procedure TDBDateTime.CMExit(var Msg: TMessage);
begin
  try
    FDataLink.UpdateRecord;
  except
    on Exception do
      Self.SetFocus;
  end;
  inherited;
end;

constructor TDBDateTime.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

procedure TDBDateTime.DataChange(ASender: TObject);
begin
  if (Assigned(FDataLink.DataSource)) and (Assigned(FDataLink.Field)) then
  begin
    Self.Format := TDateTimeField(FDataLink.Field).DisplayFormat;
    Self.Date := FDataLink.Field.AsDateTime;
  end;
end;

destructor TDBDateTime.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited;
end;

function TDBDateTime.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TDBDateTime.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TDBDateTime.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TDBDateTime.SetDataSource(const Value: TDataSource);
begin
  FDataLink.DataSource := Value;
end;

procedure TDBDateTime.UpdateData(ASender: TObject);
begin
  FDataLink.Field.AsDateTime := Self.DateTime;
end;

end.
