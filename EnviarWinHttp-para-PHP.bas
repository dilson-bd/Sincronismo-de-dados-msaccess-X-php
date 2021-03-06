Attribute VB_Name = "mod_WEB_Enviar_Dados"
Option Compare Database
'dim qURL as String    'GLOBAL

Public Function defineURL()
NOME_PROGRAMA = "rslocal"
qURL = "http://www.regsaude.com.br"
'qURL = "http://localhost"
End Function

Public Function WebEnviarPaciente(argEstacao As String, argCodWeb As Long, argCTLrelacaoA_p As String, _
                                  argCodPaciente As Long, argRG As String, argPaciente As String, _
                                  argOrgEmissor As String, argCPF As String, argCNS As String, _
                                  argSexo As String, argDataDeNasc As String, argNomeDoPai As String, _
                                  argNomeDaMae As String, argNomeDoResponsavel As String, argNaturalidade As String, _
                                  argEstadoCivil As String, argEndereco As String, argNr As String, _
                                  argCep As String, argTelPrinc As String, argTelAlt As String, _
                                  argBairro As String, argMunicipioDeReside As String, argDataDoCad As String, argAlias As String)
Call defineURL
'Processa dados vindos dos objetos:
'-> FORM: FichaDoPaciente_Add
'-> FORM: FichaDoPaciente
On Error GoTo trataErro
    'var
      Dim qRetorno
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
              DoCmd.Hourglass (True)
              'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-a-pac.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & argEstacao & "" _
                                   & "&codweb_a_p=" & argCodWeb & "" _
                                   & "&ctl_relacao_a_p=" & argCTLrelacaoA_p & "" _
                                   & "&codpac=" & argCodPaciente & "" _
                                   & "&rg=" & argRG & "" _
                                   & "&pac=" & argPaciente & "" _
                                   & "&orgemissor=" & argOrgEmissor & "" _
                                   & "&cpf=" & argCPF & "" _
                                   & "&cns=" & argCNS & "" _
                                   & "&sexo=" & argSexo & "" _
                                   & "&nasc=" & argDataDeNasc & "" _
                                   & "&pai=" & argNomeDoPai & "" _
                                   & "&mae=" & argNomeDaMae & "" _
                                   & "&resp=" & argNomeDoResponsavel & "" _
                                   & "&naturalidade=" & argNaturalidade & "" _
                                   & "&estadocivil=" & argEstadoCivil & "" _
                                   & "&endereco=" & argEndereco & "" _
                                   & "&nr=" & argNr & "" _
                                   & "&cep=" & argCep & "" _
                                   & "&telprinc=" & argTelPrinc & "" _
                                   & "&telalt=" & argTelAlt & "&bairro=" & argBairro & "&municipio=" & argMunicipioDeReside & "" _
                                   & "&datacad=" & argDataDoCad & "&alias=" & argAlias, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              DoCmd.Hourglass (False)
              qRetorno = Nz(strResult)
              k = Split(qRetorno, ";")
             ' MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(1)) = True Then
                        'MsgBox "NOVO - Atualizarei salvando o codweb"
                         CurrentDb.Execute "UPDATE Paciente SET CodWeb_a=" & k(1) & ", SubirDepois_a=0 WHERE C�digoDoPaciente=" & argCodPaciente
                   ElseIf k(1) = "atualizado" Then
                        'MsgBox "J� EXISTE - Atualizarei salvando Zero em SubirDepois"
                         CurrentDb.Execute "UPDATE Paciente SET CodWeb_a=" & k(2) & ", SubirDepois_a=0 WHERE C�digoDoPaciente=" & argCodPaciente
                   End If
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function WebEnviarLancamento(argEstacao As String, argCodWeb As Long, argCTLrelacaoA_e As String, argCTLrelacaoB_p As String, _
                                    argC�digoDoLan�amento As Long, argDataDaTransa��o As String, argC�digoDoPaciente As Long, _
                                    argPaciente As String, argTipoDeProcedimento As String, argProcedimento As String, _
                                    argAndamento As String, argDataDaEntrada As String, _
                                    argLocalDoProcedimento As String, argSetor As String, argProfissionalSolicitante As String, _
                                    argDataDaSolic As String, argPrioridade As Integer, argM�s As String, argAno As String, argCodigoDoProced As String, argDescrCodProced As String, _
                                    argTipoLeito As String, argDescrLeito As String, argDetalhe As String, argRetorno_SN As String, argDataSolicRet As String, argPeriodoRetorno As String, _
                                    argDataMarcarRet As String, argMesRetorno As String, argCid10 As String, argDescricaoCID10 As String, argLocalArq As String, argAnota��es As String, _
                                    argProtSMSEnvioAg As String, argDataFechamento As String, argAlias As String)
