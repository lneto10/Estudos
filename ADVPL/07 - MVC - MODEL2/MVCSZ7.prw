#Include 'Protheus.ch'
#Include 'FwMvcDef.ch'

/*/{Protheus.doc} User Function MVCSZ7
    Fun??o principal para tela de solicitacao de compras da empresa em MVC Model 2 
    @type  Function
    @author Luiz Neto
    @since 04/07/2022
    @see (links_or_references)
    /*/
User Function MVCSZ7()
Local aArea     := GetArea()

/* Realiza o instanciamento da classe FWMBrowse, 
passando para o oBrowse a possibilidade de executar todos os m?todos da classe*/
Local oBrowse   := FwmBrowse():New() 
oBrowse:SetAlias("SZ7")
oBrowse:SetDescription("Solicitação de Compra")
oBrowse:Activate()
RestArea(aArea)
    
Return 


Static Function MenuDef()
Local aRotina := FwMvcMenu("MVCSZ7")


Return aRotina
/*Static function responsavel pela cria??o do modelo de dados
https://tdn.totvs.com/display/framework/FWFormModelStruct
https://tdn.totvs.com/display/framework/FWFormStruct
https://tdn.totvs.com/display/framework/MPFormModel
https://tdn.totvs.com/display/framework/FWBuildFeature
https://tdn.totvs.com/display/framework/FWFormGridModel*/

Static Function ModelDef()
//Objeto respons?vel pela CRIA??O da estrutura TEMPOR?RIA do cabe?alho 
Local oStCabec      := FWFormModelStruct():New()

//Objeto respons?vel pela estrutura dos itens
Local oStItens      := FwFormStruct(1,"SZ7") //1 para model 2 para view



/*Objeto principal do desenvolvimento em MVC MODELO2, ele traz as caracter?sticas do dicion?rio de dados
bem como ? o respons?vel pela estrutura de tabelas, campos e registros*/

Local bVldCom       := {|| u_GrvSZ7()}

Local oModel        := MPFormModel():New("MVCSZ7m",/*bPre*/, /*bPos*/, bVldCom,/*bCancel*/)

//Cria??o da tabela tempor?ria que ser? utilizada no cabe?alho
oStCabec:AddTable("SZ7",{"Z7_FILIAL","Z7_NUM","Z7_ITEM"},"Cabe?alho SZ7")

//Cria??o dos campos da tabela tempor?ria
oStCabec:AddField(;
    "Filial",;                                                                                  // [01]  C   Titulo do campo
    "Filial",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_FILIAL",;                                                                               // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FILIAL")[1],;                                                                    // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                                       // [08]  B   Code-block de valida??o When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))" ),;   // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                                        // [14]  L   Indica se o campo ? virtual

oStCabec:AddField(;
    "Pedido",;                                                                                  // [01]  C   Titulo do campo
    "Pedido",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_NUM",;                                                                                  // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_NUM")[1],;                                                                       // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                                       // [08]  B   Code-block de valida??o When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_NUM,'')" ),;                    // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                                        // [14]  L   Indica se o campo ? virtual

oStCabec:AddField(;
    "Emissao",;                                                                     // [01]  C   Titulo do campo
    "Emissao",;                                                                     // [02]  C   ToolTip do campo
    "Z7_EMISSAO",;                                                                  // [03]  C   Id do Field
    "D",;                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_EMISSAO")[1],;                                                       // [05]  N   Tamanho do campo
    0,;                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                           // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                           // [08]  B   Code-block de valida??o When do campo
    {},;                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_EMISSAO,dDataBase)" ),;    // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                            // [14]  L   Indica se o campo ? virtual


