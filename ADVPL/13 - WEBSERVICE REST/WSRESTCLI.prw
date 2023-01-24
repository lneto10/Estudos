#include 'Totvs.ch'
#include 'RESTFUL.CH'

/* WEBSERVICE de integracao do cadastro de clientes. Responsavel por retornar os dados, atualizar, inserir e deletar no cadastro. 
@author: Luiz Neto
@since: 23/01/2023 
Módulo 10: WebServicE REST - Projeto Integração Clientes - Sistematizei  */

WSRESTFUL WSRESTCLI DESCRIPTION "Serviço REST para integração de Clientes | SA1"

//Parametro de recebimento CLIENTE DE/CLIENTE ATE

WSDATA CODCLIENTEDE AS STRING
WSDATA CODCLIENTEATE AS STRING

//Declaracao dos metodos 

WSMETHOD GET buscarcliente      DESCRIPTION "Retorna dados do cliente"     WSSYNTAX "/buscarcliente"    PATH "buscarcliente"    PRODUCES APPLICATION_JSON 
WSMETHOD PUT alteracliente      DESCRIPTION "Altera dados do cliente"      WSSYNTAX "/alteracliente"    PATH "alteracliente"    PRODUCES APPLICATION_JSON 
WSMETHOD POST incluircliente    DESCRIPTION "Insere dados do cliente"      WSSYNTAX "/incluircliente"   PATH "incluircliente"   PRODUCES APPLICATION_JSON 
WSMETHOD DELETE deletarcliente  DESCRIPTION "Deleta dados do cliente"      WSSYNTAX "/deletarcliente"   PATH "deletarcliente"   PRODUCES APPLICATION_JSON 


ENDWSRESTFUL

//Criando método GET buscarcliente

WSMETHOD GET buscarcliente WSRECEIVE CODCLIENTEDE, CODCLIENTEATE WSREST WSRESTCLI

    Local lRet          := .T. 
    Local nCount        := 1 // Contador
    Local nRegistros    := 0
    Local cCodDe        := cValtoChar(Self:CODCLIENTEDE)
    Local cCodAte       := cValtoChar(Self:CODCLIENTEATE)
    Local aListClientes := {} // Array que recebe os dados dos clientes
    Local oJson         := JsonObject():New() //Objeto e String JSON para recebimento do array com Json 
    Local cJson         := ""
    Local cAlias        := GetNextAlias()
    Local cWhere        := ""


    //Verifico se o campo CLIENTEDE é maior do que CLIENTEATE

    IF Self:CODCLIENTEDE > SELF:CODCLIENTEATE

        cCodAte := cValtoChar(Self:CODCLIENTEDE)
        cCodDe  := cValtoChar(Self:CODCLIENTEATE)
    ENDIF


    cWhere  := "AND SA1.A1_COD BETWEEN '"+cCodDe+"' AND '"+cCodAte+"' AND SA1.A1_FILIAL = '01' "
    cWhere  := "%"+cWhere+"%" // Tratamento para tirar as aspas 

    BEGINSQL Alias cAlias
        SELECT SA1.A1_COD, SA1.A1_LOJA, SA1.A1_NOME, SA1.A1_NREDUZ, SA1.A1_END, SA1.A1_EST, SA1.A1_BAIRRO, SA1.A1_MUN, SA1.A1_CGC
        FROM %table:SA1% SA1 
        WHERE SA1.%notDel%
        %exp:cWhere%
    ENDSQL

    Count to nRegistros

    (cAlias)->(DbGoTop())


    While (cAlias)->(!Eof())
        aAdd(aListClientes,JsonObject():New())
            aListClientes[nCount]["clicodigo"]      := (cAlias)->A1_COD
            aListClientes[nCount]["cliloja"]        := (cAlias)->A1_LOJA
            aListClientes[nCount]["clinome"]        := AllTrim(EncodeUTF8((cAlias)->A1_NOME))
            aListClientes[nCount]["clinomereduz"]   := AllTrim(ENCODEUTF8((cAlias)->A1_NREDUZ))
            aListClientes[nCount]["cliendereco"]    := AllTrim(ENCODEUTF8((cAlias)->A1_END)) 
            aListClientes[nCount]["cliestado"]      := (cAlias)->A1_EST
            aListClientes[nCount]["clicidade"]      := AllTrim((cAlias)->A1_MUN)
            aListClientes[nCount]["clibairro"]      := AllTrim((cAlias)->A1_BAIRRO)
            aListClientes[nCount]["clicgc"]         := (cAlias)->A1_CGC
        nCount++
        (cAlias)->(DbSkip()) 
    ENDDO    

    (cAlias)->(DbCloseArea())

    IF nRegistros > 0
        oJson["Total de registros"] := nRegistros
        oJson["clientes"] := aListClientes

        cJson := FwJsonSerialize(oJson) // Serializa o Json e passa para a variavel texto

        ::SetResponse(cJson) // Retorna o Json para o usuario
    ELSE 
        SetRestFault(400,ENCODEUTF8("Não existem registros para os filtros informados! Verifique os parametros e tente novamente"))
        lRet := .F.
        Return lRet
    ENDIF

    FreeObj(oJson)
Return lRet