Call defineURL
'Processa dados vindos dos objetos:
'-> FORM: FichaDeSolicitacao
On Error GoTo trataErro
    'var
      Dim qRetorno
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
              DoCmd.Hourglass (True)
              'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-b-lan.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & argEstacao & "" _
                                   & "&codweb_b_p=" & argCodWeb & "" _
                                   & "&ctl_relacao_a_e=" & argCTLrelacaoA_e & "" _
                                   & "&ctl_relacao_b_p=" & argCTLrelacaoB_p & "" _
                                   & "&codlanc=" & argC�digoDoLan�amento & "" _
                                   & "&dataproc=" & argDataDaTransa��o & "" _
                                   & "&codpac=" & argC�digoDoPaciente & "" _
                                   & "&pac=" & argPaciente & "" _
                                   & "&tipoproc=" & argTipoDeProcedimento & "" _
                                   & "&proc=" & argProcedimento & "" _
                                   & "&andamento=" & argAndamento & "" _
                                   & "&dataentrada=" & argDataDaEntrada & "" _
                                   & "&localproc=" & argLocalDoProcedimento & "" _
                                   & "&setor=" & argSetor & "" _
                                   & "&profsolic=" & argProfissionalSolicitante & "" _
                                   & "&datasolic=" & argDataDaSolic & "" _
                                   & "&prioridade=" & argPrioridade & "&mes=" & argM�s & "&ano=" & argAno & "" _
                                   & "&codproced=" & argCodigoDoProced & "&descproced=" & argDescrCodProced & "&tipoleito=" & argTipoLeito & "" _
                                   & "&descleito=" & argDescrLeito & "&detalhe=" & argDetalhe & "&retornosn=" & argRetorno_SN & "" _
                                   & "&datasolicret=" & argDataSolicRet & "&periodoret=" & argPeriodoRetorno & "&datamarcaret=" & argDataMarcarRet & "" _
                                   & "&mesret=" & argMesRetorno & "&cid=" & argCid10 & "&descid=" & argDescricaoCID10 & "" _
                                   & "&localarq=" & argLocalArq & "&anotacoes=" & argAnota��es & "&protsms=" & argProtSMSEnvioAg & "&fechamento=" & argDataFechamento & "&alias=" & argAlias, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              DoCmd.Hourglass (False)
              qRetorno = Nz(strResult)
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(1)) = True Then
                        'MsgBox "NOVO - Atualizarei salvando o codweb"
                         CurrentDb.Execute "UPDATE Lan�amentos SET CodWeb_b=" & k(1) & ", SubirDepois_b=0 WHERE C�digoDoLan�amento=" & argC�digoDoLan�amento
                   ElseIf k(1) = "atualizado" Then
                        'MsgBox "J� EXISTE - Atualizarei salvando Zero em SubirDepois"
                         CurrentDb.Execute "UPDATE Lan�amentos SET CodWeb_b=" & k(2) & ", SubirDepois_b=0 WHERE C�digoDoLan�amento=" & argC�digoDoLan�amento
                   End If
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function WebEnviarUser(argEstacao As String, argCTLrelacaoA_p As String, _
                                  argIdUsuario As Long, argNome As String, argEmail As String, _
                                  argSenha As String, argAlias As String)
