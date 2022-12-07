#include 'Protheus.ch'
#include 'APWEBSRV.ch'
#include 'TOPCONN.ch'

/* 
WebService para disponibilizar os dados do cadastro de clientes da SA1 
@author Luiz Neto
@since 24/11/2022
*/

//CODIGO, NOME, CPF, ENDEREÇO, BAIRRO, ESTADO E CEP 

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
    
    //Chamada da estrutura de retorno que será retornada pelo método
    WSDATA WSRetornoGeral as STRetornoGeral

    WSMETHOD BuscaCliente DESCRIPTION "Busca clientes na tabela SA1 com base no código"


ENDWSSERVICE

//            MÉTODO       PARAMETRO DE ENTRADA        RETORNO DO WS         WS A QUAL PERTENCE
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
