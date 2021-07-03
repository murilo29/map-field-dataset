unit DBDateTimeRegister;

interface

uses
  DBDateTime, System.SysUtils, System.Classes;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MapDataSetField', [TDBDateTime]);
end;

end.