Call defineURL
'Processa dados vindos dos objetos:
'-> FORM: FUsuariosDoSistema_Add
'-> FORM: FUsuariosDoSistema_Edit
On Error GoTo trataErro
    'var
      Dim qRetorno
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
              DoCmd.Hourglass (True)
              'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-a-user.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & argEstacao & "" _
                                   & "&ctl_relacao_a_p=" & argCTLrelacaoA_p & "" _
                                   & "&idusuario=" & argIdUsuario & "" _
                                   & "&nome=" & argNome & "" _
                                   & "&email=" & argEmail & "" _
                                   & "&senha=" & argSenha & "&alias=" & argAlias, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              DoCmd.Hourglass (False)
              qRetorno = Nz(strResult)
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(1)) = True Then
                        'MsgBox "NOVO - Atualizarei salvando o codweb"
                         CurrentDb.Execute "UPDATE tblUsu�rios SET CodWeb_a=" & k(1) & ", SubirDepois_a=0 WHERE IdUsuario=" & argIdUsuario
                   ElseIf k(1) = "atualizado" Then
                        'MsgBox "J� EXISTE - Atualizarei salvando Zero em SubirDepois"
                         CurrentDb.Execute "UPDATE tblUsu�rios SET CodWeb_a=" & k(2) & ", SubirDepois_a=0 WHERE IdUsuario=" & argIdUsuario
                   End If
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function WebLoopEnviarPac()
'Processa dados vindos por loop:
'-> RECORDSET: rS
On Error GoTo trataErro
Call qAlias
Call defineURL
      Dim qRetorno
      Dim qChavePrimaria As Long
      Dim rs As DAO.Recordset
      Dim stSQL As String
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
     'stSQL = "SELECT TOP 50, * FROM Paciente "
     stSQL = "SELECT * FROM Paciente " _
            & "WHERE " _
            & "(((SubirDepois_a)=-1));"
      Set rs = CurrentDb.OpenRecordset(stSQL)
   If rs.RecordCount > 0 Then
   '1<<
         rs.MoveLast
         rs.MoveFirst
         Do While Not rs.EOF
            qChavePrimaria = rs("C�digoDoPaciente")
             DoCmd.Hourglass (True)
             'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-a-pac.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & Nz(rs!IDEstacao) & "" _
                                   & "&codweb_a_p=" & Nz(rs!CodWeb_a) & "" _
                                   & "&ctl_relacao_a_p=" & Nz(rs!CTLrelacaoA_p) & "" _
                                   & "&codpac=" & Nz(rs!C�digoDoPaciente) & "" _
                                   & "&rg=" & Nz(rs!RG) & "" _
                                   & "&pac=" & Nz(rs!Paciente) & "" _
                                   & "&orgemissor=" & Nz(rs!OrgEmissor) & "" _
                                   & "&cpf=" & Nz(rs!CPF) & "" _
                                   & "&cns=" & Nz(rs!CNS) & "" _
                                   & "&sexo=" & Nz(rs!Sexo) & "" _
                                   & "&nasc=" & Nz(Format(rs!DataDeNasc, "yyyy/mm/dd")) & "" _
                                   & "&pai=" & Nz(rs!NomeDoPai) & "" _
                                   & "&mae=" & Nz(rs!NomeDaMae) & "" _
                                   & "&resp=" & Nz(rs!NomeDoRespons�vel) & "" _
                                   & "&naturalidade=" & Nz(rs!Naturalidade) & "" _
                                   & "&estadocivil=" & Nz(rs!EstadoCivil) & "" _
                                   & "&endereco=" & Nz(rs!Endere�o) & "" _
                                   & "&nr=" & Nz(rs!N�) & "" _
                                   & "&cep=" & Nz(rs!Cep) & "" _
                                   & "&telprinc=" & Nz(rs!TelPrinc) & "" _
                                   & "&telalt=" & Nz(rs!TelAlt) & "&bairro=" & Nz(rs!Bairro) & "&municipio=" & Nz(rs!Munic�pioDeReside) & "" _
                                   & "&datacad=" & Nz(Format(rs!DataDoCad, "yyyy/mm/dd")) & "&alias=" & Nz(qualAlias), False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              qRetorno = Nz(strResult)
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(1)) = True Then
                   Forms!FCProcessos!rotProgresso.Caption = "Inserindo Paciente CodWeb " & k(1)
                          'MsgBox "NOVO - Atualizarei salvando o codweb"
                          CurrentDb.Execute "UPDATE Paciente SET CodWeb_a=" & k(1) & ", SubirDepois_a=0 WHERE C�digoDoPaciente=" & qChavePrimaria
                   ElseIf k(1) = "atualizado" Then
                   Forms!FCProcessos!rotProgresso.Caption = "Atualizando Paciente CodWeb " & k(2)
                          'MsgBox "J� EXISTE - Atualizarei salvando Zero em SubirDepois"
                          CurrentDb.Execute "UPDATE Paciente SET CodWeb_a=" & k(2) & ", SubirDepois_a=0 WHERE C�digoDoPaciente=" & qChavePrimaria
                   End If
              rs.MoveNext
              Loop
              DoCmd.Hourglass (False)
   '1>>
   End If
   rs.Close
   Set rs = Nothing
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function WebLoopEnviarLanc()
'Processa dados vindos por loop:
'-> RECORDSET: rS
On Error GoTo trataErro
Call qAlias
Call defineURL
      Dim qRetorno
      Dim qChavePrimaria As Long
      Dim rs As DAO.Recordset
      Dim stSQL As String
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
     'stSQL = "SELECT TOP 1000, * FROM Lan�amentos "
     stSQL = "SELECT * FROM Lan�amentos " _
            & "WHERE " _
            & "(((SubirDepois_b)=-1));"
      Set rs = CurrentDb.OpenRecordset(stSQL)
   If rs.RecordCount > 0 Then
   '1<<
         rs.MoveLast
         rs.MoveFirst
         Do While Not rs.EOF
         qChavePrimaria = rs("C�digoDoLan�amento")
         'MsgBox qChavePrimaria
              DoCmd.Hourglass (True)
             'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
                            WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-b-lan.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & Nz(rs!IDEstacao) & "" _
                                   & "&codweb_b_p=" & Nz(rs!CodWeb_b) & "" _
                                   & "&ctl_relacao_a_e=" & Nz(rs!CTLrelacaoA_e) & "" _
                                   & "&ctl_relacao_b_p=" & Nz(rs!CTLrelacaoB_p) & "" _
                                   & "&codlanc=" & Nz(rs!C�digoDoLan�amento) & "" _
                                   & "&dataproc=" & Nz(Format(rs!DataDaTransa��o, "yyyy/mm/dd")) & "" _
                                   & "&codpac=" & Nz(rs!C�digoDoPaciente) & "" _
                                   & "&pac=" & Nz(rs!Redund_Paciente) & "" _
                                   & "&tipoproc=" & Nz(rs!TipoDeProcedimento) & "" _
                                   & "&proc=" & Nz(rs!Procedimento) & "" _
                                   & "&andamento=" & Nz(rs!Andamento) & "" _
                                   & "&dataentrada=" & Nz(Format(rs!DataDaEntrada, "yyyy/mm/dd")) & "" _
                                   & "&localproc=" & Nz(rs!LocalDoProcedimento) & "" _
                                   & "&setor=" & Nz(rs!Setor) & "" _
                                   & "&profsolic=" & Nz(rs!ProfissionalSolicitante) & "" _
                                   & "&datasolic=" & Nz(Format(rs!DataDaSolic, "yyyy/mm/dd")) & "" _
                                   & "&prioridade=" & Nz(rs!Prioridade) & "&mes=" & Nz(rs!M�s) & "&ano=" & Nz(rs!Ano) & "" _
                                   & "&codproced=" & Nz(rs!CodigoDoProced) & "&descproced=" & Nz(rs!DescrCodProced) & "&tipoleito=" & Nz(rs!TipoLeito) & "" _
                                   & "&descleito=" & Nz(rs!DescrLeito) & "&detalhe=" & Nz(rs!Detalhe) & "&retornosn=" & Nz(rs!Retorno_SN) & "" _
                                   & "&datasolicret=" & Nz(Format(rs!DataSolicRet, "yyyy/mm/dd")) & "&periodoret=" & Nz(rs!PeriodoRetorno) & "&datamarcaret=" & Nz(Format(rs!DataMarcarRet, "yyyy/mm/dd")) & "" _
                                   & "&mesret=" & Nz(rs!MesRetorno) & "&cid=" & Nz(rs!Cid10) & "&descid=" & Nz(rs!DescricaoCid10) & "" _
                                   & "&localarq=" & Nz(rs!Redund_Local) & "&anotacoes=" & Nz(rs!Anota��es) & "&protsms=" & Nz(rs!ProtSMSEnvioAg) & "&fechamento=" & Nz(Format(rs!DataFechamento, "yyyy/mm/dd")) & "&alias=" & Nz(qualAlias), False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              qRetorno = Nz(strResult)
              'MsgBox qRetorno
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1) & " - " & k(2)

                   If IsNumeric(k(1)) = True Then
                   Forms!FCProcessos!rotProgresso.Caption = "Inserindo Lan�amento CodWeb " & k(1)
                          'MsgBox "Atualizarei salvando o codweb"
                          CurrentDb.Execute "UPDATE Lan�amentos SET CodWeb_b=" & k(1) & ", SubirDepois_b=0 WHERE C�digoDoLan�amento=" & qChavePrimaria
                   ElseIf k(1) = "atualizado" Then
                   Forms!FCProcessos!rotProgresso.Caption = "Atualizando Lan�amento CodWeb " & k(2)
                          'MsgBox "Atualizarei salvando Zero em SubirDepois"
                          CurrentDb.Execute "UPDATE Lan�amentos SET CodWeb_b=" & k(2) & ", SubirDepois_b=0 WHERE C�digoDoLan�amento=" & qChavePrimaria
                   End If
              rs.MoveNext
              Loop
              DoCmd.Hourglass (False)
   '1>>
   End If
   rs.Close
   Set rs = Nothing
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function WebLoopEnviarUser()
'Processa dados vindos por loop:
'-> RECORDSET: rS
On Error GoTo trataErro
Call qAlias
Call defineURL
      Dim qRetorno
      Dim qChavePrimaria As Long
      Dim rs As DAO.Recordset
      Dim stSQL As String
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
     stSQL = "SELECT * FROM tblUsu�rios " _
            & "WHERE " _
            & "(((SubirDepois_a)=-1));"
      Set rs = CurrentDb.OpenRecordset(stSQL)
   If rs.RecordCount > 0 Then
   '1<<
         rs.MoveLast
         rs.MoveFirst
         Do While Not rs.EOF
            qChavePrimaria = rs("IdUsuario")
             DoCmd.Hourglass (True)
             'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-envia-a-user.php" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & Nz(rs!IDEstacao) & "" _
                                   & "&codweb_a_p=" & Nz(rs!CodWeb_a) & "" _
                                   & "&ctl_relacao_a_p=" & Nz(rs!CTLrelacaoA_p) & "" _
                                   & "&idusuario=" & Nz(rs!IdUsuario) & "" _
                                   & "&nome=" & Nz(rs!Usuario) & "" _
                                   & "&email=" & Nz(rs!email) & "" _
                                   & "&senha=" & Nz(rs!Senha) & "&alias=" & Nz(qualAlias), False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              qRetorno = Nz(strResult)
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(1)) = True Then
                          'MsgBox "NOVO - Atualizarei salvando o codweb"
                          CurrentDb.Execute "UPDATE tblUsu�rios SET CodWeb_a=" & k(1) & ", SubirDepois_a=0 WHERE IdUsuario=" & qChavePrimaria
                   ElseIf k(1) = "atualizado" Then
                          'MsgBox "J� EXISTE - Atualizarei salvando Zero em SubirDepois"
                          CurrentDb.Execute "UPDATE tblUsu�rios SET CodWeb_a=" & k(2) & ", SubirDepois_a=0 WHERE IdUsuario=" & qChavePrimaria
                   End If
              rs.MoveNext
              Loop
              DoCmd.Hourglass (False)
   '1>>
   End If
   rs.Close
   Set rs = Nothing
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Function WebLoopDelete(argTabela As String, argCodWeb As String, argPagePHP As String, argAlias As String)
'Processa dados vindos dos objetos:
'-> FORM: FrmGer_CadFam;
On Error GoTo trataErro
Call defineURL
      Dim qRetorno
      Dim qChavePrimaria As Long
      Dim rs As DAO.Recordset
      Dim stSQL As String
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
      stSQL = "SELECT * FROM " & argTabela & " " _
            & "WHERE " _
            & "(((ExcluirOnline)=-1) AND (Not (" & argCodWeb & ") Is Null));"
      Set rs = CurrentDb.OpenRecordset(stSQL)
   If rs.RecordCount > 0 Then
   '1<<
         rs.MoveLast
         rs.MoveFirst
         Do While Not rs.EOF
         qChavePrimaria = rs("" & argCodWeb & "")
              DoCmd.Hourglass (True)
             'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/" & argPagePHP & "" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & Nz(rs("IDEstacao")) & "" _
                                   & "&codweb=" & Nz(rs("" & argCodWeb & "")) & "&alias=" & argAlias, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              qRetorno = Nz(strResult)
              'MsgBox qRetorno
              k = Split(qRetorno, ";")
              'MsgBox k(0) & " - " & k(1)
                   If k(1) = "Excluido" Then
                      'MsgBox "Excluido"
                           CurrentDb.Execute "UPDATE " & argTabela & " SET ExcluirOnline=0 WHERE " & argCodWeb & "=" & qChavePrimaria
                   End If
         rs.MoveNext
         Loop
         DoCmd.Hourglass (False)
   '1>>
   End If
