#Include	"Protheus.Ch"
#Include	"FWMVCDef.Ch"    

#Define     TITULO  "Cadastro de Jogadores "

/*/{Protheus.doc} FIFA1  

Tela em MVC para Cadastro de funùùes para as rotinas de movimentaùùo de pessoal e recrutamento e seleùùo

@author	Luiz Neto
@since 	15/03/2023

/*/ 
User Function FIFA1()
    Local oBrowse	:= Nil    
						
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ0")
	oBrowse:SetDescription(TITULO)
	oBrowse:SetMenuDef("FIFA1")
	oBrowse:DisableDetails()	
    oBrowse:Activate()	
        
Return()

/*
    Define as opcoes do aRotina.
*/ 
Static Function MenuDef()
	Local aRotina	:= {}
	
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.FIFA1' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    	ACTION 'VIEWDEF.FIFA1' 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.FIFA1' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.FIFA1' 	OPERATION 5 ACCESS 0

Return(aRotina)

/*
    Define o Modelo de Interface.
*/ 
Static Function ModelDef()
	Local oStruZZ0  := FWFormStruct( 1, "ZZ0", /*bAvalCampo*/,/*lViewUsado*/ )	
	Local oModel	:= Nil
			
	oModel:= MPFormModel():New("FIF1",/*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/ , /*bCancel*/ )	
	oModel:SetDescription(TITULO)	
	oModel:AddFields( "ZZ0MASTER"	, /*cOwner*/	, oStruZZ0, /*bPreValidacao*/	, /*bPosZ00*/	, /*bCarga*/ )	    
	oModel:GetModel( "ZZ0MASTER" ):SetDescription( TITULO       )	    
    oModel:SetVldActivate( { |oModel| validaModelo( oModel ) } )
    oModel:SetPrimaryKey( {"ZZ0_FILIAL+ZZ0_CODIGO"} )

    			
Return(oModel) 

/*
    Define a View da Interface
*/ 
Static Function ViewDef()		
	Local oView		:= Nil
	Local oModel 	:= ModelDef()
	Local oStruZZ0	:= FWFormStruct(2,"ZZ0") 	
		
	oView:= FWFormView():New()                          	
	oView:SetModel( oModel )		
	oView:AddField(	"VIEW_ZZ0"	, oStruZZ0	, "ZZ0MASTER" 	)        			
	oView:CreateHorizontalBox( 'BOX0101' 	, 100, , , , )	
	oView:SetOwnerView( "VIEW_ZZ0", "BOX0101" 	)
    					
Return(oView)    

/*
    Realiza validacao na ativacao do Modelo de Dados.
*/ 
Static Function validaModelo(oModel)
    Local aArea     := GetArea()    
    RestArea(aArea)
Return(.T.)

