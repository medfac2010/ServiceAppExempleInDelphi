object Service1: TService1
  OldCreateOrder = False
  DisplayName = 'Service2'
  OnExecute = ServiceExecute
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 375
  Width = 520
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 24
    Top = 32
  end
  object IdTCPServer1: TIdTCPServer
    Bindings = <>
    DefaultPort = 0
    Left = 72
    Top = 32
  end
  object IdChargenServer1: TIdChargenServer
    Bindings = <>
    Left = 152
    Top = 32
  end
  object IdIPMCastServer1: TIdIPMCastServer
    BoundPort = 0
    MulticastGroup = '224.0.0.1'
    Port = 0
    Left = 384
    Top = 56
  end
  object IdDICTServer1: TIdDICTServer
    Bindings = <>
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Disconnect = False
        Name = 'TIdCommandHandler0'
        NormalReply.Code = '200'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
      end>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Greeting.Code = '200'
    Greeting.Text.Strings = (
      'Welcome')
    HelpReply.Code = '100'
    HelpReply.Text.Strings = (
      'Help follows')
    MaxConnectionReply.Code = '300'
    MaxConnectionReply.Text.Strings = (
      'Too many connections. Try again later.')
    ReplyTexts = <>
    ReplyUnknownCommand.Code = '400'
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    Left = 296
    Top = 64
  end
  object IdDISCARDServer1: TIdDISCARDServer
    Bindings = <>
    Left = 296
    Top = 136
  end
  object IdDNSServer1: TIdDNSServer
    Active = False
    Bindings = <>
    TCPACLActive = False
    ServerType = stPrimary
    Left = 288
    Top = 200
  end
  object IdECHOServer1: TIdECHOServer
    Bindings = <>
    Left = 288
    Top = 264
  end
  object IdIdentServer1: TIdIdentServer
    Bindings = <>
    Left = 280
    Top = 320
  end
  object IdIOHandlerStream1: TIdIOHandlerStream
    MaxLineAction = maException
    Port = 0
    FreeStreams = False
    Left = 48
    Top = 200
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 40
    Top = 256
  end
  object IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 56
    Top = 160
  end
  object IdSchedulerOfThreadPool1: TIdSchedulerOfThreadPool
    MaxThreads = 0
    Left = 416
    Top = 264
  end
  object IdSchedulerOfThreadDefault1: TIdSchedulerOfThreadDefault
    MaxThreads = 0
    Left = 448
    Top = 192
  end
  object IdIPWatch1: TIdIPWatch
    Active = True
    HistoryFilename = 'iphist.dat'
    Left = 376
    Top = 16
  end
  object IdNetworkCalculator1: TIdNetworkCalculator
    NetworkAddress.AsString = '225.225.0.0'
    NetworkMask.AsString = '255.255.255.255'
    Left = 400
    Top = 136
  end
  object IdUserManager1: TIdUserManager
    Accounts = <
      item
      end>
    Options = []
    Left = 184
    Top = 112
  end
  object IdIPAddrMon1: TIdIPAddrMon
    Active = True
    Interval = 1
    Left = 296
    Top = 16
  end
  object IdTraceRoute1: TIdTraceRoute
    ReceiveTimeout = 5000
    Protocol = 1
    ProtocolIPv6 = 58
    IPVersion = Id_IPv4
    ResolveHostNames = False
    Left = 120
    Top = 16
  end
end