rs.Close
Set rs = Nothing
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Function WebLoopQuantOff(argTabela As String, argPagePHP As String)
'Processa dados vindos dos objetos:
'-> FORM: FrmGer_CadFam;
On Error GoTo trataErro
Call qAlias
Call defineURL
      Dim rs As DAO.Recordset
      Dim stSQL As String
      Dim QuantOff As Long
      Dim qEstacao As String
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Dim lngTimeout
      lngTimeout = 10000   '10 segundos
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
      stSQL = "SELECT * FROM " & argTabela & ""
      Set rs = CurrentDb.OpenRecordset(stSQL)
      
   If rs.RecordCount > 0 Then
   '1<<
              qEstacao = fncChaveHD(8)
              rs.MoveLast
              rs.MoveFirst
              QuantOff = rs.RecordCount
              DoCmd.Hourglass (True)
             'Definir 10 segundos time-outs. Se os tempos limite estiverem definidos, eles devem
              'ser definida antes de abrir.
              WinHttpReq.SetTimeouts lngTimeout, lngTimeout, lngTimeout, lngTimeout
             '----------------------------------------------- winhttp 2 de 2
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/" & argPagePHP & "" _
                                   & "?form_access=centraldados" _
                                   & "&estacao=" & Nz(qEstacao) & "" _
                                   & "&quant=" & Nz(QuantOff) & "&alias=" & qualAlias, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
         DoCmd.Hourglass (False)
   '1>>
   End If
