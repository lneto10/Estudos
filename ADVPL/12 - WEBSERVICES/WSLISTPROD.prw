#Include 'Protheus.ch'
#Include  'APWEBSRV.CH'
#Include 'TOPCONN.ch'


WSSTRUCT STProdutoSql

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

    WSDATA cProdutoDe AS STRING 
    WSDATA cProdutoAte AS STRING
    WSDATA cToken  AS STRING

    WSDATA WsListaProdutos AS STListProdutosSQL

    WSMETHOD BuscaProdutos DESCRIPTION "Busca os produtos do Protheus, através de query SQL, com base nos parametros"


ENDWSSERVICE

WSMETHOD BuscaProdutos WSRECEIVE cToken, cProdutoDe, cProdutoAte WSSEND WsListaProdutos WSSERVICE WSLISTPRODUTOS 

lOCAL cCodProdDe := ::cProdutoDe
Local cCodProdAte := ::cProdutoAte
Local cTokenDefault := "token123"
Local cAlias 
Local nIndex := 1




IF Empty(::cToken)
    SetSoapFault("Token nao preenchido","Operacao nao permitida")
    RETURN .F.
ELSEIF cTokenDefault <> ::cToken
    SetSoapFault("Token invalido. Informe o token correto","Operacao nao permitida")
    RETURN .F.
ELSE
    IF  cCodProdDe > cCodProdAte 
        cCodProdDe := ::cProdutoAte
        cCodProdAte := ::cProdutoAte
    ENDIF

    cAlias := GetNextAlias()

    BeginSql Alias cAlias 
        SELECT B1_COD, B1_DESC, B1_UM,B1_TIPO, B1_POSIPI, BM_DESC FROM %table:SB1% SB1
        LEFT JOIN %table:SBM% SBM ON SB1.B1_GRUPO = BM_GRUPO 
        WHERE SB1.%notDel% AND B1_COD BETWEEN %exp:cCodProdDe% AND %exp:cCodProdAte%
        ORDER BY B1_COD
    ENDSQL

    MemoWrite("WSLISTPROD.sql",GetLastQuery()[2])

    (cAlias)->(DbGoTop())
    While (cAlias)->(!Eof())
        aAdd(::WsListaProdutos:aRegsProdutos,WSCLASSNEW( "STProdutoSQL" ))

        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1COD        := (cAlias)->B1_COD
        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1DESC       := (cAlias)->B1_DESC
        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1UM         := (cAlias)->B1_UM
        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1TIPO       := (cAlias)->B1_TIPO
        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1POSIPI     := (cAlias)->B1_POSIPI
        ::WsListaProdutos:aRegsProdutos[nIndex]:produtoB1GRUPO       := (cAlias)->BM_DESC
        
        nIndex++
        
    (cAlias)->(DbSkip())
    ENDDO

    (cAlias)->(DbCloseArea())

    IF len(::WsListaProdutos:aRegsProdutos) > 0 
        ::WsListaProdutos:cRet    := "[T]"
        ::WsListaProdutos:cMessage := "Sucesso! Foram encontrado o total de "+CValToChar(len(::WsListaProdutos:aRegsProdutos))+" produtos"
    else
        ::WsListaProdutos:cRet    := "[F]"
        ::WsListaProdutos:cMessage := "Falha!"
    ENDIF
        
        
    
ENDIF


RETURN .T. 
