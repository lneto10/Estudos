#Include 'Protheus.ch'
#Include 'FwMvcDef.ch'

/*/{Protheus.doc} User Function MVCVLD
    Sistema de chamados utilizando MVC - Modelo 3 
    @type  Function
    @author Luiz Neto
    @since 18/07/2022
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function MVCVLD()
Local oBrowse   := FwLoadBrw("MVCVLD")    

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
Local oBrowse   := FwMBrowse():New()

oBrowse:SetAlias ("SZ2")
oBrowse:SetDescription("Cadastro de Chamados")

oBrowse:AddLegend("SZ2->Z2_STATUS == '1'", "GREEN", "Chamado Aberto")
oBrowse:AddLegend("SZ2->Z2_STATUS == '2'", "RED", "Chamado Encerrado")
oBrowse:AddLegend("SZ2->Z2_STATUS == '3'", "YELLOW", "Chamado Em Andamento")

// Deve definir de onde vira o Menudef 

oBrowse:SetMenuDef("MVCVLD") // Fonte de onde vira o Menu
RestArea (aArea)
Return oBrowse 

//Funcao para definir o menu 
Static Function MenuDef()
Local aMenu    := {} 
Local aMenuAut := FwMvcMenu("MVCVLD") 
Local n := 0

ADD OPTION aMenu TITLE 'Legenda'    ACTION 'u_zSZ2Leg'       OPERATION 6 ACCESS 0
ADD OPTION aMenu TITLE 'Sobre'      ACTION 'u_zSZ2Sobre'     OPERATION 6 ACCESS 0

//Utiliza o laco de repeticao para adicionar a variavel aMenu, o que foi criado com as linhas acima

For n := 1 to Len(aMenuAut)
    aAdd(aMenu,aMenuAut[n])
Next n


Return aMenu


Static Function ModelDef()
Local oModel        := MPFormModel():New("MVCVLDM"/*ID do modelo*/,/*{|oModel| MPreVld(oModel)}prevalidacao*/,{|oModel| MPosVld(oModel)},{|oModel| mComVld(oModel)},)
Local oStPaiZ2      := FwFormStruct (1,"SZ2")  
Local oSTFilhoZ3    := FwFormStruct (1,"SZ3")
Local aTrigUser     := {}



oStFilhoZ3:SetProperty("Z3_CHAMADO",MODEL_FIELD_INIT,FwBuildFeature(STRUCT_FEATURE_INIPAD, "SZ2->Z2_COD"))

//Criar a triger para carregar o nome do usuario 

aTrigUser  := FwStruTrigger(;
"Z2_USUARIO",; // Campo que ira disparar o gatilho
"Z2_USERNAM",; // Campo que ira receber o conteudo disparado
"USRRETNAME(M->Z2_USUARIO)",;
.F.) // Conteudo que ira para o campo Z7_TOTAL

oStPaiZ2:AddTrigger(;
aTrigUser[1],;
aTrigUser[2],;
aTrigUser[3],;
aTrigUser[4])

oModel:AddFields("SZ2MASTER",,oStPaiZ2)
oModel:AddGrid("SZ3DETAIL","SZ2MASTER",oSTFilhoZ3,,,,,)

oModel:SetVldActivate({|oModel|MActivVld(oModel)})

//Relaciona o cabeçalho com os itens, atraves dos campos FILIAL e codigo do chamado
oModel:SetRelation("SZ3DETAIL",{{"Z3_FILIAL","xFilial('SZ2')"},{"Z3_CHAMADO","Z2_COD"}},SZ3->(IndexKey(1)))

//Setamos a chave primaria
oModel:SetPrimaryKey({"Z3_FILIAL","Z3_CHAMADO","Z3_CODIGO"})
// Combinacao de campos que nao podem se repetir
oModel:GetModel("SZ3DETAIL"):SetUniqueLine({"Z3_CHAMADO","Z3_CODIGO"})

oModel:SetDescription("Modelo 3 - Sistema de Chamados")
oModel:GetModel("SZ2MASTER"):SetDescription("Cabeçalho do chamado")
oModel:GetModel("SZ3DETAIL"):SetDescription("Comentarios do chamado")

return oModel

Static Function ViewDef()
Local oView     := Nil

//Invoco o Model da função que quero
Local oModel    := FwLoadModel("MVCVLD")

/*
A grande diferença das estruturas de dados do modelo 2 para o modelo 3, é que no modelo 2
a estrutura de dados do cabeçalho é temporária/imaginária/fictícia, jáaaaaaaaa no modelo 3/x
todas as estruturas de dados, tendem à ser REAIS, ou seja, importamos via FwFormStruct, a(s) tabela(s)
propriamente ditas
*/
Local oStPaiZ2      := FwFormStruct(2,"SZ2")
Local oStFilhoZ3    := FwFormStruct(2,"SZ3")