rs.Close
Set rs = Nothing
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Public Function remarcarSubirDepois(argTabela As String, argCodWeb As String, argSubirDepois As String)
'Serve unicamente a Public Function WebLoopEnviarRegistros()
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'OBJETIVO: Marcar SubirDepois em registros que est�o com o CodWeb_(letra) vazio e SubirDepois = 0 como se o registro
'tivesse subido para o servidor online. Essa medida vai marcar novamente o registro para subir depois:
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'INICIO
Dim msdRS As DAO.Recordset
Dim msdSQL As String
msdSQL = "SELECT * FROM " & argTabela & " " _
       & "WHERE " _
       & "(((" & argCodWeb & ") Is Null) " _
       & "AND ((" & argSubirDepois & ")=0));"
Set msdRS = CurrentDb.OpenRecordset(msdSQL)
If msdRS.RecordCount > 0 Then
msdRS.MoveLast
msdRS.MoveFirst
Do While Not msdRS.EOF
msdRS.Edit
msdRS("" & argSubirDepois & "") = -1
msdRS.Update
msdRS.MoveNext
Loop
End If
msdRS.Close
Set msdRS = Nothing
'FIM
End Function

Function WebValidarAlias(argBanco As String, argEstacao As String)
'Processa dados vindos dos objetos:
'-> FORM: frmAliasBD;
On Error GoTo trataErro
    'var
      Dim qRetorno
    '-------------------------------- winhttp 1 de 2
      Dim WinHttpReq As Object
      Dim strResult As String
      Set WinHttpReq = CreateObject("WinHttp.WinHttpRequest.5.1")
    '-------------------------------- Fim winhttp 1 de 2
              DoCmd.Hourglass (True)
             '----------------------------------------------- winhttp 2 de 2
             'Mensagem tem que ter no m�ximo 160 caracteres
              WinHttpReq.Open "GET", qURL _
                                   & "/accesscore/fnc-valida-alias.php" _
                                   & "?form_access=centraldados" _
                                   & "&banco=" & argBanco & "" _
                                   & "&estacao=" & argEstacao, False
              WinHttpReq.SetRequestHeader "Content-Type", "text/html; charset=UTF-8"
              WinHttpReq.Send
              WinHttpReq.WaitForResponse
              strResult = WinHttpReq.responseText
             '----------------------------------------------- Fim winhttp 2 de 2
              DoCmd.Hourglass (False)
              qRetorno = Nz(strResult)
              MsgBox qRetorno
              k = Split(qRetorno, ";")
              MsgBox k(0) & " - " & k(1) & " - " & k(2)
                   If IsNumeric(k(2)) = True Then
                      MsgBox "numeric"
                      If VerLinhaBD = True Then
                          MsgBox "Atualizarei salvando o nome do banco"
                           CurrentDb.Execute "UPDATE config_alias SET bdAlias='" & argBanco & "', NMbd='" & k(1) & "' "
                      Else
                           CurrentDb.Execute "INSERT INTO config_alias(bdAlias, NMbd) VALUES('" & argBanco & "', '" & k(1) & "')"
                      End If
                   End If