oStCabec:AddField(;
    "Fornecedor",;                                                              // [01]  C   Titulo do campo
    "Fornecedor",;                                                              // [02]  C   ToolTip do campo
    "Z7_FORNECE",;                                                              // [03]  C   Id do Field
    "C",;                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FORNECE")[1],;                                                   // [05]  N   Tamanho do campo
    0,;                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                       // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                       // [08]  B   Code-block de valida??o When do campo
    {},;                                                                        // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FORNECE,'')" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                        // [14]  L   Indica se o campo ? virtual

oStCabec:AddField(;
    "Loja",;                                                                      // [01]  C   Titulo do campo
    "Loja",;                                                                      // [02]  C   ToolTip do campo
    "Z7_LOJA",;                                                                   // [03]  C   Id do Field
    "C",;                                                                         // [04]  C   Tipo do campo
    TamSX3("Z7_LOJA")[1],;                                                        // [05]  N   Tamanho do campo
    0,;                                                                           // [06]  N   Decimal do campo
    Nil,;                                                                         // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                         // [08]  B   Code-block de valida??o When do campo
    {},;                                                                          // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_LOJA,'')" ),;     // [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                          // [14]  L   Indica se o campo ? virtual

oStCabec:AddField(;
    "Usuario",;                                                                     // [01]  C   Titulo do campo
    "Usuario",;                                                                     // [02]  C   ToolTip do campo
    "Z7_USER",;                                                                     // [03]  C   Id do Field
    "C",;                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_USER")[1],;                                                          // [05]  N   Tamanho do campo
    0,;                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                           // [07]  B   Code-block de valida??o do campo
    Nil,;                                                                           // [08]  B   Code-block de valida??o When do campo
    {},;                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigat?rio
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_USER,__cuserid)" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma opera??o de update.
    .F.)                                                                            // [14]  L   Indica se o campo ? virtual

//Agora vamos tratar a estrutura dos Itens, que ser?o utilizados no Grid da aplica??o

//Modificando Inicializadores Padrao,  para n?o dar mensagem de colunas vazias
oStItens:SetProperty("Z7_NUM",      MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
oStItens:SetProperty("Z7_USER",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '__cUserId')) //Trazer o usu?rio automatico
oStItens:SetProperty("Z7_EMISSAO",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, 'dDatabase')) //Trazer a data autom?tica
oStItens:SetProperty("Z7_FORNECE",  MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
oStItens:SetProperty("Z7_LOJA",     MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))

/*A partir de agora, eu fa?o a uni?o das estruturas, vinculando o cabe?alho com os itens
tamb?m fa?o a vincula??o da Estrutura de dados dos itens, ao modelo
*/

oModel:AddFields("SZ7MASTER",,oStCabec) //Fa?o a vincula??o com o oStCabe(cabe?alho e itens tempor?rios)
oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oStItens,,,,,)


//Seto a rela??o entre cabe?aho e item, neste ponto, eu digo atrav?s de qual/quais campo(s) o grid est? vinculado com o cabe?alho
aRelations := {}
aAdd(aRelations,{"Z7_FILIAL",'Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'})
aAdd(aRelations,{"Z7_NUM","SZ7->Z7_NUM"})
oModel:SetRelation("SZ7DETAIL",aRelations,SZ7->(IndexKey(1)))

oModel:SetRelation('SZ7DETAIL',{{'Z7_FILIAL','Iif(!INCLUI, SZ7->Z7_FILIAL, FWxFilial("SZ7"))'},{'Z7_NUM','SZ7->Z7_NUM'}},SZ7->(IndexKey(1)))

//Seto a chave prim?ria, lembrando que, se ela estiver definida no X2_UNICO, faz valer o que est? no X2_UNICO
oModel:SetPrimaryKey({})

//? como se fosse a "chave prim?ria do GRID"
oModel:GetModel("SZ7DETAIL"):SetUniqueline({"Z7_ITEM"}) //o intuito ? que este campo n?o se repita

//Setamos a descri??o/t?tulo que aparecer? no cabe?alho 
oModel:GetModel("SZ7MASTER"):SetDescription("CABE?ALHO DA SOLICITA??O DE COMPRAS")

//Setamos a descri??o/t?tulo que aparecer? no GRID DE ITENS
oModel:GetModel("SZ7DETAIL"):SetDescription("ITENS DA SOLICITA??O DE COMPRAS")

//Finalizamos a fun??o model
oModel:GetModel("SZ7DETAIL"):SetUseOldGrid(.T.) //Finalizo setando o modelo antigo de Grid, que permite pegar aHeader e aCols

Return oModel


Static Function ViewDef()
Local oView     := Nil
Local oModel    := FwLoadModel("MVCSZ7")
Local oStCabec  := FwFormViewStruct():New()
Local oStItens  := FwFormStruct (2,"SZ7")