//Removo o campo para não aparecer, já que ele estará sendo preenchido automaticamente pelo código do chamado do cabeçalho
oStFilhoZ3:RemoveField("Z3_CHAMADO")

//Travo o campo de Codigo para não ser editado, ou seja, o campo CODIGO DE COMENTARIO do chamado, será automático e não poderá ser modificado
oStFilhoZ3:SetProperty("Z3_CODIGO",    MVC_VIEW_CANCHANGE, .F.)

// Adiciona consulta padrao no campo codigo usuario
oStPaiZ2:SetProperty("Z2_USUARIO", MVC_VIEW_LOOKUP, "USR")

//Faço a instancia da função FwFormView para a variável oView
oView   := FwFormView():New()

//Carrego o model importado para a View
oView:SetModel(oModel)

//Crio as views de cabeçalho e item, com as estruturas de dados criadas acima
oView:AddField("VIEWSZ2",oStPaiZ2,"SZ2MASTER")
oView:AddGrid("VIEWSZ3",oStFilhoZ3,"SZ3DETAIL")

//Faço o campo de Item ficar incremental
oView:AddIncrementField("SZ3DETAIL","Z3_CODIGO") //Soma 1 ao campo de Item

//Criamos os BOX horizontais para CABEÇALHO E ITENS
oView:CreateHorizontalBox("CABEC",60)
oView:CreateHorizontalBox("GRID",40)

//Amarro as views criadas aos BOX criados
oView:SetOwnerView("VIEWSZ2","CABEC")
oView:SetOwnerView("VIEWSZ3","GRID")

//Darei títulos personalizados ao cabeçalho e comentários do chamado
oView:EnableTitleView("VIEWSZ2","Detalhes do Chamado/Cabeçalho")
oView:EnableTitleView("VIEWSZ3","Comentários do do chamado/Itens")

Return oView

User Function zSZ2Leg()
Local aLegenda := {}

aAdd(aLegenda,{"BR_VERDE","Chamado Aberto"})
aAdd(aLegenda,{"BR_AMARELHO","Chamado em Andamento"})
aAdd(aLegenda,{"BR_VERMELHO","Chamado Finalizado"})

BrwLegenda("Status dos cahmados",,aLegenda)

Return aLegenda 

User Function zSZ2Sobre()
Local cSobre 

cSobre := "Minha primeira tela em MVC Modelo 3 "+;
"Este sistema de chamados foi desenvolvido por Luiz Barboza Neto"

MsgInfo(cSobre,"Sobre o programador")

Return

Static Function MActivVld(oModel)
Local lRet := .T.
Local cUsersMVC := SUPERGETMV("MV_XUSMVC") 
Local cCodUser  := RetCodUsr()

IF !(cCodUser$cUsersMVC)

    lRet := .F. 
        Help(NIL, NIL, "MActivVld", NIL, "Usuário não autorizado",;
        1,0, NIL, NIL, NIL, NIL, NIL,{"Este usuário não está autorizado à realizar esta operação, vide parametro MV_XUSMVC"})

ELSE 
    IF cCodUser == "000000"
 
        oModel:GetModel("SZ2MASTER"):GetStruct():SetProperty("Z2_DATA", MODEL_FIELD_WHEN, FwBuildFeature(STRUCT_FEATURE_WHEN,".T."))
        oModel:GetModel("SZ2MASTER"):GetStruct():SetProperty("Z2_USUARIO", MODEL_FIELD_WHEN, FwBuildFeature(STRUCT_FEATURE_WHEN,".T."))

    ELSE

    oModel:GetModel("SZ2MASTER"):GetStruct():SetProperty("Z2_DATA", MODEL_FIELD_WHEN, FwBuildFeature(STRUCT_FEATURE_WHEN,".F."))
    oModel:GetModel("SZ2MASTER"):GetStruct():SetProperty("Z2_USUARIO", MODEL_FIELD_WHEN, FwBuildFeature(STRUCT_FEATURE_WHEN,".F."))
    endif
ENDIF


Return lRet


Static Function MPreVld(oModel)
Local lRet      := .T. 

//Alert ("Estamos passando pela pre validacao")

Return lRet 

//Funcao que executará na pós validação 
Static Function MPosVld (oModel)
Local lRet          := .T.
Local cTitChamado   := oModel:GetValue("SZ2MASTER","Z2_TITCHAM")
Local nLen          := Len(Alltrim(cTitChamado))

IF nLen < 14 
    Alert("Titulo do chamado esta incompleto","Ajustar titulo do chamado")
    lRet := .F.
ENDIF


Return lRet

//Funcao que realizara o commit no model
Static Function MComVld(oModel)
Local lRet := .T. 

Alert("Funcao de Commit")
FwFormCommit (oModel)

Return lRet
