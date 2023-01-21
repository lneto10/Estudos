#include 'TOTVS.CH'
#include 'RESTFUL.CH' //Include utilizada para construção do WEBSERVICE 
#Include 'Topconn.ch'
#Include 'Protheus.ch'

/*
WEBSERVICE responsavel por manipular os produtos da SB1 através dos verbos: GET, POST, PUT, DELETE. 
@AUTHOR: Luiz Neto
@SINCE: 16/01/2023
*/

//Inicia a criacao do servico REST
WSRESTFUL WSRESTPROD DESCRIPTION "Servico REST para manipulacao de produtos"

//Parametro utilizado para busca do produto e para exclusão via método delete

WSDATA CODPRODUTO AS STRING

//Inicia a criacao dos metodos que o Webservice terá 
WSMETHOD GET    buscarproduto    DESCRIPTION "Retorna dados do Produto" WSSYNTAX "/buscarproduto"       PATH "buscarproduto"    PRODUCES APLICATION_JSON
WSMETHOD POST   inserirproduto   DESCRIPTION "Inserir dados do Produto" WSSYNTAX "/inserirproduto"      PATH "inserirproduto"   PRODUCES APLICATION_JSON
WSMETHOD PUT    atualizarproduto DESCRIPTION "Alterar dados do Produto" WSSYNTAX "/atualizarproduto"    PATH "atualizarproduto" PRODUCES APLICATION_JSON
WSMETHOD DELETE deletarproduto   DESCRIPTION "Deleta dados do Produto"  WSSYNTAX "/deletarproduto"      PATH "deletarproduto"   PRODUCES APLICATION_JSON



ENDWSRESTFUL 


// Construcao de metodo para trazer dados da tabela SB1/PRODUTOS 

WSMETHOD GET buscarproduto WSRECEIVE CODPRODUTO WSREST WSRESTPROD // Parametro de busca dos dados 
Local lRet := .T.

//Recupera o produto que está sendo utilizado na URL/PARAMETRO 
Local cCodProd := Self:CODPRODUTO
Local aArea := GetArea()

Local aProd := {}

Local oJson := jsonObject():New() // Instanciando a classe jSonObject 
Local cJson := ""

Local oReturn //Caso o produto não seja encontado, retorna mensagem de erro
Local cReturn 
Local cStatus := ""
Local cGrupo  := ""

//Realizar a busca de dados

    DbSelectArea("SB1")
    SB1->(DBSetOrder(1))
    IF SB1->(DBSeek(xFilial("SB1")+cCodProd))
        cStatus := IIF(SB1->B1_MSBLQL == "1","Bloqueado","Desbloqueado")
        cGrupo  := Posicione("SBM",1,xFilial("SBM")+SB1->B1_GRUPO,"BM_DESC")

        aAdd(aProd, JsonObject():New())
        aProd[1]['prodcod']     := AllTrim(SB1->B1_COD)
        aProd[1]['proddesc']    := AllTrim(SB1->B1_DESC)
        aProd[1]['produm']      := AllTrim(SB1->B1_UM)
        aProd[1]['prodtipo']    := AllTrim(SB1->B1_TIPO)
        aProd[1]['prodncm']     := AllTrim(SB1->B1_POSIPI)
        aProd[1]['prodgrupo']   := AllTrim(cGrupo)
        aProd[1]['prodstatus']  := AllTrim(cStatus)

        oReturn := JsonObject():New()
        oReturn ['prodcod']     := cCodProd
        oReturn['cRet']         := "200"
        oReturn ['cMessage']    := "Produto encontrado com sucesso"
        cReturn := FwJsonSerialize(oReturn)

        oJson["produtos"] := aProd

        //Realizacao da Serializacao do jSon. Transforma o retorno dos itens em jSon
        cJson := FwJsonSerialize(oJson)
        ::SetResponse(cJson)
        ::SetResponse(cReturn)
    else
        SetRestFault(400,"Codigo do produto não encontrado!")
        lRet := .F.
        Return (lRet)

    ENDIF
    SB1->(DbCloseArea())
    
    FreeObj(ojSon)
    FreeObj(oReturn)
    



