object DM: TDM
  Height = 258
  Width = 226
  object Conexao: TFDConnection
    Params.Strings = (
      'Database=C:\MEU BOLSO\EXE\BANCO\MEU_BOLSO.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'CharacterSet=WIN1252'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 48
    Top = 16
  end
  object FDTransaction1: TFDTransaction
    Connection = Conexao
    Left = 48
    Top = 88
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 48
    Top = 160
  end
end
