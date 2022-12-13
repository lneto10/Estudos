#include 'Protheus.ch'
#include 'APWEBSRV.ch'
#include 'TOPCONN.ch'

/* 
WebService para disponibilizar os dados do cadastro de clientes da SA1 
@author Luiz Neto
@since 24/11/2022
*/

//CODIGO, NOME, CPF, ENDEREÃ‡O, BAIRRO, ESTADO E CEP 

// Estrutura de dados que serao retornada pelo webservice na chamada pelo Cliente

WSSTRUCT STCliente
    WSDATA clienteA1COD         AS STRING OPTIONAL
    WSDATA clienteA1LOJA        AS STRING OPTIONAL
    WSDATA clienteA1NOME        AS STRING OPTIONAL
    WSDATA clienteA1CPF         AS STRING OPTIONAL
    WSDATA clienteA1END         AS STRING OPTIONAL
    WSDATA clienteA1BAIRRO      AS STRING OPTIONAL
    WSDATA clienteA1MUNICIP     AS STRING OPTIONAL
    WSDATA clienteA1ESTADO      AS STRING OPTIONAL
    WSDATA clienteA1CEP         AS STRING OPTIONAL
ENDWSSTRUCT

WSSTRUCT StRetMsg
    WSDATA cRet                 AS STRING OPTIONAL
    WSDATA cMessage             AS STRING OPTIONAL

ENDWSSTRUCT

//Retorno do Webservice
WSSTRUCT  STRetornoGeral

    WSDATA WSSTClient   AS STCliente
    WSDATA WSSTRetMsg   AS StRetMsg 

ENDWSSTRUCT

WSSERVICE WSCLISA1 DESCRIPTION "Servico para retornar os dados de cliente"

    //Codigo que sera requisitado pelo metodo de busca do cliente 
    WSDATA _cCodClienteLoja AS STRING 
    
    //Chamada da estrutura de retorno que serÃ¡ retornada pelo mÃ©todo
    WSDATA WSRetornoGeral as STRetornoGeral

    //Estrutura de dados e retorno do método Incluir Cliente
    WSDATA WsDadosCli     as STCLiente // Entrada do método
    WSDATA WsRetInclusao  AS StRetMsg // Retorno do método
    WSDATA cToken          AS STRING // Entrada do método 

    WSMETHOD BuscaCliente DESCRIPTION "Busca clientes na tabela SA1 com base no cÃ³digo"

    WSMETHOD IncluirCliente DESCRIPTION "Incluir dados de cliente na base de dados do Protheus"


ENDWSSERVICE

//            MÃ‰TODO       PARAMETRO DE ENTRADA        RETORNO DO WS         WS A QUAL PERTENCE
WSMETHOD    BuscaCliente    WSRECEIVE _cCodClienteLoja WSSEND WSRetornoGeral WSSERVICE WSCLISA1

    Local cCliLoja:= ::_cCodClienteLoja 

    DbSelectArea("SA1")
    SA1->(DbSetOrder((1)))

    IF SA1->(DbSeek(xFilial("SA1")+cCliLoja)) 
        
        ::WSRetornoGeral:WSSTRetMsg:cRet              := "[T]"
        ::WSRetornoGeral:WSSTRetMsg:cMessage          := "Dados Encontrados"
        ::WSRetornoGeral:WSStClient:clienteA1COD      := SA1->A1_COD
        ::WSRetornoGeral:WSStClient:clienteA1NOME     := SA1->A1_NOME
        ::WSRetornoGeral:WSStClient:clienteA1CPF      := SA1->A1_CGC
        ::WSRetornoGeral:WSStClient:clienteA1END      := SA1->A1_END
        ::WSRetornoGeral:WSStClient:clienteA1BAIRRO   := SA1->A1_BAIRRO
        ::WSRetornoGeral:WSStClient:clienteA1MUNICIP  := SA1->A1_MUN
        ::WSRetornoGeral:WSStClient:clienteA1ESTADO   := SA1->A1_EST
        ::WSRetornoGeral:WSStClient:clienteA1CEP      := SA1->A1_CEP

    ELSE 
        ::WSRetornoGeral:WSSTRetMsg:cRet               := "[F]"
        ::WSRetornoGeral:WSSTRetMsg:cMessage           := "Nao encontrado registros com esse codigo"
    ENDIF
    


    SA1->(DbCloseArea())

Return .T.


WSMETHOD IncluirCliente WSRECEIVE cToken, WSDadosCli WSSEND WsRetInclusao WSSERVICE WSCLISA1
    Local cTokenDefault := "#euamoADVPL"
    Local cA1COD        := ::WSDadosCli:clienteA1COD
    Local cA1LOJA       := ::WSDadosCli:clienteA1LOJA
    local cA1NOME       := ::WSDadosCli:clienteA1NOME
    Local cA1CPF        := ::WSDadosCli:clienteA1CPF
    Local cA1END        := ::WsdadosCli:clienteA1END
    local cA1BAIRRO     := ::WsDadosCli:clienteA1BAIRRO
    Local cA1MUNICIP    := ::WsDadosCli:clienteA1MUNICIP
    Local cA1ESTADO     := ::WsDadosCli:clienteA1ESTADO
    Local cA1CEP        := ::WsDadosCli:clienteA1CEP       

    IF Empty(::cToken)
        SetSoapFault("Token nao preenchido","Operacao nao permitida")
        RETURN .F.
    ELSEIF cTokenDefault <> ::cToken
        SetSoapFault("Token invalido. Informe o token correto","Operacao nao permitida")
        RETURN .F.
    ELSE
        DbSelectArea("SA1")
        SA1->(DbSetOrder(1))
        
        //Verifico se todos os campos estão preenchidos 

        IF Empty(cA1COD) .OR. Empty(cA1LOJA) .OR. Empty(cA1NOME) .OR. Empty(cA1CPF) .OR. Empty(cA1END) .OR. Empty(cA1BAIRRO) .OR. Empty(cA1MUNICIP) .OR. Empty(cA1ESTADO) .OR. Empty(cA1CEP)
            ::WsRetInclusao:cRet     := "902"
            ::WsRetInclusao:cMessage := "Operacao nao permitida! Existem dados vazios"
        //Verifica se o cliente existe no banco de dados 
        ELSEIF SA1->(DbSeek(xFilial("SA1")+cA1COD+cA1LOJA))
            ::WsRetInclusao:cRet     := "901"
            ::WsRetInclusao:cMessage := "Operacao nao permitida! Cliente ja cadastrado na base de dados "
        ELSE 
                SA1->(RecLock("SA1",.T.))
                    SA1->A1_COD     := cA1COD
                    SA1->A1_LOJA    := cA1LOJA
                    SA1->A1_NOME    := cA1NOME
                    SA1->A1_CGC     := cA1CPF
                    SA1->A1_END     := cA1END 
                    SA1->A1_BAIRRO  := cA1BAIRRO 
                    SA1->A1_MUN     := cA1MUNICIP
                    SA1->A1_EST     := cA1ESTADO
                    SA1->A1_CEP     := cA1CEP

            SA1->(MsUnlock())

            ::WSRetInclusao:cRet := "903"
            ::WsRetInclusao:cMessage := "Dados registrados com sucesso"

        ENDIF 
    ENDIF
    SA1->(DbCloseArea())
        

    
RETURN .T.
