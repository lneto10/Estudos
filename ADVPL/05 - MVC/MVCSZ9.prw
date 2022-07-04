#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'

/*/{Protheus.doc} User Function MVCSZ9
    Rotina de cadastro desenvolvida em MVC 
    @type  Function
    @author luiz neto
    @since 28/06/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function MVCSZ9()
Local oBrowseSZ9 // Variável que receberá o instanciamento da clase FWBROWSE 

oBrowseSZ9 := FwmBrowse():New() // ativa a classe FWMBROWSE

// Passo como parametro a tabela que desejo mostrar no grid. 
oBrowseSZ9:setAlias("SZ9")

//Descricao da tela que apresentará no Browse
oBrowseSZ9:SetDescription("Primeiro Browse - Tela de Cadastro SZ9")

//Faz com que somente esses campos apresente no grid
oBrowseSZ9:SetOnlyFields({"Z9_CODIGO","Z9_NOME","Z9_SEXO","Z9_STATUS"})


//Adicionando legenda no browse
                   // Expressão            // cor       // descricao da legenda
//oBrowseSZ9:AddLegend("SZ9->Z9_STATUS=='1'","GREEN","Cadastro Ativo")
//oBrowseSZ9:AddLegend("SZ9->Z9_STATUS=='2'","RED","Cadastro Inativo")

// Definindo filtro default na abertura da tela.
oBrowseSZ9:SetFilterDefault("SZ9->Z9_STATUS= '1'")




oBrowseSZ9:ACTIVATE()



Return 


 

/*/{Protheus.doc} ModelDef
    Static Function ModelDef do programa em MVC
    @type  Static Function
    @author Luiz Neto
    @since 28/06/2022
    @version version
    @param param_name, param_type, param_descr
    @return oModel, return_type, Objeto da funcao MVC
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
Local oModel := Nil 
// Traz a estrutura da SZ9 (tabela e caracteristicas dos campos). Parâmetro 1 - Model, Parametro 2 - View
Local oStructSZ9 := FwFormStruct(1,"SZ9") 

oModel := MPFormModel():New("MVCSZ9M")

//Atribuindo formulario para o modelo de dados 
oModel:AddFields("FORMSZ9",/*Owner*/,oStructSZ9)

// Definindo chave primaria na aplicação 
oModel:SetPrimaryKey({"Z9_FILIAL","Z9_CODIGO"})

oModel:SetDescription("Modelo de Dados do cadastro de Usuarios")

oModel:GetModel("FORMSZ9"):SetDescription("Formulario de cadastro de Usuarios")


    
Return oModel


/*/{Protheus.doc} ViewDef
    Static function viewDef da tela de cadastro em MVC 
    @type  Static Function
    @author Luiz Neto
    @since 28/06/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
Local oView := Nil

//Funcao que retorna um objeto de model de determinado fonte 

Local oModel := FwLoadModel("MVCSZ9")

Local oStructSZ9 := FwFormStruct(2,"SZ9") 

// Construindo a parte de visão dos dados 
oView := FwFormView():New()

oView:SetModel(oModel)

oView:AddField("VIEWSZ9",oStructSZ9,"FORMSZ9")
//Criando um conteiner com o identificador Tela
oView:CreateHorizontalBox("TELA",100)

oView:EnableTitleView("VIEWSZ9","Visualizacao dos cadastros")

oView:SetCloseOnOk({||.T.})

oView:SetOwnerView("VIEWSZ9","TELA")


Return oView


Static Function MenuDef()
Local aRotina := {}
Local n := 0 

aRotinaAut := FwMVCMenu("MVCSZ9") // Criação do menu de forma automatica

/*ADD OPTION aRotina TITLE 'Visualizar '  ACTION 'VIEWDEF.MVCSZ9' OPERATION 2 ACCESS 0
ADD OPTION aRotina TITLE 'Incluir '     ACTION 'VIEWDEF.MVCSZ9' OPERATION 3 ACCESS 0
ADD OPTION aRotina TITLE 'Alterar '     ACTION 'VIEWDEF.MVCSZ9' OPERATION 4 ACCESS 0
ADD OPTION aRotina TITLE 'Excluir '     ACTION 'VIEWDEF.MVCSZ9' OPERATION 5 ACCESS 0*/
ADD OPTION aRotina TITLE 'Legenda'      ACTION 'u_SZ9LEG()'     OPERATION 6 ACCESS 0

    For n := 1 To Len(aRotinaAut)

        aAdd (aRotina,aRotinaAut[n])

    Next n

Return aRotina

// Funcao que determinara a descrição das legendas (no botão Outras ações)
User Function SZ9LEG()
Local aLegenda := {}

aAdd(aLegenda,{"BR_VERDE"    ,"Ativo"})
aAdd(aLegenda,{"BR_VERMELHO" ,"Inativo"})

BrwLegenda("Cadastros de Usuarios (as)","Ativos/Inativos",aLegenda)




Return aLegenda