sair:
    Exit Function
trataErro:
    DoCmd.Hourglass (False)
    Resume sair
End Function

Private Function VerLinhaBD() As Boolean
'Serve unicamente a Public Function WebValidarAlias(argBanco As String, argEstacao As String)
Dim Nrs As DAO.Recordset
Dim nSQL As String
nSQL = "SELECT * FROM config_alias"
Set Nrs = CurrentDb.OpenRecordset(nSQL)
If Nrs.RecordCount > 0 Then
VerLinhaBD = True
Else
VerLinhaBD = False
End If
Nrs.Close
Set Nrs = Nothing
End Function

Public Function qAlias()
'///////////////////////////////////////////////////////////////////////////////////////
'C�digo para ir buscar os dados de envio sms na tabela configsms
Dim db As DAO.Database
Dim rsAlias As DAO.Recordset
Dim strAlias As String
strAlias = "SELECT * FROM config_alias"
Set db = CurrentDb
Set rsAlias = db.OpenRecordset(strAlias)
If Not rsAlias.BOF Then
qualAlias = rsAlias!bdAlias
Else
qualAlias = "nenhumaBase"
End If
rsAlias.Close
Set rsAlias = Nothing
db.Close
Set db = Nothing
'///////////////////////////////////////////////////////////////////////////////////////
End Function
