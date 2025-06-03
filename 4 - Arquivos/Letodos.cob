       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETODOS.
      ******************************************************************
      * Autor: xxxxxx
      * Data:
      * Assunto: LEITURA DE UM ARQUIVO - TODOS OS REGISTROS
      ******************************************************************

       ENVIRONMENT        DIVISION.
       CONFIGURATION      SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT       SECTION.
       FILE-CONTROL.
           SELECT CARROS ASSIGN TO "D:\temp\Cobol\dados\carros.txt"
              FILE STATUS IS FS-CARROS.

 
       DATA DIVISION.
       FILE            SECTION.
      *------------------- LAYOUT - 36 POSICOES 
       FD  CARROS.  
       01  REG-DADOS.
           05 REG-CODIGO   PIC  X(003).
           05 REG-FABR     PIC  X(010).
           05 REG-MODELO   PIC  X(015).
           05 REG-VALOR    PIC  9(006)V99.

       
       WORKING-STORAGE SECTION.
      *----------------- VARIAVEL DE STATUS 
       01  FS-CARROS       PIC 9(02) VALUE ZEROS.
       
      *----------------- VARIAVEL DE EDICAO
       01  WRK-VALOR     PIC ZZZ.ZZ9,99.

       
       PROCEDURE           DIVISION.
       0000-PRINCIPAL      SECTION.
             PERFORM 0100-INICIALIZAR.
             PERFORM 0200-PROCESSAR  UNTIL FS-CARROS EQUAL 10.
             PERFORM 0300-FINALIZAR.
             
             STOP RUN.
       0000-PRINCIPAL-FIM. EXIT.



       0100-INICIALIZAR      SECTION.
              OPEN INPUT CARROS.
      *---------- TESTAR SE O ARQUIVO EXISTE - SENAO INTERROMPE
              IF FS-CARROS NOT EQUAL 0
                  DISPLAY "ERRO NA ABERTURA " FS-CARROS
                  STOP RUN
              END-IF.  
                  
      *---------- TESTAR SE O ARQUIVO POSSUI  DADOS
              READ CARROS
              IF FS-CARROS EQUAL 10 
                   DISPLAY "SEM REGISTROS"
              END-IF.     
              
                  
                  
       
       
       
       0100-INICIAL-FIM. EXIT.


       0200-PROCESSAR        SECTION.
                  DISPLAY "-----------------------".
                  DISPLAY "CODIGO.    ... " REG-CODIGO
                  DISPLAY "FABRICANTE.... " REG-FABR
                  DISPLAY "MODELO      .. " REG-MODELO
                  MOVE REG-VALOR TO WRK-VALOR.
                  DISPLAY "VALOR       ..." WRK-VALOR
                  
                   READ CARROS.
              
       0200-PROCESSAR-FIM. EXIT.



       0300-FINALIZAR       SECTION.
              CLOSE CARROS.
              IF FS-CARROS NOT EQUAL 0
                  DISPLAY 'ERRO AO FECHAR ' FS-CARROS
              END-IF.    
              
       0300-FINALIZAR-FIM. EXIT.
