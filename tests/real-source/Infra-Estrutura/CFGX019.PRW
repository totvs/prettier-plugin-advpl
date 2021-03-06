#include "error.ch"
#include "CFGX019.ch"
#include "FWMVCDEF.CH"
/*/
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������Ŀ��
���Fun��o    � CFGX019  � Autor � Ary Medeiros           � Data � 10/02/92 ���
��������������������������������������������������������������������������Ĵ��
���Descri��o � Programa de atualizacao do cadastro de Formulas             ���
��������������������������������������������������������������������������Ĵ��
���Sintaxe   � Void CFGX019(void)                                          ���
��������������������������������������������������������������������������Ĵ��
���Parametros�                                                             ���
��������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                    ���
���������������������������������������������������������������������������ٱ�
������������������������������������������������������������������������������
������������������������������������������������������������������������������
/*/
Function CFGX019

	If	GetRpoRelease() >= "R7"
		DEFINE FWMBROWSE oMBrowse ALIAS "SM4"
		ACTIVATE FWMBROWSE oMBrowse
	Else
		//��������������������������������������������������������������Ŀ
		//� Define Array contendo as Rotinas a executar do programa      �
		//� ----------- Elementos contidos por dimensao ------------     �
		//� 1. Nome a aparecer no cabecalho                              �
		//� 2. Nome da Rotina associada                                  �
		//� 3. Usado pela rotina                                         �
		//� 4. Tipo de Transa��o a ser efetuada                          �
		//�    1 - Pesquisa e Posiciona em um Banco de Dados             �
		//�    2 - Simplesmente Mostra os Campos                         �
		//�    3 - Inclui registros no Bancos de Dados                   �
		//�    4 - Altera o registro corrente                            �
		//�    5 - Remove o registro corrente do Banco de Dados          �
		//����������������������������������������������������������������
		PRIVATE aRotina := MenuDef()

		//��������������������������������������������������������������Ŀ
		//� Define o cabecalho da tela de atualizacoes                   �
		//����������������������������������������������������������������
		PRIVATE cCadastro := OemToAnsi(STR0006) // "Cadastro de F�rmulas"

		//�������������������������������������������������������������Ŀ
		//� Abre arquivo de Formulas e Moedas                           �
		//���������������������������������������������������������������

		if versenha(186)
			DbSelectArea("SM4")
			mBrowse( 6, 1,22,75,"SM4")
		Else
			Help(" ",1,"SEMPERM")
		EndIf
	EndIf
	Return

	/*/
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������Ŀ��
	���Fun��o    � X19Deleta� Autor � Ary Medeiros          � Data � 10/02/92 ���
	�������������������������������������������������������������������������Ĵ��
	���Descri��o � Rotina de exclusao de F�rmulas                             ���
	�������������������������������������������������������������������������Ĵ��
	���Sintaxe e � Void A370Deleta()                                          ���
	�������������������������������������������������������������������������Ĵ��
	��� Uso      � CFGX019                                                    ���
	��������������������������������������������������������������������������ٱ�
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	/*/
FUNCTION X19Deleta(cAlias,nReg,nOpc)
	LOCAL nOpcA:=0,oDlg
	Local aArea		:= GetArea()
	Local lDeleta	:= .T.
	Local lUsado	:= GetNewPar("MV_CFGX19A",.F.)		//Ativa a consistencia na exclusao
	Local aArq		:= {"SF4",""}
	Local cDbf		:= "F4_FILIAL=='"+xFilial("SF4")+"' .AND. F4_FORMULA =='"+(cAlias)->M4_CODIGO+"'"
	Local cTop		:= "F4_FILIAL='"+xFilial("SF4")+"' AND F4_FORMULA='"+(cAlias)->M4_CODIGO+"'"
	Local cTitulo	:= OemToAnsi(STR0008)	//"ATEN��O !"
	Local cProblem1	:= OemToAnsi(STR0009)	//"Esta f�rmula est� sendo utilizada na TES ["
	Local cProblem2	:= OemToAnsi(STR0010)	//"], n�o poder� ser exclu�da !"
	Local cSolucao	:= OemToAnsi(STR0011)	//"Alterar ou excluir a referida TES."
	Local aInfo     := {}
	Local aPosObj   := {}
	Local aObjects  := {}
	Local aSize     := MsAdvSize()
	Local nGd1      := 2
	Local nGd2 		:= 2
	Local nGd3 		:= 0
	Local nGd4 		:= 0

	//��������������������������������������������������������������Ŀ
	//� Monta a entrada de dados do arquivo                          �
	//����������������������������������������������������������������
	Private aTELA[0][0],aGETS[0]

	aObjects := {}
	AAdd( aObjects, {100, 100, .t., .t. } )

	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 }
	aPosObj := MsObjSize( aInfo, aObjects )

	nGd1 := 2
	nGd2 := 2
	nGd3 := aPosObj[1,3]-aPosObj[1,1]
	nGd4 := aPosObj[1,4]-aPosObj[1,2]

	//��������������������������������������������Ŀ
	//� Envia para processamento dos Gets          �
	//����������������������������������������������
	nOpcA:=0
	DEFINE MSDIALOG oDlg TITLE cCadastro FROM nGd1,nGd2 TO nGd3,nGd4 OF oMainWnd PIXEL
	nOpcA:=EnChoice( cAlias, nReg, nOpc, ,"AC", OemToAnsi(STR0007),,aPosObj[1] , , 3 ) // "Quanto � exclus�o?"
	ACTIVATE MSDIALOG oDlg ON INIT EnchoiceBar(oDlg,{|| nOpca:=2,oDlg:End()},{|| nOpca:=0,oDlg:End()})

	IF nOpcA == 2

		If lUsado	//Verifica se a formula ja foi utilizado na tabela da TES
			dbSelectArea("SF4")
			dbSetOrder(1)
			FsQuery(aArq,1,cTop,cDbf,SF4->(IndexKey()))
			dbGoTop()
			If !Eof()
				xMagHelpFis(cTitulo,cProblem1+SF4->F4_CODIGO+cProblem2,cSolucao)
				lDeleta := .F.		//Nao exclui
			Endif
			FsQuery(aArq,2)
			RestArea(aArea)
		Endif

		If lDeleta
			dbSelectArea( cAlias )
			RecLock(cAlias,.F.)
			dbDelete()
			dbGoto(nReg)
		Endif

		If ExistBlock("X19Grava")
			ExecBlock("X19Grava",.f., .f.,{cAlias,nReg,nOpc})
		EndIf
	EndIf

	dbSelectArea( cAlias )

	Return

	/*/
	���������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	�������������������������������������������������������������������������Ŀ��
	���Programa  �MenuDef   � Autor �Rodrigo de A Sartorio  � Data �15/04/2006���
	�������������������������������������������������������������������������Ĵ��
	���Descri��o � Utilizacao de menu Funcional                               ���
	���          �                                                            ���
	���          �                                                            ���
	�������������������������������������������������������������������������Ĵ��
	���Retorno   �Array com opcoes da rotina.                                 ���
	�������������������������������������������������������������������������Ĵ��
	���Parametros�Parametros do array a Rotina:                               ���
	���          �1. Nome a aparecer no cabecalho                             ���
	���          �2. Nome da Rotina associada                                 ���
	���          �3. Reservado                                                ���
	���          �4. Tipo de Transa��o a ser efetuada:                        ���
	���          �		1 - Pesquisa e Posiciona em um Banco de Dados         ���
	���          �    2 - Simplesmente Mostra os Campos                       ���
	���          �    3 - Inclui registros no Bancos de Dados                 ���
	���          �    4 - Altera o registro corrente                          ���
	���          �    5 - Remove o registro corrente do Banco de Dados        ���
	���          �5. Nivel de acesso                                          ���
	���          �6. Habilita Menu Funcional                                  ���
	�������������������������������������������������������������������������Ĵ��
	���   DATA   � Programador   �Manutencao efetuada                         ���
	�������������������������������������������������������������������������Ĵ��
	���          �               �                                            ���
	��������������������������������������������������������������������������ٱ�
	�����������������������������������������������������������������������������
	�����������������������������������������������������������������������������
	/*/
