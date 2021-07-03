unit Model.Demo;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdtmdlDemo = class(TDataModule)
    conConnection: TFDConnection;
    Driver: TFDPhysSQLiteDriverLink;
    Cursor: TFDGUIxWaitCursor;
    fdqryEmployee: TFDQuery;
    fdqryEmployeeID: TIntegerField;
    fdqryEmployeeSeniority: TIntegerField;
    dsEmployee: TDataSource;
    fdqryEmployeetime: TTimeField;
    fdqryEmployeedatetime: TDateTimeField;
    fdqryEmployeeactive: TBooleanField;
    fdqryEmployeeName: TStringField;
    a: TStringField;
    fdqryTelephone: TFDQuery;
    fdqryTelephoneid: TFDAutoIncField;
    fdqryTelephoneid_employee: TIntegerField;
    fdqryTelephonedescription: TStringField;
    fdqryTelephonetelephone: TStringField;
    dsTelephone: TDataSource;
    fdqryEmployeeid_remuneration: TIntegerField;
    fdqryRemuneration: TFDQuery;
    fdqryRemunerationid: TFDAutoIncField;
    fdqryRemunerationvalue: TFloatField;
    fdqryEmployeeRemuneatrion: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmdlDemo: TdtmdlDemo;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