RestArea(aArea)

RETURN (lRet)

// Construcao do metodo POST - Inserir Produto 

WSMETHOD POST inserirproduto WSRECEIVE WSREST WSRESTPROD
    Local lRet := .T. 

    Local aArea := GetArea()

    //Instancia a classe Json Object
    Local oJson := JsonObject():New() 


    Local oReturn 

    //Carrega os dados vindos do Body da requisicao que estará em Json
    oJson:FromJson(Self:GetContent()) //GetContent - Pega o conteúdo do Json

    IF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodcod")))
        SetRestFault(400,"Codigo do produto está em branco")
        lRet := .F.
        Return (lRet)
    ELSE
    DbSelectArea("SB1")
    SB1->(DBSetOrder(1))
    //Verificar se já existe o código que está sendo inserido 
        IF SB1->(DBSeek(xFilial("SB1")+AllTrim(oJson["produtos"]:GetJsonObject("prodcod")))) // Busca pelo codigo do produto informado no Json
            SetRestFault(400,"Codigo do produto já existe")
            lRet := .F.
            Return (lRet)
        
        ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodesc")))
            SetRestFault(402,"Descricao do produto está em branco")
            lRet := .F.
            Return (lRet)
        ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("produm")))
            SetRestFault(403,"Unidade de medida do produto está em branco")
            lRet := .F.
            Return (lRet)
        ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo")))
            SetRestFault(404,"Codigo do produto está em branco")
            lRet := .F.
            Return (lRet)
        ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodtipo")))
            SetRestFault(405,"Codigo do tipo está em branco")
            lRet := .F.
            Return (lRet)
        ELSEIF !SBM->(DbSeek(xFilial("SBM")+AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo"))))
            SetRestFault(407,"Grupo de produto não existe")
            lRet := .F.
            Return (lRet)
        ELSE 
            RecLock("SB1",.T.)
                SB1->B1_COD     := AllTrim(oJson["produtos"]:GetJsonObject("prodcod"))
                SB1->B1_DESC    := AllTrim(oJson["produtos"]:GetJsonObject("prodesc"))
                SB1->B1_TIPO    := AllTrim(oJson["produtos"]:GetJsonObject("prodtipo"))
                SB1->B1_UM      := AllTrim(oJson["produtos"]:GetJsonObject("produm"))
                SB1->B1_GRUPO   := AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo"))
                SB1->B1_MSBLQL  := "1"
            SB1->(MsUnlock())

            SB1->(DbCloseArea())

            oReturn := JSonObject():New()
            oReturn ["prodcod"] := oJson["produtos"]:GetJsonObject("prodcod")
            oReturn ['prodesc'] := oJson["produtos"]:GetJsonObject("prodesc")
            oReturn ["cRet"]    := "201 - Sucesso"
            oReturn["cMessage"]:= "Registro incluido com sucesso no banco de dados. "

            Self:SetStatus(201)
            Self:SetContentType(APPLICATION_JSON)
            Self:SetResponse(FwJsonSerialize(oReturn)) // Serializa o objeto oReturn para JSON e retorno para o usuario
        ENDIF
    ENDIF



    RestArea(aArea)
    FreeObj(oJson)
    FreeObj(oReturn)
Return lRet

//Construcao do Metodo PUT = Alterar produto
WSMETHOD PUT atualizarproduto WSRECEIVE WSREST WSRESTPROD
    Local lRet := .T. 

    Local aArea := GetArea()

    //Instancia a classe Json Object
    Local oJson := JsonObject():New() 


    Local oReturn 

    //Carrega os dados vindos do Body da requisicao que estará em Json
    oJson:FromJson(Self:GetContent()) //GetContent - Pega o conteúdo do Json

    IF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodcod")))
        SetRestFault(400,"Codigo do produto está em branco")
        lRet := .F.
        Return (lRet)
    ELSE

        DbSelectArea("SB1")
        SB1->(DBSetOrder(1))
        //Verificar se já existe o código que está sendo inserido 
            IF SB1->(DBSeek(xFilial("SB1")+AllTrim(oJson["produtos"]:GetJsonObject("prodcod")))) // Busca pelo codigo do produto informado no Json
                
                IF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodesc")))
                    SetRestFault(402,"Descricao do produto está em branco")
                    lRet := .F.
                    Return (lRet)
                ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("produm")))
                    SetRestFault(403,"Unidade de medida do produto está em branco")
                    lRet := .F.
                    Return (lRet)
                ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo")))
                    SetRestFault(404,"Codigo do produto está em branco")
                    lRet := .F.
                    Return (lRet)
                ELSEIF Empty(AllTrim(oJson["produtos"]:GetJsonObject("prodtipo")))
                    SetRestFault(405,"Codigo do tipo está em branco")
                    lRet := .F.
                    Return (lRet)
                ELSEIF !SBM->(DbSeek(xFilial("SBM")+AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo"))))
                    SetRestFault(407,"Grupo de produto não existe")
                    lRet := .F.
                    Return (lRet)
                ELSE 
                RecLock("SB1",.F.)
                    SB1->B1_COD     := AllTrim(oJson["produtos"]:GetJsonObject("prodcod"))
                    SB1->B1_DESC    := AllTrim(oJson["produtos"]:GetJsonObject("prodesc"))
                    SB1->B1_TIPO    := AllTrim(oJson["produtos"]:GetJsonObject("prodtipo"))
                    SB1->B1_UM      := AllTrim(oJson["produtos"]:GetJsonObject("produm"))
                    SB1->B1_GRUPO   := AllTrim(oJson["produtos"]:GetJsonObject("prodgrupo"))
                    SB1->B1_MSBLQL  := "1"
                SB1->(MsUnlock())

                SB1->(DbCloseArea())

                oReturn := JSonObject():New()
                oReturn ["prodcod"] := oJson["produtos"]:GetJsonObject("prodcod")
                oReturn ['prodesc'] := oJson["produtos"]:GetJsonObject("prodesc")
                oReturn ["cRet"]    := "201 - Sucesso"
                oReturn["cMessage"]:= "Registro atualizado com sucesso no banco de dados. "

                Self:SetStatus(201)
                Self:SetContentType(APPLICATION_JSON)
                Self:SetResponse(FwJsonSerialize(oReturn)) // Serializa o objeto oReturn para JSON e retorno para o usuario
            ENDIF
        ELSE
            SetRestFault(408,"Codigo do produto nao existe")
            lRet := .F.
            Return (lRet)
        ENDIF
    ENDIF




    RestArea(aArea)
    FreeObj(oJson)
    FreeObj(oReturn)
Return lRet

//Construindo o metodo DELETE do Webservice 

WSMETHOD DELETE deletarproduto WSRECEIVE CODPRODUTO WSREST WSRESTPROD
    Local lRet := .T. 

    Local cCodProd  := Self:CODPRODUTO 
    lOCAL cDescProd := ""
    Local aArea     := GetArea()

    Local oJson     := JsonObject():New()
    Local oReturn   := JsonObject():New()

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1))
    IF !SB1->(DbSeek(xFilial("SB1")+cCodProd))
        SetRestFault(200,"Codigo do produto nao existe")
        lRet := .F.
        Return (lRet)
    ELSE
        cDescProd := SB1->B1_DESC
        RecLock("SB1",.F.)
            DbDelete()
        SB1->(MsUnlock())

        oReturn ["prodcod"] := cCodProd
        oReturn ['prodesc'] := cDescProd
        oReturn ["cRet"]    := "201 - Sucesso"
        oReturn["cMessage"]:= "Registro excluído com suscesso. "

        Self:SetStatus(201)
        Self:SetContentType(APPLICATION_JSON)
        Self:SetResponse(FwJsonSerialize(oReturn)) // Serializa o objeto oReturn para JSON e retorno para o usuario
    ENDIF

    
   
    SB1->(DbCloseArea())
    RestArea(aArea)
    FreeObj(oJson)
    FreeObj(oReturn)


Return lRet