Static Function MenuDef()
	If	GetRpoRelease() >= "R7"
		aRotina := {}
		ADD OPTION aRotina TITLE STR0002 ACTION "VIEWDEF.CFGX019" OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //"Visualizar"
		ADD OPTION aRotina TITLE STR0003 ACTION "VIEWDEF.CFGX019" OPERATION MODEL_OPERATION_INSERT ACCESS 0 //"Incluir"
		ADD OPTION aRotina TITLE STR0004 ACTION "VIEWDEF.CFGX019" OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //"Alterar"
		ADD OPTION aRotina TITLE STR0005 ACTION "VIEWDEF.CFGX019" OPERATION MODEL_OPERATION_DELETE ACCESS 0 //"Excluir"
	Else
		PRIVATE aRotina := { { OemToAnsi(STR0001),"AxPesqui", 0 , 1,0,.F.},; // "Pesquisar"
		{   OemToAnsi(STR0002),"AxVisual", 0 , 2,0,NIL},; // "Visualizar"
		{   OemToAnsi(STR0003),"X19Inclui",0 , 3,0,NIL},; // "Incluir"
		{   OemToAnsi(STR0004),"X19Altera", 0 , 4,0,NIL},; // "Alterar"
		{   OemToAnsi(STR0005),"X19Deleta",0 , 5,0,NIL} } // "Excluir"

	EndIf
	//������������������������������������������������������������������������Ŀ
	//� Ponto de entrada utilizado para inserir novas opcoes no array aRotina  �
	//��������������������������������������������������������������������������
	If ExistBlock("CFG019MNU")
		ExecBlock("CFG019MNU",.F.,.F.)
	EndIf

	Return(aRotina)

