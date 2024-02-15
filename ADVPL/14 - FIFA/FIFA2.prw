#Include	"Protheus.Ch"
#Include	"FWMVCDef.Ch"    

#Define     TITULO  "Cadastro de Times "

/*/{Protheus.doc} FIFA2  

Tela em MVC para Cadastro de times para as rotinas de movimentaùùo de pessoal e recrutamento e seleùùo

@author	Luiz Neto
@since 	15/03/2023

/*/ 
User Function FIFA2()
    Local oBrowse	:= Nil    
						
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ1")
	oBrowse:SetDescription(TITULO)
	oBrowse:SetMenuDef("FIFA2")
	oBrowse:DisableDetails()	
    oBrowse:Activate()	
        
Return()

/*
    Define as opcoes do aRotina.
*/ 
Static Function MenuDef()
	Local aRotina	:= {}
	
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.FIFA2' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    	ACTION 'VIEWDEF.FIFA2' 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.FIFA2' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.FIFA2' 	OPERATION 5 ACCESS 0

Return(aRotina)

/*
    Define o Modelo de Interface.
*/ 
Static Function ModelDef()
	Local oStruZZ1  := FWFormStruct( 1, "ZZ1", /*bAvalCampo*/,/*lViewUsado*/ )	
	Local oModel	:= Nil
			
	oModel:= MPFormModel():New("FIF2",/*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/ , /*bCancel*/ )	
	oModel:SetDescription(TITULO)	
	oModel:AddFields( "ZZ1MASTER"	, /*cOwner*/	, oStruZZ1, /*bPreValidacao*/	, /*bPosZ00*/	, /*bCarga*/ )	    
	oModel:GetModel( "ZZ1MASTER" ):SetDescription( TITULO       )	    
    oModel:SetVldActivate( { |oModel| validaModelo( oModel ) } )
    oModel:SetPrimaryKey( {"ZZ1_FILIAL+ZZ1_CODIGO"} )

    			
Return(oModel) 

/*
    Define a View da Interface
*/ 
Static Function ViewDef()		
	Local oView		:= Nil
	Local oModel 	:= ModelDef()
	Local oStruZZ1	:= FWFormStruct(2,"ZZ1") 	
		
	oView:= FWFormView():New()                          	
	oView:SetModel( oModel )		
	oView:AddField(	"VIEW_ZZ1"	, oStruZZ1	, "ZZ1MASTER" 	)        			
	oView:CreateHorizontalBox( 'BOX0101' 	, 100, , , , )	
	oView:SetOwnerView( "VIEW_ZZ1", "BOX0101" 	)
    					
Return(oView)    

/*
    Realiza validacao na ativacao do Modelo de Dados.
*/ 
Static Function validaModelo(oModel)
    Local aArea     := GetArea()    
    RestArea(aArea)
Return(.T.)

