#include 'Protheus.ch'


User Function Item /*/{Protheus.doc} Item
    Ponto de entrada usado para modificar o cadastro de produtos, quando estiver em MVC 
    @type  Function
    @author Luiz Neto
    @since 02/10/2022
    @version version
    @return xRet, retorno da variável de controle 
    @example
    (examples)
    @see (links_or_references)
    /*/


/*Parametro obrigatório nos PEs em MVC, pois trazem consigo informações 
importantes sobre o estado e ponto de execuçãõ da rotina */
Local aParam    := PARAMIXB

/*Esta variavel pode retornar tanto um lógico quanto um array, 
por isso colocamos x como indefinido*/

Local xRet  := .T.

Local oObject   := aParam[1] // Objeto do formulário ou do modelo, conforme o caso
Local cIdPonto  := aParam[2] // ID do local de execução do ponto de entrada (se é inclusão, alteração, pós validação,etc)
Local cIdModel  := aParam[3] // ID do modelo do formulário 

Local nOperation := oObject:GetOperation()

/*
1 - Pesquisar
2 - visualizar
3- incluir
4 - alterar 
5 - excluir
6 - outras ações
7 - copiar
*/
IF aParam[2] <> Nil 

    IF cIdPonto == "MODELPOS" // Se estive na pós validação (clicou em confirmar) 
        IF Len(AllTrim(M->B1_COD)) < 10 
            Help(NIL, NIL, "CODPRODUTO", NIL, "Código não permitido",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O Código <b> "+AllTrim(M->B1_COD) + "</b> deve ter no mínimo 10 caracteres <b>"})

            xRet := .F. 
        ELSEIF Len(AllTrim(M->B1_DESC)) < 15
            Help(NIL, NIL, "DESCPRODUTO", NIL, "Descricao incompleta",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O Código <b> "+AllTrim(M->B1_DESC) + "</b> deve ter no mínimo 15 caracteres <b>"}) 
            xRet := .F. 
        ENDIF

    ELSEIF nOperation == 5 // Exclusão 
        Help(NIL, NIL, "EXCLUIRPRODUTO", NIL, "Exclusão não permitida",;
            1,0, NIL, NIL, NIL, NIL, NIL,{"O produto  <b> "+AllTrim(M->B1_DESC) + "</b> nao pode ser excluído <b>"}) 
            xRet := .F. 
    ENDIF
ENDIF 
    
Return xRet
