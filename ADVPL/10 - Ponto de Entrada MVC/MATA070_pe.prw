#include 'Protheus.ch'

/*/{Protheus.doc} User Function MATA070
    Ponto de entrada para Bancos (MATA070 )
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
User Function MATA070()
    Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um lógico quanto um array, 
por isso colocamos x como indefinido*/

    Local xRet  := .T.

    Local oObject   := aParam[1] // Objeto do formulário ou do modelo, conforme o caso
    Local cIdPonto  := aParam[2] // ID do local de execução do ponto de entrada (se é inclusão, alteração, pós validação,etc)
    Local cIdModel  := aParam[3] // ID do modelo do formulário 

    IF aParam[2] <> Nil
        IF cIdPonto == "MODELPOS"
            IF Empty(M->A6_DVAGE) .or. (M->A6_DVCTA)
                xRet := .F. 
                Help(NIL, NIL, "CONTA", NIL, "O digito verificador da agencia e conta está em branco",;
                1,0, NIL, NIL, NIL, NIL, NIL,{"Preencha o DV da agencia <b> "})

            ENDIF

        ENDIF
    ENDIF
Return xRet
