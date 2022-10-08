#include 'Protheus.ch'


User Function Item /*/{Protheus.doc} Item
    Ponto de entrada usado para modificar o cadastro de produtos, quando estiver em MVC 
    @type  Function
    @author Luiz Neto
    @since 02/10/2022
    @version version
    @return xRet, retorno da vari�vel de controle 
    @example
    (examples)
    @see (links_or_references)
    /*/


/*Parametro obrigat�rio nos PEs em MVC, pois trazem consigo informa��es 
importantes sobre o estado e ponto de execu��� da rotina */
Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um l�gico quanto um array, 
por isso colocamos x como indefinido*/

Local xRet  := .T.

Local oObject   := aParam[1] // Objeto do formul�rio ou do modelo, conforme o caso
Local cIdPonto  := aParam[2] // ID do local de execu��o do ponto de entrada (se � inclus�o, altera��o, p�s valida��o,etc)
Local cIdModel  := aParam[3] // ID do modelo do formul�rio 

IF aParam[2] <> Nil 

    IF cIdPonto == "MODELPOS" // Se estive na p�s valida��o 
        IF Len(AllTrim(M->B1_COD)) < 10 
            Help(NIL, NIL, "CODPRODUTO", NIL, "C�digo n�o permitido",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O C�digo <b> "+AllTrim(M->B1_COD) + "</b> deve ter no m�nimo 10 caracteres <b>"})

            xRet := .F. 
        ELSEIF Len(AllTrim(M->B1_DESC)) < 15
            Help(NIL, NIL, "DESCPRODUTO", NIL, "Descricao incompleta",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O C�digo <b> "+AllTrim(M->B1_DESC) + "</b> deve ter no m�nimo 15 caracteres <b>"}) 
            xRet := .F. 
        ENDIF 
    ENDIF
ENDIF 
    
Return xRet
