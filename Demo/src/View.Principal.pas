unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Model.Demo, MapDataSetField,
  Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmPrincipal = class(TForm)
    mpdtstfldEmployee: TMapDataSetField;
    flwpnlEmployee: TFlowPanel;
    dbgrdEmployee: TDBGrid;
    Panel1: TPanel;
    btnGetField: TButton;
    btnSetValueField: TButton;
    btnGetValueField: TButton;
    btnGetDbEdit: TButton;
    btnListDBEdit: TButton;
    dbgrdTelephone: TDBGrid;
    flwpnlTelephone: TFlowPanel;
    mpdtstfldTelephone: TMapDataSetField;
    dbnvgrTelephone: TDBNavigator;
    DBLookupComboBox1: TDBLookupComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btnGetFieldClick(Sender: TObject);
    procedure btnSetValueFieldClick(Sender: TObject);
    procedure btnGetValueFieldClick(Sender: TObject);
    procedure btnGetDbEditClick(Sender: TObject);
    procedure btnListDBEditClick(Sender: TObject);
    procedure mpdtstfldEmployeeCreateDbComboBox(ADbComboBox: TDBComboBox;
      ALabel: TLabel; AConteiner: TWinControl);
    procedure mpdtstfldTelephoneCreateDbEdit(ADbEdit: TDBEdit; ALabel: TLabel;
      AConteiner: TWinControl);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnGetDbEditClick(Sender: TObject);
var
  LDBEdit: TDBEdit;
begin
  LDBEdit := mpdtstfldEmployee.GetDbEdit('Name');
  ShowMessage(LDBEdit.Text);
end;

procedure TfrmPrincipal.btnGetFieldClick(Sender: TObject);
var
  LField: TField;
begin
  LField := mpdtstfldEmployee.GetField('Name');
  ShowMessage(LField.AsString);
end;

procedure TfrmPrincipal.btnGetValueFieldClick(Sender: TObject);
begin
  ShowMessage(mpdtstfldEmployee.GetValueField('time'));

  try

  except on E: Exception do
  end;
end;

procedure TfrmPrincipal.btnListDBEditClick(Sender: TObject);
begin
  ShowMessage('Quantity of items DBEdit ' +
    mpdtstfldEmployee.ListDbEdit.Count.ToString);
end;

procedure TfrmPrincipal.btnSetValueFieldClick(Sender: TObject);
begin
  mpdtstfldEmployee.SetValueField('Name', 'Murilo');
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  mpdtstfldEmployee.MapDataSet(True);
  mpdtstfldTelephone.MapDataSet(True);
end;

procedure TfrmPrincipal.mpdtstfldEmployeeCreateDbComboBox(
  ADbComboBox: TDBComboBox; ALabel: TLabel; AConteiner: TWinControl);
begin
  if ADbComboBox.DataField = 'Department' then
  begin
    ADbComboBox.Items.Add('Executive');
    ADbComboBox.Items.Add('Sales');
    ADbComboBox.Items.Add('Marketing');
    ADbComboBox.Items.Add('Human Resources');
    ADbComboBox.Items.Add('Finance');
  end;
end;

procedure TfrmPrincipal.mpdtstfldTelephoneCreateDbEdit(ADbEdit: TDBEdit;
  ALabel: TLabel; AConteiner: TWinControl);
begin
  if ADbEdit.DataField = 'id_employee' then
    ADbEdit.ReadOnly := True;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
