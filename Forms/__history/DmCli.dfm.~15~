object DmCadCli: TDmCadCli
  Height = 480
  Width = 640
  object fdCadClientes: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\ViniciusAbreudeOlive\Desktop\Prova Delphi\DB_P' +
        'ROVA.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 200
    Top = 192
  end
  object queryClientes: TFDQuery
    Active = True
    Connection = fdCadClientes
    UpdateOptions.AssignedValues = [uvFetchGeneratorsPoint, uvGeneratorName]
    UpdateOptions.FetchGeneratorsPoint = gpImmediate
    UpdateOptions.GeneratorName = 'GEN_USUARIOS_ID'
    SQL.Strings = (
      'Select * from usuarios')
    Left = 288
    Top = 192
    object queryClientesID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object queryClientesNOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 80
    end
    object queryClientesTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
    end
    object queryClientesLOGRADOURO: TStringField
      FieldName = 'LOGRADOURO'
      Origin = 'LOGRADOURO'
      Size = 100
    end
    object queryClientesSEXO: TStringField
      FieldName = 'SEXO'
      Origin = 'SEXO'
      FixedChar = True
      Size = 2
    end
  end
end
