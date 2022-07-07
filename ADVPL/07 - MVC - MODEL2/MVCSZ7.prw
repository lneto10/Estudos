#Include 'Protheus.ch'
#Include 'FwMvcDef.ch'

/*/{Protheus.doc} User Function MVCSZ7
    Função principal para tela de solicitacao de compras da empresa em MVC Model 2 
    @type  Function
    @author Luiz Neto
    @since 04/07/2022
    @see (links_or_references)
    /*/
User Function MVCSZ7()
Local aArea     := GetArea()

/* Realiza o instanciamento da classe FWMBrowse, 
passando para o oBrowse a possibilidade de executar todos os métodos da classe*/
Local oBrowse   := FwmBrowse():New() 
oBrowse:SetAlias("SZ7")
oBrose:SetDescription("Solicitação de Compra")
oBrowse:Activate()
RestArea(aArea)
    
Return 
/*Static function responsavel pela criação do modelo de dados
https://tdn.totvs.com/display/framework/FWFormModelStruct
https://tdn.totvs.com/display/framework/FWFormStruct
https://tdn.totvs.com/display/framework/MPFormModel
https://tdn.totvs.com/display/framework/FWBuildFeature
https://tdn.totvs.com/display/framework/FWFormGridModel*/

Static Function ModelDef()
//Objeto responsavel pela criação temporária do cabeçalho 
Local oStCabec := FWFormModelStruct():New()
//Estrutura responsavel pelos itens 
Local oStItens := FwFormStruct(1,"SZ7")
/*Objeto principal do desenvolvimento em MVC MODELO 2, ele traz as caracteristicas do dicionario de dados
 bem como é o responsável pela estrutura de tabelas, campos e registros */
Local oModel   := MPFormModel ("MVCSZ7M",,,,)
//Criação da tabela temporaria que será utilizado no cabeçalho 
oStCabec:AddTable("SZ7",{"Z7_FILIAL","Z7_NUM","Z7_ITEM"},"Cabeçalho SZ7")
//Criação dos campos da tabela temporária
oStCabec:AddField(;
    "Filial",;                                                                                  // [01]  C   Titulo do campo
    "Filial",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_FILIAL",;                                                                               // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FILIAL")[1],;                                                                    // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de validação do campo
    Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FILIAL,FWxFilial('SZ7'))" ),;   // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                                        // [14]  L   Indica se o campo é virtual
oStCabec:AddField(;
    "Pedido",;                                                                                  // [01]  C   Titulo do campo
    "Pedido",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_NUM",;                                                                                  // [03]  C   Id do Field
    "C",;                                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_NUM")[1],;                                                                       // [05]  N   Tamanho do campo
    0,;                                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                                       // [07]  B   Code-block de validação do campo
    Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
    {},;                                                                                        // [09]  A   Lista de valores permitido do campo
    .F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_NUM,'')" ),;                    // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                                        // [14]  L   Indica se o campo é virtual
oStCabec:AddField(;
    "Emissao",;                                                                                    // [01]  C   Titulo do campo
    "Emissao",;                                                                                     // [02]  C   ToolTip do campo
    "Z7_EMISSAO",;                                                                                  // [03]  C   Id do Field
    "D",;                                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_EMISSAO")[1],;                                                                       // [05]  N   Tamanho do campo
    0,;                                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                                           // [07]  B   Code-block de validação do campo
    Nil,;                                                                                           // [08]  B   Code-block de validação When do campo
    {},;                                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                                           // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_EMISSAO,dDataBase)" ),;             // [11]  B   Code-block de inicializacao do campo
    .T.,;                                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                                           // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                                            // [14]  L   Indica se o campo é virtual
oStCabec:AddField(;
    "Fornecedor",;                                                                                  // [01]  C   Titulo do campo
    "Fornecedor",;                                                                                  // [02]  C   ToolTip do campo
    "Z7_FORNECE",;                                                                      // [03]  C   Id do Field
    "C",;                                                                       // [04]  C   Tipo do campo
    TamSX3("Z7_FORNECE")[1],;                                                   // [05]  N   Tamanho do campo
    0,;                                                                         // [06]  N   Decimal do campo
    Nil,;                                                                       // [07]  B   Code-block de validação do campo
    Nil,;                                                                       // [08]  B   Code-block de validação When do campo
    {},;                                                                        // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_FORNECE,'')" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                       // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                        // [14]  L   Indica se o campo é virtual
oStCabec:AddField(;
    "Loja",;                                                                      // [01]  C   Titulo do campo
    "Loja",;                                                                      // [02]  C   ToolTip do campo
    "Z7_LOJA",;                                                                   // [03]  C   Id do Field
    "C",;                                                                         // [04]  C   Tipo do campo
    TamSX3("Z7_LOJA")[1],;                                                        // [05]  N   Tamanho do campo
    0,;                                                                           // [06]  N   Decimal do campo
    Nil,;                                                                         // [07]  B   Code-block de validação do campo
    Nil,;                                                                         // [08]  B   Code-block de validação When do campo
    {},;                                                                          // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_LOJA,'')" ),;     // [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)                                                                          // [14]  L   Indica se o campo é virtual
oStCabec:AddField(;
    "Usuario",;                                                                     // [01]  C   Titulo do campo
    "Usuario",;                                                                     // [02]  C   ToolTip do campo
    "Z7_USER",;                                                                     // [03]  C   Id do Field
    "C",;                                                                           // [04]  C   Tipo do campo
    TamSX3("Z7_USER")[1],;                                                          // [05]  N   Tamanho do campo
    0,;                                                                             // [06]  N   Decimal do campo
    Nil,;                                                                           // [07]  B   Code-block de validação do campo
    Nil,;                                                                           // [08]  B   Code-block de validação When do campo
    {},;                                                                            // [09]  A   Lista de valores permitido do campo
    .T.,;                                                                           // [10]  L   Indica se o campo tem preenchimento obrigatório
    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,SZ7->Z7_USER,__cuserid)" ),;// [11]  B   Code-block de inicializacao do campo
    .F.,;                                                                           // [12]  L   Indica se trata-se de um campo chave
    .F.,;                                                                           // [13]  L   Indica se o campo pode receber valor em uma operação de update.
    .F.)
    //Tratar a estrutura dos itens, que serão utilizados no GRID da aplicação. 
    //Modificando inicializadores padrão
    oStItens:SetProperty("Z7_NUM",      MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD,'"*"'))
    oStItens:SetProperty("Z7_USER",     MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD,'"__cUserId"'))
    oStItens:SetProperty("Z7_EMISSAO",  MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD,'"dDatabase"'))
    oStItens:SetProperty("Z7_FORNECE",  MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD,'"*"'))
    oStItens:SetProperty("Z7_LOJA",     MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD,'"*"'))


