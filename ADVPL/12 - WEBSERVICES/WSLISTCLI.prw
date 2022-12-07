#Include 'Protheus.ch'
#Include  'APWEBSRV.CH'
#Include 'TOPCONN.ch'


WSSTRUCT STClientes 
    WSDATA clienteCODIGO        AS STRING OPTIONAL
    WSDATA clienteDESCRICAO     AS STRING OPTIONAL
    WSDATA clienteENDERECO      AS STRING OPTIONAL
    WSDATA clienteBAIRRO        AS STRING OPTIONAL
    WSDATA clienteCIDADE        AS STRING OPTIONAL
    WSDATA clienteESTADO        AS STRING OPTIONAL
    WSDATA clienteCEP           AS STRING OPTIONAL

ENDWSSTRUCT


//Estrutura de dados no formato tipo ARRAY para receber a lista de clientes com base na estrutura acima 
WSSTRUCT StListClientes

    WSDATA aRegsClientes        AS ARRAY OF STClientes OPTIONAL

    //Strings de retorno 
    WSDATA cRet                 AS STRING OPTIONAL
    WSDATA cMessage             AS STRING OPTIONAL 


ENDWSSTRUCT

WSSERVICE WSLISTCLIENTES DESCRIPTION "Serviço para listar os dados DOS CLIENTES dentro de um intervalo especificado"

    //PARAMETROS DE ENTRADA
    WSDATA cClienteDe       AS STRING OPTIONAL
    WSDATA cClienteAte      AS STRING OPTIONAL


    WSDATA cToken           AS STRING
    //estrutura de saída
    WSDATA WsListaClientes  AS StListClientes

    WSMETHOD BuscaClientes DESCRIPTION "Lista os clientes da base conforme os parametros"
ENDWSSERVICE


WSMETHOD BuscaClientes WSRECEIVE cToken,cClienteDe, cClienteAte WSSEND WsListaClientes WSSERVICE WSLISTCLIENTES
    Local cCodDe  := ::cClienteDe
    Local cCodAte := ::cClienteAte
    Local cTokenDefault := "#souprotheuzeiro"
    Local nIndex := 1

    IF Empty(::cToken)
        SetSoapFault("Token nao preenchido","Operacao nao permitida")
        RETURN .F.
    ELSEIF cTokenDefault <> ::cToken
        SetSoapFault("Token invalido. Informe o token correto","Operacao nao permitida")
        RETURN .F.
    ELSE
        

        IF cCodDe > cCodAte
            cCodDe  := ::cClienteAte
            cCodAte := ::cClientede
        ENDIF

        DbSelectArea("SA1")
        SA1->(DbSetOrder(1))
        SA1->(DbSeek(xFilial("SA1")+cCodDe))
            While SA1->(!Eof()) .AND. SA1->A1_COD <= cCodAte 
                Aadd(::WsListaClientes:aRegsClientes,WSCLASSNEW("STClientes"))

                ::WsListaClientes:aRegsClientes[nIndex]:clienteCODIGO       := SA1->A1_COD
                ::WsListaClientes:aRegsClientes[nIndex]:clienteDESCRICAO    := SA1->A1_NOME    
                ::WsListaClientes:aRegsClientes[nIndex]:clienteENDERECO     := SA1->A1_END
                ::WsListaClientes:aRegsClientes[nIndex]:clienteCEP          := SA1->A1_CEP
                ::WsListaClientes:aRegsClientes[nIndex]:clienteBAIRRO       := SA1->A1_BAIRRO
                ::WsListaClientes:aRegsClientes[nIndex]:clienteCIDADE       := SA1->A1_MUN
                ::WsListaClientes:aRegsClientes[nIndex]:clienteESTADO       := SA1->A1_EST

                nIndex++

            SA1->(DBSkip())
            ENDDO

        IF LEN(::WSListaClientes:aRegsClientes) > 0 
            ::WsListaClientes:cRet  := "[T]"
            ::WsListaClientes:cMessage := "Dados encontrados"
        ELSE
            ::WsListaClientes:cRet  := "[F]"
            ::WsListaClientes:cMessage := "Dados não  encontrados"
        ENDIF
    ENDIF
RETURN .T.



