#Include 'Protheus.ch'
#Include 'Totvs.ch'

User Function FIFA5()

    DbSelectArea("ZZ3")
    DbSetOrder(1)
    
    While !ZZ3->(Eof())
        DbSelectArea("ZZ0")
        DbSetOrder(1)
        IF ZZ0->(DbSeek(xFilial("ZZ0")+ZZ3->ZZ3_CODJOG))
            if ZZ3->ZZ3_TIPO == "S"
                RecLock("ZZ0",.F.)
					ZZ0->ZZ0_ATIVO 	:= "2"
					ZZ0->ZZ0_DATA  	:= ZZ3->ZZ3_DATA 
					ZZ0->ZZ0_CODTIM := ZZ3->ZZ3_TIME 
					ZZ0->ZZ0_TIME 	:= ZZ3->ZZ3_NOMTIM 
					ZZ0->ZZ0_VALOR  := ZZ3->ZZ3_VALOR 
				ZZ0->(MsUnlock())
            elseif ZZ3->ZZ3_TIPO == "E"
                RecLock("ZZ0",.F.)
                    ZZ0->ZZ0_ATIVO 	:= "1"
                    ZZ0->ZZ0_DATA  	:= ZZ3->ZZ3_DATA 
                    ZZ0->ZZ0_CODTIM := ZZ3->ZZ3_TIME 
                    ZZ0->ZZ0_TIME 	:= ZZ3->ZZ3_NOMTIM 
                    ZZ0->ZZ0_VALOR  := ZZ3->ZZ3_VALOR 
                ZZ0->(MsUnlock())
            endif
        ENDIF
        ZZ0->(DbCloseArea())
    ZZ3->(DbSkip())
    End
    ZZ3->(DbCloseArea())

Return
