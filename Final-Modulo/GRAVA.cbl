       IDENTIFICATION DIVISION.
       PROGRAM-ID. GRAVA.
      ******************************************************************
      * Autor: xxxxxx
      * Data:
      * Assunto: LEITURA DE UM ARQUIVO
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
       01  WRK-VALOR-ED     PIC ZZZ.ZZ9,99.


       01  WRK-DADOS.
           05 WRK-CODIGO   PIC  X(003).
           05 WRK-FABR     PIC  X(010).
           05 WRK-MODELO   PIC  X(015).
           05 WRK-VALOR    PIC  9(006)V99.

       PROCEDURE           DIVISION.
       0000-PRINCIPAL      SECTION.
             PERFORM 0100-INICIALIZAR.
             IF FS-CARROS EQUAL 0
                PERFORM 0200-PROCESSAR
             END-IF.
             PERFORM 0300-FINALIZAR.

             STOP RUN.
       0000-PRINCIPAL-FIM. EXIT.



       0100-INICIALIZAR      SECTION.
              OPEN EXTEND CARROS.
      *---------- TESTAR SE O ARQUIVO EXISTE - SENAO INTERROMPE
              IF FS-CARROS NOT EQUAL 0
                  DISPLAY "ERRO NA ABERTURA " FS-CARROS
                  STOP RUN
              END-IF.

       0100-INICIAL-FIM. EXIT.


       0200-PROCESSAR        SECTION.
                  DISPLAY "CODIGO "
                     ACCEPT WRK-CODIGO.
                  DISPLAY "FABRICANTE "
                     ACCEPT WRK-FABR.
                  DISPLAY "MODELO  "
                     ACCEPT WRK-MODELO.
                  DISPLAY "VALOR "
                     ACCEPT WRK-VALOR.

                   MOVE WRK-DADOS TO REG-DADOS.

                   WRITE REG-DADOS.
                    IF FS-CARROS NOT EQUAL 0
                        DISPLAY "NAO GRAVOU "
                    ELSE
                   DISPLAY "CODIGO.    ... " REG-CODIGO
                   DISPLAY "FABRICANTE.... " REG-FABR
                   DISPLAY "MODELO      .. " REG-MODELO
                   MOVE REG-VALOR TO WRK-VALOR
                   DISPLAY "VALOR      ... " WRK-VALOR
                    END-IF.










       0200-PROCESSAR-FIM. EXIT.



       0300-FINALIZAR       SECTION.
              CLOSE CARROS.
              IF FS-CARROS NOT EQUAL 0
                  DISPLAY 'ERRO AO FECHAR ' FS-CARROS
              END-IF.

       0300-FINALIZAR-FIM. EXIT.