/* A partir daqui é feito a união das estruturas, vinculando cabeçalho com itens 
e também a vinculação da estrutura de dados dos itens ao modelo*/

oModel:AddFields("SZ7MASTER",,oStCabec) // Realizado a vinculacao com o oStCabec 
oModel:AddGrid("SZ7DETAIL","SZ7MASTER",oStItens,,,,,)

oModel:SetRelation("SZ7DETAIL",{{"Z7_FILIAL","'Iif(!INCLUI, SZ7->Z7_FILIAL, FwxFilial('SZ7'))'"},{"Z7_NUM","SZ7_NUM"}},SZ7->(IndexKey(1)))

oModel:SetPrimaryKey({})

oModel:GetModel("SZ7DETAIL"):SetUniqueline("Z7_ITEM") // Esse campo nao se repita 

oModel:SetDescription("Modelo 2")

oModel:GetModel("SZ7MASTER"):SetDescription("Cabeçalho da solicitação de compras") // Descricao do cabeçalho
oModel:GetModel("SZ7DETAILS"):SetDescription("Itens da Solicitação de Compras") // Descricao dos itens da solicitação

//Finalizamos a funcao oModel
oModel:GetModel("SZ7MASTER"):SetUsedOldGrid(.T.) // Finaliza setando o modelo antigo de grid, que permite utilizar o aHeader e o aCols

    

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
    Iif(INCLUI, .T., .F.),;    	// [10]  L   Indica se o campo é alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo é virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)                        // [18]  L   Indica pulo de linha após o campo

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
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo é virtual
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
    Iif(INCLUI, .T., .F.),;         // [10]  L   Indica se o campo é alteravel
    Nil,;                           // [11]  C   Pasta do campo
    Nil,;                           // [12]  C   Agrupamento do campo
    Nil,;                           // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                           // [14]  N   Tamanho maximo da maior opção do combo
    Nil,;                           // [15]  C   Inicializador de Browse
    Nil,;                           // [16]  L   Indica se o campo é virtual
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
    Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo é virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil)

oStCabec:AddField(;
    "Z7_USER",;                 // [01]  C   Nome do Campo
    "05",;                      // [02]  C   Ordem
    "Usuário",;                 // [03]  C   Titulo do campo
    X3Descric('Z7_USER'),;      // [04]  C   Descricao do campo
    Nil,;                       // [05]  A   Array com Help
    "C",;                       // [06]  C   Tipo do campo
    X3Picture("Z7_USER"),;      // [07]  C   Picture
    Nil,;                       // [08]  B   Bloco de PictTre Var
    Nil,;                       // [09]  C   Consulta F3
    .F.,;                       // [10]  L   Indica se o campo é alteravel
    Nil,;                       // [11]  C   Pasta do campo
    Nil,;                       // [12]  C   Agrupamento do campo
    Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
    Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
    Nil,;                       // [15]  C   Inicializador de Browse
    Nil,;                       // [16]  L   Indica se o campo é virtual
    Nil,;                       // [17]  C   Picture Variavel
    Nil) 


oStItens:RemoveFild("Z7_NUM")
oStItens:RemoveField("Z7_EMISSAO")
oStItens:RemoveField("Z7_FORNECE")
oStItens:RemoveField("Z7_LOJA")
oStItens:RemoveField("Z7_USER")

oView   := FwFormView():New()
oView:SetModel(oModel)

oView:AddField("VIEW_SZ7M",oStCabec,"SZ7MASTER")
oView:AddGrid("VIEW_SZ7D",oStItens,"SZ7DETAIL")

oView:CreateHorizontalBox("CABEC",40)
oView:CreateHorizontalbox("GRID",30)

oView:SetOwnerView("VIEW_SZ7M","CABEC")
oView:SetOwnerView("VIEW_SZ7D","GRID")

oView:EnableTitleView("VIEW_SZ7M","Cabeçalho da solicitação")
oView:EnableTitleView("VIEW_SZ7D","Itens de solicitação")

oView:SetCloseonOk({|| .T.})



Return oView
