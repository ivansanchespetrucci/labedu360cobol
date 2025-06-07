       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARQUIVO.
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
           SELECT filmes ASSIGN TO "..\dados\filmesgpt.csv"
              ORGANIZATION IS LINE SEQUENTIAL
              FILE STATUS IS FS-filmes.


       DATA DIVISION.
       FILE            SECTION.
      *------------------- LAYOUT - 36 POSICOES
       FD  filmes.
       01  REG-DADOS PIC  X(200).


       WORKING-STORAGE SECTION.
      *----------------- VARIAVEL DE STATUS
       01  FS-filmes       PIC 9(02) VALUE ZEROS.

      *----------------- VARIAVEL DE APOIO
       01  WRK-FILMES.
           05 WRK-NOME         PIC X(60).
           05 WRK-ANO          PIC X(04).
           05 WRK-DIRETOR      PIC X(60).

       PROCEDURE           DIVISION.
       0000-PRINCIPAL      SECTION.
             PERFORM 0100-INICIALIZAR.
             PERFORM 0200-PROCESSAR UNTIL FS-filmes NOT EQUAL 0.
             PERFORM 0300-FINALIZAR.

             STOP RUN.
       0000-PRINCIPAL-FIM. EXIT.



       0100-INICIALIZAR      SECTION.
              OPEN INPUT filmes.
      *---------- TESTAR SE O ARQUIVO EXISTE - SENAO INTERROMPE
              IF FS-filmes NOT EQUAL 0
                  DISPLAY "ERRO NA ABERTURA " FS-filmes
                  STOP RUN
              END-IF.

      *---------- TESTAR SE O ARQUIVO POSSUI  DADOS
              READ filmes
              IF FS-filmes EQUAL 10
                   DISPLAY "SEM REGISTROS"
              END-IF.







       0100-INICIAL-FIM. EXIT.


       0200-PROCESSAR        SECTION.

                  UNSTRING REG-DADOS DELIMITED BY ";"
                  INTO WRK-NOME,WRK-ANO,WRK-DIRETOR
                   if wrk-ano > "2018"
                      DISPLAY "FILME   " WRK-NOME
                      DISPLAY "ANO     " WRK-ANO
                      DISPLAY "DIRETOR " WRK-DIRETOR
                      DISPLAY "---------------"
                    end-if.

               READ FILMES.

       0200-PROCESSAR-FIM. EXIT.



       0300-FINALIZAR       SECTION.
              CLOSE filmes.
              IF FS-filmes NOT EQUAL 0
                  DISPLAY 'ERRO AO FECHAR ' FS-filmes
              END-IF.

       0300-FINALIZAR-FIM. EXIT.
