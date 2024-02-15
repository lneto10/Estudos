//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
  
//Variùveis Estùticas
Static cTitulo := "Sumulas"
  
/*/{Protheus.doc} FIFA3
Cadastro de candidatos
@author Luiz Neto
@since 10/04/2023
@version 1.0
    @return Nil, Funùùo nùo tem retorno
    @example
    u_FIFA3()
/*/
  
User Function FIFA3()
    Local aArea   := GetArea()
    Local oBrowse
    Local cFunBkp := FunName()
     
    SetFunName("FIFA3")
     
    //Instùnciando FWMBrowse
    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias("ZZ4")
    oBrowse:AddLegend( "ZZ4_RESULT == 'V'"		, "Green"			, "VitÛria"  		)
    oBrowse:AddLegend( "ZZ4_RESULT == 'E'"		, "Blue"			, "Empate"  		)
    oBrowse:AddLegend( "ZZ4_RESULT == 'D'"		, "BR_CANCEL"			, "Derrota"  		)
    oBrowse:SetDescription(cTitulo)
    oBrowse:Activate()
     
    SetFunName(cFunBkp)
    RestArea(aArea)
Return Nil
 
/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Desc:  Criaùùo do menu MVC                                          |
 *---------------------------------------------------------------------*/
  
Static Function MenuDef()
    Local aRotina := {}
     
    //Adicionando opùùes
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.FIFA3' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    	ACTION 'VIEWDEF.FIFA3' 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.FIFA3' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.FIFA3' 	OPERATION 5 ACCESS 0

Return aRotina
  
/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Desc:  Criaùùo do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
  
Static Function ModelDef()
    Local oModel     := Nil
    Local oStPai     := FWFormStruct(1, 'ZZ4')
    Local oStFilho1  := FWFormStruct(1, 'ZZ5')
    //Local oStFilho2  := FWFormStruct(1, 'SB1')
    Local aRelFilho1 := {}
   // Local aRelFilho2 := {}
     
    //Criando o modelo
    oModel := MPFormModel():New('FIF3')
    oModel:AddFields('ZZ4_MASTER', /*cOwner*/, oStPai)
     
    //Criando as grids dos filhos
    oModel:AddGrid('ZZ5_FILHO1', 'ZZ4_MASTER', oStFilho1)
    //oModel:AddGrid('SB1_FILHO2', 'SBM_MASTER', oStFilho2)
     
    //Criando os relacionamentos dos pais e filhos
    aAdd(aRelFilho1, {'ZZ5_FILIAL', 'ZZ4_FILIAL'})
    aAdd(aRelFilho1, {'ZZ5_CODSUM',  'ZZ4_CODIGO'})
    //aAdd(aRelFilho1, {'B1_LOCPAD', '00'})
    //aAdd(aRelFilho2, {'B1_FILIAL', 'BM_FILIAL'})
    //aAdd(aRelFilho2, {'B1_GRUPO',  'BM_GRUPO'})
    //aAdd(aRelFilho2, {'B1_LOCPAD', '01'})
     
    //Criando o relacionamento do Filho 1
    oModel:SetRelation('ZZ5_FILHO1', aRelFilho1, ZZ5->(IndexKey(1)))
    oModel:GetModel('ZZ5_FILHO1'):SetUniqueLine({"ZZ5_FILIAL","ZZ5_CODSUM","ZZ5_ITEM"})
     
    //Criando o relacionamento do Filho 2
   // oModel:SetRelation('SB1_FILHO2', aRelFilho2, SB1->(IndexKey(1)))
    //oModel:GetModel('SB1_FILHO2'):SetUniqueLine({"B1_FILIAL","B1_COD"})
     
    //Finaliznado a criaùùo do Model
    oModel:SetPrimaryKey({})
    oModel:SetDescription("Cadastro de Candidatos")
    oModel:GetModel('ZZ4_MASTER'):SetDescription('Modelo Candidato')
    oModel:GetModel('ZZ5_FILHO1'):SetDescription('Historico Profissional')
   // oModel:GetModel('SB1_FILHO2'):SetDescription('Modelo Prod. Arm. 01')
Return oModel
  
/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Desc:  Criaùùo da visùo MVC                                         |
 *---------------------------------------------------------------------*/
  
Static Function ViewDef()
    Local oView     := Nil
    Local oModel    := FWLoadModel('FIFA3')
    Local oStPai    := FWFormStruct(2, 'ZZ4')
    Local oStFilho1 := FWFormStruct(2, 'ZZ5')
    //Local oStFilho2 := FWFormStruct(2, 'SB1')
     
    //Criando a View
    oView := FWFormView():New()
    oView:SetModel(oModel)

	oStFilho1:RemoveField('ZZ5_CODSUM')

    oStFilho1:SetProperty("ZZ5_ITEM",         MVC_VIEW_CANCHANGE, .F.)

     
    //Adicionando os campos do cabeùalho
    oView:AddField('VIEW_ZZ4', oStPai, 'ZZ4_MASTER')
     
    //Grids dos filhos
    oView:AddGrid('VIEW_FILHO1', oStFilho1, 'ZZ5_FILHO1')
    //oView:AddGrid('VIEW_FILHO2', oStFilho2, 'SB1_FILHO2')

	oView:AddIncrementField( "ZZ5_FILHO1", "ZZ5_ITEM" )
     
    //Setando o dimensionamento de tamanho
    oView:CreateHorizontalBox('SUPERIOR', 60)
    oView:CreateHorizontalBox('INFERIOR', 40)
     
    //Criando a folder dos produtos (filhos)
    oView:CreateFolder('PASTA_FILHOS', 'INFERIOR')
    oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO01', "Histùrico Profissional")
    //oView:AddSheet('PASTA_FILHOS', 'ABA_FILHO02', "Armazùm 01")
     
    //Criando os vinculos onde serùo mostrado os dados
    oView:CreateHorizontalBox('ITENS_FILHO01', 100,,, 'PASTA_FILHOS', 'ABA_FILHO01' )
    //oView:CreateHorizontalBox('ITENS_FILHO02', 100,,, 'PASTA_FILHOS', 'ABA_FILHO02' )
     
    //Amarrando a view com as box
    oView:SetOwnerView('VIEW_ZZ4',    'SUPERIOR')
    oView:SetOwnerView('VIEW_FILHO1', 'ITENS_FILHO01')
    //oView:SetOwnerView('VIEW_FILHO2', 'ITENS_FILHO02')
Return oView
