unit MapDataSetFieldRegister;

interface

uses
  MapDataSetField, System.SysUtils, System.Classes;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MapDataSetField', [TMapDataSetField]);
end;

end.
