#Include 'Protheus.ch'

 /*/{Protheus.doc} MVCSZ7M
    Ponto de entrada para a User Function MVCSZ7 que está em MVC onde o ID do modelo é MVCSZ7M 
        @type  Function
    @author user
    @since 08/10/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function MVCSZ7M()
    Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um lógico quanto um array, 
por isso colocamos x como indefinido*/

    Local xRet  := .T.

    Local oObject   := aParam[1] // Objeto do formulário ou do modelo, conforme o caso
    Local cIdPonto  := aParam[2] // ID do local de execução do ponto de entrada (se é inclusão, alteração, pós validação,etc)
    Local cIdModel  := aParam[3] // ID do modelo do formulário 

    IF aParam[2] <> Nil
        IF cIdPonto == "FORMLINEPOS"
            IF FWFldGet("Z7_QUANT") > 10
                Help(NIL, NIL, "QTD", NIL, "Quantidade acima do permitido",;
                1,0, NIL, NIL, NIL, NIL, NIL,{"Quantidade acima do permitido"})

                xRet := .F. 
                

            ENDIF

        ENDIF
    ENDIF
Return xRet