oStCabec:AddField(;
    "Z7_NUM",;                  // [01]  C   Nome do Campo
    "01",;                      // [02]  C   Ordem
    "Pedido",;                  // [03]  C   Titulo do campo
    X3Descric('Z7_NUM'),;       // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "C",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_NUM"),;       // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    Iif(INCLUI, .T., .F.),;    	// [10]  L   Indica se o campo ? alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op??o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo ? virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)                        // [18]  L   Indica pulo de linha ap?s o campo

oStCabec:AddField(;
    "Z7_EMISSAO",;                // [01]  C   Nome do Campo
    "02",;                      // [02]  C   Ordem
    "Emissao",;                  // [03]  C   Titulo do campo
    X3Descric('Z7_EMISSAO'),;    // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "D",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_EMISSAO"),;    // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo ? alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op??o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo ? virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)  

oStCabec:AddField(;
    "Z7_FORNECE",;                  // [01]  C   Nome do Campo
    "03",;                          // [02]  C   Ordem
    "Fornecedor",;                  // [03]  C   Titulo do campo
    X3Descric('Z7_FORNECE'),;       // [04]  C   Descricao do campo
    Nil,;                           // [05]  A   Array com Help
    "C",;                           // [06]  C   Tipo do campo
    X3Picture("Z7_FORNECE"),;       // [07]  C   Picture
    Nil,;                           // [08]  B   Bloco de PictTre Var
    "SA2",;                         // [09]  C   Consulta F3
    Iif(INCLUI, .T., .F.),;         // [10]  L   Indica se o campo ? alteravel
    Nil,;                           // [11]  C   Pasta do campo
    Nil,;                           // [12]  C   Agrupamento do campo
    Nil,;                           // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                           // [14]  N   Tamanho maximo da maior op??o do combo
    Nil,;                           // [15]  C   Inicializador de Browse
    Nil,;                           // [16]  L   Indica se o campo ? virtual
    Nil,;                           // [17]  C   Picture Variavel
    Nil) 

oStCabec:AddField(;
    "Z7_LOJA",;                 // [01]  C   Nome do Campo
    "04",;                      // [02]  C   Ordem
    "Loja",;                    // [03]  C   Titulo do campo
    X3Descric('Z7_LOJA'),;      // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "C",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_LOJA"),;      // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo ? alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op??o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo ? virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)

oStCabec:AddField(;
    "Z7_USER",;                 // [01]  C   Nome do Campo
    "05",;                      // [02]  C   Ordem
    "Usu?rio",;                 // [03]  C   Titulo do campo
    X3Descric('Z7_USER'),;      // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "C",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_USER"),;      // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    .F.,;                       // [10]  L   Indica se o campo ? alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior op??o do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo ? virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil) 


oStItens:RemoveField("Z7_NUM")
oStItens:RemoveField("Z7_EMISSAO")
oStItens:RemoveField("Z7_FORNECE")
oStItens:RemoveField("Z7_LOJA")
oStItens:RemoveField("Z7_USER")

oView   := FwFormView():New()
oView:SetModel(oModel)

oView:AddField("VIEW_SZ7M",oStCabec,"SZ7MASTER")
oView:AddGrid("VIEW_SZ7D",oStItens,"SZ7DETAIL")

oView:CreateHorizontalBox("CABEC",30)
oView:CreateHorizontalbox("GRID",60)

oView:SetOwnerView("VIEW_SZ7M","CABEC")
oView:SetOwnerView("VIEW_SZ7D","GRID")

oView:EnableTitleView("VIEW_SZ7M","Cabe?alho da solicita??o")
oView:EnableTitleView("VIEW_SZ7D","Itens de solicita??o")

oView:SetCloseonOk({|| .T.})



Return oView


User Function GrvSZ7()
Local aArea := GetArea()
Local lRet  := .T.

//Captura o modelo ativo, no caso o objeto de modelo (oModel) que est? sendo manipulado na aplica??o
Local oModel         :=  FwModelActive()
Local oModelCabec    :=  oModel:GetModel("SZ7MASTER") // Criar modelo de dados com base no model geral que foi capturado 
Local oModelItem     :=  oModel:GetModel("SZ7DETAIL") 

//Realizando a captura dos dados do cabe?alho 
Local cFilSz7       := oModelCabec:GetValue("Z7_FILIAL")      
Local cNum          := oModelCabec:GetValue("Z7_NUM")
Local dEmissao      := oModelCabec:GetValue("Z7_EMISSAO")
Local cFornece      := oModelCabec:GetValue("Z7_FORNECE")
Local cLoja         := oModelCabec:GetValue("Z7_LOJA")
Local cUser         := oModelCabec:GetValue("Z7_USER")

//Variaveis que irao faze a captura com base no aHeader e aCols 

Local aHeaderAux    := oModelItem:aHeader
Local aColsAux      := oModelItem:aCols 
Local nPosItem      := aScan (aHeaderAux, {|x| AllTrim(x[2]) == "Z7_ITEM"})
Local nPosProd      := aScan (aHeaderAux, {|x| AllTrim(x[2]) == "Z7_PRODUTO"})
Local nPosQtd       := aScan (aHeaderAux, {|x| AllTrim(x[2]) == "Z7_QUANT"})
Local nPosPrc       := aScan (aHeaderAux, {|x| AllTrim(x[2]) == "Z7_PRECO"})
Local nPosTotal     := aScan (aHeaderAux, {|x| AllTrim(x[2]) == "Z7_TOTAL"})

// Capturar a linha atual que o usu?rio est? posicionado
Local nLinAtu     := 0

//Identificar qual o tipo de operacao que o usuario est? fazendo (Inclus?o/Altera??o/Exclus?o)
Local cOption       := oModelCabec:GetOperation()

DBSelectArea("SZ7")
SZ7->(DbSetOrder(1))


If cOption == MODEL_OPERATION_INSERT
 //Antes de inserir, verificar se a linha está deletada 
    For nLinAtu := 1 to len(aColsAux)
        If !aColsAux[nLinAtu][len(aHeaderAux)+1] 
            RecLock("SZ7", .T.)
            Z7_FILIAL   := cFilSz7
            Z7_NUM      := cNum
            Z7_EMISSAO  := dEmissao
            Z7_FORNECE  := cFornece
            Z7_LOJA     := cLoja
            Z7_USER     := cUser
            Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
            Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
            Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
            Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
            Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]

            SZ7->(MsUnlock())

        ENDIF

    Next n

ElseIf cOption == MODEL_OPERATION_UPDATE

    For nLinAtu := 1 to len(aColsAux)
        If aColsAux[nLinAtu][len(aHeaderAux)+1] // Verifica se a linha está deletada
            SZ7->(DbSetOrder(2)) // realiza a busca por filial+numeropedido+item
            If SZ7->(DBSeek(cFilSZ7+cNum+aColsAux[nLinAtu,nPosItem])) // Localiza no banco para realizar o delet
                RecLock("SZ7",.F.)
                    DbDelete()
                SZ7->(MsUnlock())        
            ENDIF

        ELSE 
             SZ7->(DbSetOrder(2))
                IF SZ7->(DBSeek(cFilSZ7+cNum+aColsAux[nLinAtu,nPosItem]))
                    RecLock("SZ7",.F.) // Caso seja a alteracao de um item
                        Z7_FILIAL   := cFilSz7
                        Z7_NUM      := cNum
                        Z7_EMISSAO  := dEmissao
                        Z7_FORNECE  := cFornece
                        Z7_LOJA     := cLoja
                        Z7_USER     := cUser
                        Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
                        Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
                        Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
                        Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
                        Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]
                    SZ7->(MsUnlock())
                ELSE
                     RecLock("SZ7",.T.) // Caso seja uma inclusao de um novo item
                        Z7_FILIAL   := cFilSz7
                        Z7_NUM      := cNum
                        Z7_EMISSAO  := dEmissao
                        Z7_FORNECE  := cFornece
                        Z7_LOJA     := cLoja
                        Z7_USER     := cUser
                        Z7_ITEM     := aColsAux[nLinAtu,nPosItem]
                        Z7_PRODUTO  := aColsAux[nLinAtu,nPosProd]
                        Z7_QUANT    := aColsAux[nLinAtu,nPosQtd]
                        Z7_PRECO    := aColsAux[nLinAtu,nPosPrc]
                        Z7_TOTAL    := aColsAux[nLinAtu,nPosTotal]
                        SZ7->(MsUnlock())
                ENDIF
        ENDIF
    Next n
ENDIF

RestArea(aArea)
Return lRet 
