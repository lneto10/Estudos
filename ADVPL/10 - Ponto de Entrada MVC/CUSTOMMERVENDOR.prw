#Include 'Protheus.ch'

 /*/{Protheus.doc} CustomerVendor
Customervendor � o nome do ID do Model dentro do fonte padr�o do cadastro do fornecedor (MATA020)
    @type  Function
    @author Luiz Neto
    @since 08/10/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function CustomerVendor()

/*Parametro obrigat�rio nos PEs em MVC, pois trazem consigo informa��es 
importantes sobre o estado e ponto de execu��� da rotina */
Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um l�gico quanto um array, 
por isso colocamos x como indefinido*/

Local xRet  := .T.

Local oObject   := aParam[1] // Objeto do formul�rio ou do modelo, conforme o caso
Local cIdPonto  := aParam[2] // ID do local de execu��o do ponto de entrada (se � inclus�o, altera��o, p�s valida��o,etc)
Local cIdModel  := aParam[3] // ID do modelo do formul�rio 

Local cRazSoc   := Alltrim(M->A2_NOME)
Local cFantasia := Alltrim(M->A2_NREDUZ)

IF aParam[2] <> Nil 

    IF cIdPonto == "MODELPOS" // Se estive na p�s valida��o (clicou em confirmar) 
        IF Len(AllTrim(cRazSoc)) < 20 
            Help(NIL, NIL, "RAZAOSOCIAL", NIL, "Razao social incompleta",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"A razao social esta incompleta <b> "+AllTrim(cRazSoc) + "</b> deve ter no m�nimo 10 caracteres <b>"})
            xRet := .F. 
        ELSEIF Len(AllTrim(cFantasia)) < 10
            Help(NIL, NIL, "CODPRODUTO", NIL, "C�digo n�o permitido",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O C�digo <b> "+AllTrim(cFantasia) + "</b> deve ter no m�nimo 10 caracteres <b>"})
            xRet := .F. 
        ENDIF
    ELSEIF cIdPonto == "BUTTONBAR"
        xRet := {{"Produto x Fornecedor","Produto x Fornecedor", {||MATA061()},"Chama amarra��o PROD x For"}}
    
    ENDIF
ENDIF 
    
Return xRet

Return return_var
