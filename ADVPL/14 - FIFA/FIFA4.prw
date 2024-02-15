#Include	"Protheus.Ch"
#Include	"FWMVCDef.Ch"    

#Define     TITULO  "Cadastro de TransferÍncia "

/*/{Protheus.doc} FIFA4  

Tela em MVC para Cadastro de times para as rotinas de movimentaùùo de pessoal e recrutamento e seleùùo

@author	Luiz Neto
@since 	15/03/2023

/*/ 
User Function FIFA4()
    Local oBrowse	:= Nil    
						
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ3")
	oBrowse:SetDescription(TITULO)
	oBrowse:SetMenuDef("FIFA4")
	oBrowse:DisableDetails()	
    oBrowse:Activate()	
        
Return()

/*
    Define as opcoes do aRotina.
*/ 
Static Function MenuDef()
	Local aRotina	:= {}
	
	ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.FIFA4' 	OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE 'Incluir'    	ACTION 'VIEWDEF.FIFA4' 	OPERATION 3 ACCESS 0
	ADD OPTION aRotina TITLE 'Alterar'    	ACTION 'VIEWDEF.FIFA4' 	OPERATION 4 ACCESS 0
	ADD OPTION aRotina TITLE 'Excluir'    	ACTION 'VIEWDEF.FIFA4' 	OPERATION 5 ACCESS 0

Return(aRotina)

/*
    Define o Modelo de Interface.
*/ 
Static Function ModelDef()
	Local oStruZZ3  := FWFormStruct( 1, "ZZ3", /*bAvalCampo*/,/*lViewUsado*/ )	
	Local oModel	:= Nil
			
	oModel:= MPFormModel():New("FIF4",/*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/ , /*bCancel*/ )	
	oModel:SetDescription(TITULO)	
	oModel:AddFields( "ZZ3MASTER"	, /*cOwner*/	, oStruZZ3, /*bPreValidacao*/	, /*bPosZ00*/	, /*bCarga*/ )	    
	oModel:GetModel( "ZZ3MASTER" ):SetDescription( TITULO       )	    
    oModel:SetVldActivate( { |oModel| validaModelo( oModel ) } )
    oModel:SetPrimaryKey( {"ZZ3_FILIAL+ZZ3_CODIGO"} )

    			
Return(oModel) 

/*
    Define a View da Interface
*/ 
Static Function ViewDef()		
	Local oView		:= Nil
	Local oModel 	:= ModelDef()
	Local oStruZZ3	:= FWFormStruct(2,"ZZ3") 	
		
	oView:= FWFormView():New()                          	
	oView:SetModel( oModel )		
	oView:AddField(	"VIEW_ZZ3"	, oStruZZ3	, "ZZ3MASTER" 	)        			
	oView:CreateHorizontalBox( 'BOX0101' 	, 100, , , , )	
	oView:SetOwnerView( "VIEW_ZZ3", "BOX0101" 	)
    					
Return(oView)    

/*
    Realiza validacao na ativacao do Modelo de Dados.
*/ 
Static Function validaModelo(oModel)
    Local aArea     := GetArea()    
    RestArea(aArea)
Return(.T.)

