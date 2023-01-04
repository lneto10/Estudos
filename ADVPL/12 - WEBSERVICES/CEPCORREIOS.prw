#include 'Totvs.ch'
#include 'XMLXFUN.ch'

/* Funcao responsavel por consultar o CEP no site dos correios através de uma requisição SOAP XML e retornar os dados de Endereço, Bairro, cidade e Estado 
e gravar essa informação nos campos da tabela SA1. 
@author Luiz Neto
@since 03/01/2023 
@see criado gatilho no campo A1_CEP 

*/
User Function CEPCORREIOS()

Local cUrlWsdl          := "https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente"
Local nTimeOut      := 120
Local aHeadStr      := {}
Local cData         := ""
Local cHeadRet      := ""
Local aAreaSA1      := GetArea()
Local cEnd

//Captura o retorno do Webservice 
Local aData         := {}

Local oXml      := ""
Local cError    := ""
Local cWarning  := ""
Local sPostRet  := ""

DbSelectArea("SA1")

    IF !Empty(M->A1_CEP)
        //Realiza a montagem do cabeçalho do SOAP
        aAdd(aHeadStr, 'SOAPAction:"http://cliente.bean.master.sigep.bsb.correios.com.br/AtendeCliente/consultaCEP"')
        aAdd(aHeadStr, 'Content-Type: text/xml;charset=UTF-8')
    cData += "<soapenv:Envelope xmlns:soapenv='http://schemas.xmlsoap.org/soap/envelope/' xmlns:cli='http://cliente.bean.master.sigep.bsb.correios.com.br/'>"
    cData += "<soapenv:Header/>"
    cData += "<soapenv:Body>"
    cData += "<cli:consultaCEP>"
    cData += "<cep>"+M->A1_CEP+"</cep>"
    cData += "</cli:consultaCEP>"
    cData += "</soapenv:Body>"
    cData += "</soapenv:Envelope>"

    sPostRet := HttpPost(cUrlWsdl, "", cData, nTimeOut, aHeadStr, @cHeadRet)

    IF !Empty(sPostRet)
        If AT ("<faultcode>", sPostRet) == 0
            oXml := XmlParser(sPostRet,"_",@cError, @cWarning)
                                                                                                // posicao do array aData
            aAdd(aData,oXml:_SOAP_ENVELOPE:_SOAP_BODY:_NS2_CONSULTACEPRESPONSE:_RETURN:_END:TEXT) //[1]
            aAdd(aData,oXml:_SOAP_ENVELOPE:_SOAP_BODY:_NS2_CONSULTACEPRESPONSE:_RETURN:_BAIRRO:TEXT) // [2]
            aAdd(aData,oXml:_SOAP_ENVELOPE:_SOAP_BODY:_NS2_CONSULTACEPRESPONSE:_RETURN:_CIDADE:TEXT) // [3]
            aAdd(aData,oXml:_SOAP_ENVELOPE:_SOAP_BODY:_NS2_CONSULTACEPRESPONSE:_RETURN:_UF:TEXT) // [4]
            aAdd(aData,oXml:_SOAP_ENVELOPE:_SOAP_BODY:_NS2_CONSULTACEPRESPONSE:_RETURN:_CEP:TEXT) // [5]

            cEnd            := aData[1]
            M->A1_BAIRRO    := aData[2]
            M->A1_MUN       := aData[3]
            M->A1_EST       := aData[4]

        ELSE
            Alert ("Cep Inválido ou não encontrado")
        ENDIF
    ENDIF

    ENDIF
SA1->(DbCloseArea())
RestArea(aAreaSA1)


Return cEnd
