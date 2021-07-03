object dtmdlDemo: TdtmdlDemo
  OldCreateOrder = False
  Height = 362
  Width = 680
  object conConnection: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\Componente\Demo\Test\Win32\Debug\Employees.' +
        's3db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 32
    Top = 16
  end
  object Driver: TFDPhysSQLiteDriverLink
    Left = 112
    Top = 16
  end
  object Cursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 168
    Top = 16
  end
  object fdqryEmployee: TFDQuery
    Connection = conConnection
    SQL.Strings = (
      'select * from employee')
    Left = 32
    Top = 72
    object fdqryEmployeeID: TIntegerField
      DisplayLabel = 'Cod'
      DisplayWidth = 20
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object fdqryEmployeeName: TStringField
      DisplayWidth = 60
      FieldName = 'Name'
      Origin = 'Name'
      Size = 100
    end
    object a: TStringField
      DisplayWidth = 60
      FieldName = 'Department'
      Origin = 'Department'
      Size = 100
    end
    object fdqryEmployeeSeniority: TIntegerField
      DisplayWidth = 20
      FieldName = 'Seniority'
      Origin = 'Seniority'
    end
    object fdqryEmployeedatetime: TDateTimeField
      DisplayLabel = 'Date'
      DisplayWidth = 25
      FieldName = 'datetime'
      Origin = 'datetime'
      DisplayFormat = 'dd/MM/yyyy'
      EditMask = '!99/99/0000;1;_'
    end
    object fdqryEmployeetime: TTimeField
      DisplayWidth = 20
      FieldName = 'time'
      Origin = 'time'
      DisplayFormat = 'hh:mm'
      EditMask = '!90:00;1;_'
    end
    object fdqryEmployeeactive: TBooleanField
      DisplayLabel = 'Active'
      DisplayWidth = 20
      FieldName = 'active'
      Origin = 'active'
    end
    object fdqryEmployeeid_remuneration: TIntegerField
      FieldName = 'id_remuneration'
      Origin = 'id_remuneration'
      Visible = False
    end
    object fdqryEmployeeRemuneatrion: TIntegerField
      FieldKind = fkLookup
      FieldName = 'Remuneatrion'
      LookupDataSet = fdqryRemuneration
      LookupKeyFields = 'id'
      LookupResultField = 'value'
      KeyFields = 'id_remuneration'
      Visible = False
      Lookup = True
    end
  end
  object dsEmployee: TDataSource
    DataSet = fdqryEmployee
    Left = 32
    Top = 128
  end
  object fdqryTelephone: TFDQuery
    IndexFieldNames = 'id_employee'
    MasterSource = dsEmployee
    MasterFields = 'ID'
    DetailFields = 'id_employee'
    Connection = conConnection
    SQL.Strings = (
      'select * from telephone'
      'where id_employee = :id')
    Left = 128
    Top = 72
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object fdqryTelephoneid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      Visible = False
    end
    object fdqryTelephoneid_employee: TIntegerField
      DisplayLabel = 'Cod/Employee'
      DisplayWidth = 20
      FieldName = 'id_employee'
      Origin = 'id_employee'
    end
    object fdqryTelephonedescription: TStringField
      DisplayLabel = 'Description'
      DisplayWidth = 60
      FieldName = 'description'
      Origin = 'description'
      Required = True
      Size = 100
    end
    object fdqryTelephonetelephone: TStringField
      DisplayLabel = 'Telephone'
      DisplayWidth = 30
      FieldName = 'telephone'
      Origin = 'telephone'
      EditMask = '!\(99\)000-0000;1;_'
      Size = 15
    end
  end
  object dsTelephone: TDataSource
    DataSet = fdqryTelephone
    Left = 128
    Top = 128
  end
  object fdqryRemuneration: TFDQuery
    Connection = conConnection
    SQL.Strings = (
      'select * from remuneration')
    Left = 224
    Top = 72
    object fdqryRemunerationid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object fdqryRemunerationvalue: TFloatField
      FieldName = 'value'
      Origin = 'value'
      Required = True
    end
  end
end
