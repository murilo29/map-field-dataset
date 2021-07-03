unit MapEvent;

interface

uses
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Controls, DBDateTime;

type
  TOnCreateDbEdit = procedure(ADbEdit: TDBEdit; ALabel: TLabel;
    AConteiner: TWinControl) of object;
  TOnCreateDbMemo = procedure(ADbMemo: TDBMemo; ALabel: TLabel;
    AConteiner: TWinControl) of object;
  TOnCreateDbDateTime = procedure(ADbDateTime: TDBDateTime; ALabel: TLabel;
    AConteiner: TWinControl) of object;
  TOnCreateDbComboBox = procedure(ADbComboBox: TDBComboBox; ALabel: TLabel;
    AConteiner: TWinControl) of object;
  TOnCreateDbCheckBox = procedure(ADbCheckBox: TDBCheckBox;
    AConteiner: TWinControl) of object;

implementation

end.
