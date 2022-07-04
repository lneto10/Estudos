#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'

/*/{Protheus.doc} User Function BRWSZ9
description)
    @type  Function
    @author Luiz Neto
    @since 28/06/2022
    @see https://tdn.totvs.com/pages/releaseview.action?pageId=62390842
    @see https://centraldeatendimento.totvs.com/hc/pt-br/articles/360029127091-Cross-Segmento-TOTVS-Backoffice-Linha-Protheus-ADVPL-Op%C3%A7%C3%B5es-de-cores-na-legenda-da-Classe-FWMBROWSE
    
    /*/
User Function BRWSZ9()

Local aArea := GetNextAlias()
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
oBrowseSZ9:AddLegend("SZ9->Z9_STATUS=='1'","GREEN","Cadastro Ativo")
oBrowseSZ9:AddLegend("SZ9->Z9_STATUS=='2'","RED","Cadastro Inativo")

oBrowseSZ9:SetFilterDefault("SZ9->Z9_STATUS= '1'")




oBrowseSZ9:ACTIVATE()


RestArea()

Return 
