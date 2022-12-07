#Include 'Protheus.ch'
#Include  'APWEBSRV.CH'
#Include 'TOPCONN.ch'

/* 
WebService para disponibilizar os dados do cadastro do produto da SB1
@author Luiz Neto
@since 24/11/2022
*/

//Estrutura de dados do produto
WSSTRUCT StProduto 
    WSDATA produtoB1COD     AS STRING OPTIONAL
    WSDATA produtoB1DESC    AS STRING OPTIONAL
    WSDATA produtoB1UM      AS STRING OPTIONAL
    WSDATA produtoB1TIPO    AS STRING OPTIONAL
    WSDATA produtoB1POSIPI  AS STRING OPTIONAL
    WSDATA produtoB1GRUPO   AS STRING OPTIONAL //Buscar da SBM 
ENDWSSTRUCT


//Estrutura de dados da quantidade e valor total de venda 
WSSTRUCT StProdVenda 

    WSDATA produtoCODIGO         AS STRING      OPTIONAL
    WSDATA produtoDESCRICAO      AS STRING      OPTIONAL
    WSDATA produtoQTDTOTAL       AS INTEGER     OPTIONAL
    WSDATA produtoVALORTOTAL     AS FLOAT       OPTIONAL

    WSDATA cRet                  AS STRING      OPTIONAL
    WSDATA cMessage              AS STRING      OPTIONAL
ENDWSSTRUCT

//Estrutura de dados para retorno de mensagem
WSSTRUCT StRetMsgProd
    WSDATA cRet         AS STRING OPTIONAL
    WSDATA cMessage     AS STRING OPTIONAL

ENDWSSTRUCT 

//Classe de dados para retorno geral, aqui será um intermediador entre as estruturas acima 
WSSTRUCT StRetGeralProd

    WSDATA WsBuscaProd AS StProduto
    WSDATA WsRetMsg    AS StRetMsgProd


ENDWSSTRUCT


WSSERVICE WSPRODSB1     DESCRIPTION "Serviço para retornar Dados de Produtos"

WSDATA _cCodProduto     AS STRING 

WSDATA WsRetornoGeral   AS StRetGeralProd

WSDATA WsBuscaProdVend  AS StProdVenda

//Método


WSMETHOD BuscaProduto DESCRIPTION "Busca os dados do Produto através do Código"

WSMETHOD BuscaProdVend DESCRIPTION "Busca quantidade de produtos vendidos"

ENDWSSERVICE


WSMETHOD BuscaProduto WSRECEIVE _cCodProduto WSSEND WSretornoGeral WSSERVICE WSPRODSB1

    Local cCodProduto := ::_cCodProduto

    DbSelectArea("SB1")
    SB1->(DbSetOrder(1))

    IF SB1->(DBSeek(xFilial("SB1")+cCodProduto))

        ::WsRetornoGeral:WsRetMsg:cRet     := "[T]"
        ::WsRetornoGeral:WsRetMsg:cMessage := "O produto foi encontrado"

        ::WsRetornoGeral:WsBuscaProd:produtoB1COD       := SB1->B1_COD
        ::WsRetornoGeral:WsBuscaProd:produtoB1DESC      := SB1->B1_DESC
        ::WsRetornoGeral:WsBuscaProd:produtoB1UM        := SB1->B1_UM
        ::WsRetornoGeral:WsBuscaProd:produtoB1TIPO      := SB1->B1_TIPO
        ::WsRetornoGeral:WsBuscaProd:produtoB1POSIPI    := SB1->B1_POSIPI
        ::WsRetornoGeral:WsBuscaProd:produtoB1GRUPO     := SB1->B1_GRUPO


    ELSE 
        ::WsRetornoGeral:WsRetMsg:cRet     := "[F]"
        ::WsRetornoGeral:WsRetMsg:cMessage := "O produto não foi encontrado"

    ENDIF

    SB1->(DbCloseArea())
RETURN .T.


WSMETHOD BuscaProdVend WSRECEIVE _cCodProduto WSSEND WsBuscaProdVend WSSERVICE WSPRODSB1

    Local cCodProduto := ::_cCodProduto
    Local nQtdVend    := 0 
    Local nTotalVend  := 0

    DbSelectArea("SD2")
    SD2->(DBSetOrder(1))
    SD2->(DBSeek(xFilial("SD2")+cCodProduto))

        While SD2->(!Eof()) .AND. Alltrim(SD2->D2_COD) == cCodProduto
            nQtdVend    += SD2->D2_QUANT
            nTotalVend  += SD2->D2_TOTAL
        SD2->(DbSkip())    
        ENDDO

    
    SD2->(DbCloseArea())

    IF nQtdVend > 0 
        ::WsBuscaProdVend:cRet     := "[T]"
        ::WsBuscaProdVend:cMessage := "O produto foi encontrado"


        ::WsBuscaProdVend:produtoCODIGO         := cCodProduto
        ::WsBuscaProdVend:produtoDESCRICAO      := POSICIONE("SB1",1,xFilial("SB1")+cCodProduto,"B1_DESC")
        ::WsBuscaProdVend:produtoQTDTOTAL       := nQtdVend
        ::WsBuscaProdVend:produtoVALORTOTAL     := nTotalVend
    ELSE
        ::WsBuscaProdVend:cRet     := "[F]"
        ::WsBuscaProdVend:cMessage := "Erro! O produto não foi encontrado"
    ENDIF

RETURN .T. 
