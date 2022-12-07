#Include 'Protheus.ch'
#Include  'APWEBSRV.CH'
#Include 'TOPCONN.ch'


WSSTRUCT STProduto

    WSDATA produtoB1COD     AS STRING OPTIONAL
    WSDATA produtoB1DESC    AS STRING OPTIONAL
    WSDATA produtoB1UM      AS STRING OPTIONAL
    WSDATA produtoB1TIPO    AS STRING OPTIONAL
    WSDATA produtoB1POSIPI  AS STRING OPTIONAL
    WSDATA produtoB1GRUPO   AS STRING OPTIONAL 


ENDWSSTRUCT

WSSTRUCT StListProdutosSQL 

    WSDATA aRegsProdutos        AS ARRAY OF STProdutoSQL

    WSDATA cRet                 AS STRING OPTIONAL
    WSDATA cMessage             AS STRING OPTIONAL 

ENDWSSTRUCT

WSSERVICE WSLISTPRODUTOS DESCRIPTION "Lista os produtos com base nos parametros informados"

    WSDATA cProutoDe AS STRING 
    WSDATA cProdutoAte AS STRING
    WSDATA cToken  AS STRING

    WSDATA WsListaProdutos AS STListProdutosSQL

    WSMETHOD BuscaProdutos DESCRIPTION "Busca os produtos do Protheus, através de query SQL, com base nos parametros"


ENDWSSERVICE
