#include 'TOTVS.CH'
#include 'RESTFUL.CH' //Include utilizada para construção do WEBSERVICE 
#Include 'Topconn.ch'
#Include 'Protheus.ch'

/*
WEBSERVICE responsavel por manipular os produtos da SB1
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
    



RestArea(aAreA)

RETURN (lRet)
