#Include 'Protheus.ch'

 /*/{Protheus.doc} CustomerVendor
Customervendor é o nome do ID do Model dentro do fonte padrão do cadastro do fornecedor (MATA020)
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

/*Parametro obrigatório nos PEs em MVC, pois trazem consigo informações 
importantes sobre o estado e ponto de execuçãõ da rotina */
Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um lógico quanto um array, 
por isso colocamos x como indefinido*/

Local xRet  := .T.

Local oObject   := aParam[1] // Objeto do formulário ou do modelo, conforme o caso
Local cIdPonto  := aParam[2] // ID do local de execução do ponto de entrada (se é inclusão, alteração, pós validação,etc)
Local cIdModel  := aParam[3] // ID do modelo do formulário 

Local cRazSoc   := Alltrim(M->A2_NOME)
Local cFantasia := Alltrim(M->A2_NREDUZ)

IF aParam[2] <> Nil 

    IF cIdPonto == "MODELPOS" // Se estive na pós validação (clicou em confirmar) 
        IF Len(AllTrim(cRazSoc)) < 20 
            Help(NIL, NIL, "RAZAOSOCIAL", NIL, "Razao social incompleta",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"A razao social esta incompleta <b> "+AllTrim(cRazSoc) + "</b> deve ter no mínimo 10 caracteres <b>"})
            xRet := .F. 
        ELSEIF Len(AllTrim(cFantasia)) < 10
            Help(NIL, NIL, "CODPRODUTO", NIL, "Código não permitido",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O Código <b> "+AllTrim(cFantasia) + "</b> deve ter no mínimo 10 caracteres <b>"})
            xRet := .F. 
        ENDIF
    ELSEIF cIdPonto == "BUTTONBAR"
        xRet := {{"Produto x Fornecedor","Produto x Fornecedor", {||MATA061()},"Chama amarração PROD x For"}}
    
    ENDIF
ENDIF 
    
Return xRet

Return return_var
