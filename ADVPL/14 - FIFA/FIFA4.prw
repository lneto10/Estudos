#Include	"Protheus.Ch"
#Include	"FWMVCDef.Ch"    

#Define     TITULO  "Cadastro de Transferência "

/*/{Protheus.doc} FIFA4  

Tela em MVC para Cadastro de times 

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
	Local bVldPos   := {|| u_FIFA4A(oModel)}
			
	oModel:= MPFormModel():New("FIF4",/*bPreValidacao*/, bVldPos/*bPosValidacao*/, /*bCommit*/ , /*bCancel*/ )	
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

/* 
	Atualiza status dos jogadores 

*/ 
User Function FIFA4A(oModel)


Local oModel    := FwModelActive()
Local nOpc      := oModel:GetOperation()
Local cCodigo   := oModel:GetValue("ZZ3MASTER","ZZ3_CODJOG")

if nOpc == 3 .or. nOpc == 4

	if oModel:GetValue("ZZ3MASTER","ZZ3_TIPO") == "S"
		dbselectarea("ZZ0")
		ZZ0->(DbSetOrder(1))
			if ZZ0->(DbSeek(xFilial("ZZ0")+cCodigo))
				RecLock("ZZ0",.F.)
					ZZ0->ZZ0_ATIVO 	:= "2"
					ZZ0->ZZ0_DATA  	:= oModel:GetValue("ZZ3MASTER","ZZ3_DATA")
					ZZ0->ZZ0_CODTIM := oModel:GetValue("ZZ3MASTER","ZZ3_TIME")
					ZZ0->ZZ0_TIME 	:= oModel:GetValue("ZZ3MASTER","ZZ3_NOMTIM")
					ZZ0->ZZ0_VALOR  := oModel:GetValue("ZZ3MASTER","ZZ3_VALOR")
				ZZ0->(MsUnlock())
			endif
		ZZ0->(DbCloseArea())
	elseif oModel:GetValue("ZZ3MASTER","ZZ3_TIPO") == "E"
	dbselectarea("ZZ0")
		ZZ0->(DbSetOrder(1))
			if ZZ0->(DbSeek(xFilial("ZZ0")+cCodigo))
				RecLock("ZZ0",.F.)
					ZZ0->ZZ0_ATIVO 	:= "1"
					ZZ0->ZZ0_DATA  	:= oModel:GetValue("ZZ3MASTER","ZZ3_DATA")
					ZZ0->ZZ0_CODTIM := oModel:GetValue("ZZ3MASTER","ZZ3_TIME")
					ZZ0->ZZ0_TIME 	:= oModel:GetValue("ZZ3MASTER","ZZ3_NOMTIM")
					ZZ0->ZZ0_VALOR  := oModel:GetValue("ZZ3MASTER","ZZ3_VALOR")

				ZZ0->(MsUnlock())
			endif
		ZZ0->(DbCloseArea())
	endif
endif

Return .T.
