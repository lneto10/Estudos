#Include 'Protheus.ch'
#Include 'FwMvcDef.ch'

/*/{Protheus.doc} User Function MVCZ2Z3
    Sistema de chamados utilizando MVC - Modelo 3 
    @type  Function
    @author user
    @since 18/07/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function MVCZ2Z3()
Local oBrowse   := FwLoadBrw("MVCZ2Z3")    

oBrowse:ACTIVATE()

Return

/*/{Protheus.doc} BrowseDef
    Função responsavel por criar o Browse e retorna-lo para o Menu que invoca-lo
    Quando se tem uma funcao browsedef no fonte, significa que pode "empresta-la" para outras funcoes 
    atraves do FWLOADBRW
    @type  Static Function
    @author user
    @since 18/07/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function BrowseDef()
Local aArea     := GetArea()
Local oBrwose   := FwBrowse():New()

oBrowse:SetAlias ("SZ2")
oBrowse:SetDescription("Cadastro de Chamados")

oBrowse:AddLegend("SZ2->Z2_STATUS == '1'", "GREEN", "Chamado Aberto")
oBrowse:AddLegend("SZ2->Z2_STATUS == '2'", "RED", "Chamado Encerrado")
oBrowse:AddLegend("SZ2->Z2_STATUS == '3'", "YELLOW", "Chamado Em Andamento")

// Deve definir de onde vira o Menudef 

oBrowse:SetMenuDef("MVCZ2Z3") // Fonte de onde vira o Menu

Return oBrowse 
