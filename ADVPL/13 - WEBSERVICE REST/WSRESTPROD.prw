#include 'TOTVS.CH'
#include 'RESTFUL.CH' //Include utilizada para construção do WEBSERVICE 


//Inicia a criacao do servico REST
WSRESTFUL WSRESTPROD DESCRIPTION "Servico REST para manipulacao de produtos"

//Inicia a criacao dos metodos que o Webservice terá 
WSMETHOD GET    buscarproduto    DESCRIPTION "Retorna dados do Produto" WSSYNTAX "/buscarproduto"       PATH "buscarproduto"    PRODUCES APLICATION_JSON
WSMETHOD POST   inserirproduto   DESCRIPTION "Inserir dados do Produto" WSSYNTAX "/inserirproduto"      PATH "inserirproduto"   PRODUCES APLICATION_JSON
WSMETHOD PUT    atualizarproduto DESCRIPTION "Alterar dados do Produto" WSSYNTAX "/atualizarproduto"    PATH "atualizarproduto" PRODUCES APLICATION_JSON
WSMETHOD DELETE deletarproduto   DESCRIPTION "Deleta dados do Produto"  WSSYNTAX "/deletarproduto"      PATH "deletarproduto"   PRODUCES APLICATION_JSON



ENDWSRESTFUL 
