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
WSDATA CODLOJA       AS STRING

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

// Criando o método POST/Incluir Clientes 

WSMETHOD POST incluircliente WSRECEIVE WSREST WSRESTCLI

Local lRet      := .T.
Local aArea     := GetArea()
Local oJson     := JsonObject():New()
Local oReturn   := JsonObject():New()


oJson:FromJson(Self:GetContent())

//Verificar se o codigo e loja estão preenchidos

IF Empty(oJson["clientes"]:GetJsonObject("clicodigo")) .OR. Empty(oJson["clientes"]:GetJsonObject("cliloja"))

    SetRestFault(400,EncodeUtf8('Codigo ou loja do cliente estão em branco'))
    lRet := .F.
    Return (lRet)

ELSE 
    DbSelectArea("SA1")
    DbSetOrder(1)
    IF SA1->(DBSeek(xFilial("SA1")+oJson["clientes"]:GetJsonObject("clicodigo")+oJson["clientes"]:GetJsonObject("cliloja")))
        SetRestFault(401,EncodeUtf8('Codigo ou loja do cliente já existe'))
        lRet := .F.
        Return (lRet)
    ELSE
        RecLock("SA1",.T.)
            SA1->A1_COD     := oJSon["clientes"]:GetJsonObject("clicodigo")
            SA1->A1_LOJA    := oJSon["clientes"]:GetJsonObject("cliloja")
            SA1->A1_NOME    := oJSon["clientes"]:GetJsonObject("clinome")
            SA1->A1_NREDUZ  := oJSon["clientes"]:GetJsonObject("clinomereduz")
            SA1->A1_END     := oJSon["clientes"]:GetJsonObject("cliendereco")
            SA1->A1_EST     := oJSon["clientes"]:GetJsonObject("cliestado")
            SA1->A1_MUN     := oJSon["clientes"]:GetJsonObject("clicidade")
            SA1->A1_BAIRRO  := oJSon["clientes"]:GetJsonObject("clibairro")
            SA1->A1_CGC     := oJSon["clientes"]:GetJsonObject("clicgc")
            SA1->A1_MSBLQL  := "1"
        SA1->(MsUnlock())

        oReturn ["clicodigo"]   := oJSon["clientes"]:GetJsonObject("clicodigo")
        oReturn ['clinome']     := oJSon["clientes"]:GetJsonObject("clinome")
        oReturn ["cRet"]        := "201 - Sucesso"
        oReturn["cMessage"]     := EncodeUTF8("Registro incluído com suscesso. ")

        Self:SetStatus(201)
        Self:SetContentType(APPLICATION_JSON)
        Self:SetResponse(FwJsonSerialize(oReturn))
    ENDIF
SA1->(DbCloseArea())

        
ENDIF

RestArea(aArea)
Return lRet



//Criação do método put (alteração do cadastro do cliente)
WSMETHOD PUT alteracliente WSRECEIVE WSREST WSRESTCLI
Local lRet      := .T.
Local aArea     := GetArea()
Local oJson     := JsonObject():New()
Local oReturn   := JsonObject():New()


oJson:FromJson(Self:GetContent())

//Verificar se o codigo e loja estão preenchidos

IF Empty(oJson["clientes"]:GetJsonObject("clicodigo")) .OR. Empty(oJson["clientes"]:GetJsonObject("cliloja"))

    SetRestFault(400,EncodeUtf8('Codigo ou loja do cliente estão em branco'))
    lRet := .F.
    Return (lRet)

ELSE 
    DbSelectArea("SA1")
    DbSetOrder(1)
    IF !SA1->(DBSeek(xFilial("SA1")+oJson["clientes"]:GetJsonObject("clicodigo")+oJson["clientes"]:GetJsonObject("cliloja")))
        SetRestFault(401,EncodeUtf8('Codigo ou loja do cliente não encontrado'))
        lRet := .F.
        Return (lRet)
    ELSE
        RecLock("SA1",.F.)
            SA1->A1_COD     := oJSon["clientes"]:GetJsonObject("clicodigo")
            SA1->A1_LOJA    := oJSon["clientes"]:GetJsonObject("cliloja")
            SA1->A1_NOME    := oJSon["clientes"]:GetJsonObject("clinome")
            SA1->A1_NREDUZ  := oJSon["clientes"]:GetJsonObject("clinomereduz")
            SA1->A1_END     := oJSon["clientes"]:GetJsonObject("cliendereco")
            SA1->A1_EST     := oJSon["clientes"]:GetJsonObject("cliestado")
            SA1->A1_MUN     := oJSon["clientes"]:GetJsonObject("clicidade")
            SA1->A1_BAIRRO  := oJSon["clientes"]:GetJsonObject("clibairro")
            SA1->A1_CGC     := oJSon["clientes"]:GetJsonObject("clicgc")
            SA1->A1_MSBLQL  := "1"
        SA1->(MsUnlock())

        oReturn ["clicodigo"]   := oJSon["clientes"]:GetJsonObject("clicodigo")
        oReturn ['clinome']     := oJSon["clientes"]:GetJsonObject("clinome")
        oReturn ["cRet"]        := "201 - Sucesso"
        oReturn["cMessage"]     := EncodeUTF8("Registro alterado com suscesso. ")

        Self:SetStatus(201)
        Self:SetContentType(APPLICATION_JSON)
        Self:SetResponse(FwJsonSerialize(oReturn))
    ENDIF

SA1->(DbCloseArea())
ENDIF

Return lRet


//Criação do metodo de deletar cliente
WSMETHOD DELETE deletarcliente WSRECEIVE CODCLIENTEDE,CODLOJA WSREST WSRESTCLI 
    Local lRet := .T. 

    Local cCodDe    := Self:CODCLIENTEDE 
    Local cLoja     := Self:CODLOJA
    Local cCliente  := ""
    Local aArea     := GetArea()

    Local oJson     := JsonObject():New()
    Local oReturn   := JsonObject():New()



    DbSelectArea("SA1")
    SA1->(DbSetOrder(1))
    IF !SA1->(DbSeek(xFilial("SA1")+cCodDe+cLoja))
        SetRestFault(200,"Cliente nao localizado")
        lRet := .F.
        Return (lRet)
    ELSE
        cCliente := SA1->A1_NOME
        RecLock("SA1",.F.)
            DbDelete()
        SA1->(MsUnlock())

        oReturn ["codcli"]      := cCodDe
        oReturn ["nomecli"]     := cCliente
        oReturn ["cRet"]        := "201 - Sucesso"
        oReturn ["cMessage"]    := "Registro excluído com suscesso. "

        Self:SetStatus(201)
        Self:SetContentType(APPLICATION_JSON)
        Self:SetResponse(FwJsonSerialize(oReturn)) // Serializa o objeto oReturn para JSON e retorno para o usuario
    ENDIF

    
   
    SA1->(DbCloseArea())
    RestArea(aArea)
    FreeObj(oJson)
    FreeObj(oReturn)

Return lRet
