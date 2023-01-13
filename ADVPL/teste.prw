"BX TITULO "+SE5->E5_PREFIXO+" - "+SE5->E5_NUMERO+" - "+SE5->E5_BENEF


IIF(ALLTRIM(SE5->E5_TIPO)=="PA".AND. SE5->E5_PREFIXO=="EIC",SE5->E5_VALOR,0)

IIF(ALLTRIM(SE5->E5_TIPO)=="INV" .AND. SE5->E5_PREFIXO == "EIC",SE5->E5_VALOR,0)

IIF(ALLTRIM(SE5->E5_TIPO)=="INV" .AND. SE5->E5_PREFIXO== "EIC" .AND. ALLTRIM(SE5->E5_TIPODOC)=="VL",SE5->E5_VALOR,0)

"TIT ANTECIPADO IMP. "+" -"+SE2->E2_PREFIXO+"-"+SE2->E2_NUM+" FORNECEDOR: "+SE2->E2_NOMFOR                                                                                                                                                                                          

"BX PG. ANTEC. IMP. TITULO "+SE5->E5_PREFIXO+" - "+SE5->E5_NUMERO+" - "+SE5->E5_BENEF                                                                                                                                                                          

"DEBITO SALDO PR "+SE5->E5_PREFIXO+" - "+SE5->E5_NUMERO+" - "+SE5->E5_BENEF

(SE2->E2_VALOR)*5,40

POSICIONE("SE2",1,xFilial("SE2")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_FORNECE+SE5->E5_LOJA,"E2_VALOR")


    IIF(ALLTRIM(SE5->E5_TIPO)=="INV" .AND. SE5->E5_PREFIXO== "EIC" .AND. ALLTRIM(SE5->E5_TIPODOC)=="VL",POSICIONE("SE2",1,xFilial("SE2")+SE5->E5_PREFIXO+SE5->E5_NUMERO+SE5->E5_PARCELA+SE5->E5_TIPO+SE5->E5_FORNECE+SE5->E5_LOJA,"E2_VALOR")*5.40,0)
POSICIONE("SRV",1,XFILIAL("SRV")+SRR->RR_PD,"RV_ZZCO")      


IIF(SE5->E5_PREFIXO == "PED",SE5->E5_VALOR,0)


IIF(SE1->E1_ORIGEM=="LOJA701",SE1->E1_VALOR,0) // teste                                                                                                                                                                                                           

"TIT ANTEC. IMPORTACAO. "+" -"+SE2->E2_PREFIXO+"-"+SE2->E2_NUM+" FORNECEDOR: "+SE2->E2_NOMFOR

IIF(!ALLTRIM(SE2->E2_TIPO)$"PR,PA".AND.ALLTRIM(SE2->E2_ORIGEM)$"FINA050,FINA960",SE2->E2_VLCRUZ,0)

"ESTORNO VLR PA REF TIT "+SE2->E2_PREFIXO+"-"+SE2->E2_NUM+" FORNECEDOR: "+SE2->E2_NOMFOR

IIF(SE2->E2_PREFIXO=="EIC" .AND. AllTrim(SE2->E2_TIPO)=="PA",SE2->E2_VLCRUZ,0)

IIF(SE5->E5_TIPO=="PA" .AND. SE5->E5_RECPAG=="R" .AND. SE5->E5_PREFIXO == "EIC",SE5->E5_VALOR,0)

IIF(SE1->E1_ORIGEM=="LOJA701",SE1->E1_VALOR,0)