Function X19Inclui(cAlias,nReg,nOpc)
	Local nOpcA := 0
	nOpcA := AxInclui(cAlias,nReg,nOpc)

	If nOpcA == 1 .and. ExistBlock("X19Grava")
		ExecBlock("X19Grava",.f., .f., {cAlias,0,nOpc})
	EndIf

	Return

Function X19Altera(cAlias,nReg,nOpc)
	Local nOpcA := 0
	nOpcA := AxAltera(cAlias,nReg,nOpc)

	If nOpcA == 1 .and.  ExistBlock("X19Grava")
		ExecBlock("X19Grava",.f., .f.,{cAlias,nReg,nOpc})
	EndIf

	Return
	//-------------------------------------------------------------------
	/*{Protheus.doc} ModelDef
	Definicao do Modelo

	@author Leandro F. Dourado
	@since 11/05/2012
	@version 11
	*/
	//-------------------------------------------------------------------
Static Function ModelDef()
	Local oStructSM4 := FWFormStruct(1,"SM4")
	Local oModel 	 := Nil

	//-----------------------------------------
	//Monta o modelo do formulario
	//-----------------------------------------
	oModel:= MPFormModel():New("CFGX019",/*Pre-Validacao*/,/*Pos-Validacao*/,{|oModel| X019Commit(oModel)}/*Commit*/,/*Cancel*/)
	oModel:AddFields("CFGX019_SM4", Nil/*cOwner*/, oStructSM4 ,/*Pre-Validacao*/,/*Pos-Validacao*/,/*Carga*/)
	oModel:GetModel("CFGX019_SM4"):SetDescription(OemToAnsi(STR0006))		 // "Cadastro de Formulas"

	Return oModel
	//-------------------------------------------------------------------
	/*{Protheus.doc} ViewDef
	Definicao da Visao

	@author Leandro F. Dourado
	@since 11/05/2012
	@version 11
	*/
	//-------------------------------------------------------------------
Static Function ViewDef()
	Local oView  		:= Nil
	Local oModel  		:= FWLoadModel("CFGX019")
	Local oStructSM4 	:= FWFormStruct(2,"SM4")

	//-- Monta o modelo da interface do formulario
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:EnableControlBar(.T.)
	oView:AddField( "CFGX019_SM4" , oStructSM4 )
	oView:CreateHorizontalBox( "HEADER" , 100 )
	oView:SetOwnerView( "CFGX019_SM4" , "HEADER" )

	Return oView

	//-------------------------------------------------------------------
	/*/{Protheus.doc} X019Commit
	Gravacao do modelo de dados

	@author Leandro F. Dourado
	@since 11/05/2012
	@version P12
	/*/
	//-------------------------------------------------------------------
Static Function X019Commit(oModel)
	Local aArea		:= GetArea()
	Local nOpc 		:= oModel:GetOperation()
	Local cAlias	:= "SM4"
	Local nReg		:= (cAlias)->(Recno())

	FWFormCommit(oModel)

	If ExistBlock("X19Grava")
		ExecBlock("X19Grava",.f., .f.,{cAlias,nReg,nOpc})
	EndIf
	RestArea(aArea)

	Return .T.
