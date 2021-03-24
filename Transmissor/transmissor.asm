
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;transmissor.c,13 :: 		void interrupt(){
;transmissor.c,14 :: 		if(INTF_bit){                  //Flag do RB0/int
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;transmissor.c,15 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, 1
;transmissor.c,16 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;transmissor.c,17 :: 		}
L_interrupt0:
;transmissor.c,18 :: 		}
L__interrupt13:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_Config_NRF:

;transmissor.c,20 :: 		void Config_NRF(){
;transmissor.c,23 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,24 :: 		SPI1_Write(0x20);
	MOVLW      32
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,25 :: 		SPI1_Write(0x0E);
	MOVLW      14
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,26 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,29 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,30 :: 		SPI1_Write(0x21);
	MOVLW      33
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,31 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,32 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,35 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,36 :: 		SPI1_Write(0x22);
	MOVLW      34
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,37 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,38 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,41 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,42 :: 		SPI1_Write(0x23);
	MOVLW      35
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,43 :: 		SPI1_Write(0x03);
	MOVLW      3
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,44 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,47 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,48 :: 		SPI1_Write(0x24);
	MOVLW      36
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,49 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,50 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,53 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,54 :: 		SPI1_Write(0x25);
	MOVLW      37
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,55 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,56 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,59 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,60 :: 		SPI1_Write(0x26);
	MOVLW      38
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,61 :: 		SPI1_Write(0x26);
	MOVLW      38
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,62 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,65 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,66 :: 		SPI1_Write(0x27);
	MOVLW      39
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,67 :: 		SPI1_Write(0x70);
	MOVLW      112
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,68 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,71 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,72 :: 		SPI1_Write(0x30);
	MOVLW      48
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,73 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,74 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,75 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,76 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,77 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,78 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,81 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,82 :: 		SPI1_Write(0x2A);
	MOVLW      42
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,83 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,84 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,85 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,86 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,87 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,88 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,89 :: 		}
	RETURN
; end of _Config_NRF

_Send_NRF:

;transmissor.c,92 :: 		void Send_NRF(unsigned short dat){
;transmissor.c,94 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,95 :: 		SPI1_Write(0b10100000);
	MOVLW      160
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,96 :: 		SPI1_Write(dat);
	MOVF       FARG_Send_NRF_dat+0, 0
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,97 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,99 :: 		CE = 1;
	BSF        RE2_bit+0, 2
;transmissor.c,100 :: 		delay_us(20);
	MOVLW      33
	MOVWF      R13+0
L_Send_NRF1:
	DECFSZ     R13+0, 1
	GOTO       L_Send_NRF1
;transmissor.c,101 :: 		CE = 0;
	BCF        RE2_bit+0, 2
;transmissor.c,102 :: 		}
	RETURN
; end of _Send_NRF

_main:

;transmissor.c,104 :: 		void main() {
;transmissor.c,105 :: 		CMCON = 0x07;
	MOVLW      7
	MOVWF      CMCON+0
;transmissor.c,106 :: 		ADCON0 = 0b00000001;    //Ativa o conversor AD
	MOVLW      1
	MOVWF      ADCON0+0
;transmissor.c,107 :: 		ADCON1 = 0b00001110;    //Seleciona o pino analógico AN0
	MOVLW      14
	MOVWF      ADCON1+0
;transmissor.c,109 :: 		TRISE.TRISE1 = 0;
	BCF        TRISE+0, 1
;transmissor.c,110 :: 		TRISE.TRISE2 = 0;
	BCF        TRISE+0, 2
;transmissor.c,111 :: 		TRISB.TRISB2 = 0;
	BCF        TRISB+0, 2
;transmissor.c,112 :: 		RB2_bit = 0;
	BCF        RB2_bit+0, 2
;transmissor.c,113 :: 		TRISB.TRISB0 = 1;       //Entrada do RB0 para interrupção
	BSF        TRISB+0, 0
;transmissor.c,114 :: 		TRISB.TRISB1 = 1;
	BSF        TRISB+0, 1
;transmissor.c,115 :: 		CSN = 1;                //Pino CSN do SPI
	BSF        RE1_bit+0, 1
;transmissor.c,116 :: 		CE = 0;                 //NRF em standby - I
	BCF        RE2_bit+0, 2
;transmissor.c,118 :: 		TRISB.TRISB7 = 1;
	BSF        TRISB+0, 7
;transmissor.c,119 :: 		TRISB.TRISB6 = 1;
	BSF        TRISB+0, 6
;transmissor.c,120 :: 		TRISB.TRISB5 = 1;
	BSF        TRISB+0, 5
;transmissor.c,121 :: 		TRISB.TRISB4 = 1;
	BSF        TRISB+0, 4
;transmissor.c,122 :: 		TRISD.TRISD0 = 0;
	BCF        TRISD+0, 0
;transmissor.c,125 :: 		INTCON = 0b11010000;          //Configuração de interrupções e flags de interrupção (Timer0, RB0)
	MOVLW      208
	MOVWF      INTCON+0
;transmissor.c,128 :: 		SPI1_Init();
	CALL       _SPI1_Init+0
;transmissor.c,129 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main2:
	DECFSZ     R13+0, 1
	GOTO       L_main2
	DECFSZ     R12+0, 1
	GOTO       L_main2
	DECFSZ     R11+0, 1
	GOTO       L_main2
	NOP
	NOP
;transmissor.c,131 :: 		Config_NRF();                 // Configura NRF24L01+
	CALL       _Config_NRF+0
;transmissor.c,133 :: 		while(1){
L_main3:
;transmissor.c,134 :: 		delay_ms(1000);
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;transmissor.c,135 :: 		valor = 0;
	CLRF       _valor+0
;transmissor.c,136 :: 		if(RIGHT)
	BTFSS      RB4_bit+0, 4
	GOTO       L_main6
;transmissor.c,137 :: 		valor = 1;
	MOVLW      1
	MOVWF      _valor+0
L_main6:
;transmissor.c,138 :: 		if(UP)
	BTFSS      RB5_bit+0, 5
	GOTO       L_main7
;transmissor.c,139 :: 		valor = 2;
	MOVLW      2
	MOVWF      _valor+0
L_main7:
;transmissor.c,140 :: 		if(DOWN)
	BTFSS      RB6_bit+0, 6
	GOTO       L_main8
;transmissor.c,141 :: 		valor = 3;
	MOVLW      3
	MOVWF      _valor+0
L_main8:
;transmissor.c,142 :: 		if(LEFT)
	BTFSS      RB7_bit+0, 7
	GOTO       L_main9
;transmissor.c,143 :: 		valor = 4;
	MOVLW      4
	MOVWF      _valor+0
L_main9:
;transmissor.c,145 :: 		LED = RIGHT || UP || DOWN || LEFT;
	BTFSC      RB4_bit+0, 4
	GOTO       L_main11
	BTFSC      RB5_bit+0, 5
	GOTO       L_main11
	BTFSC      RB6_bit+0, 6
	GOTO       L_main11
	BTFSC      RB7_bit+0, 7
	GOTO       L_main11
	CLRF       R0+0
	GOTO       L_main10
L_main11:
	MOVLW      1
	MOVWF      R0+0
L_main10:
	BTFSC      R0+0, 0
	GOTO       L__main14
	BCF        RD0_bit+0, 0
	GOTO       L__main15
L__main14:
	BSF        RD0_bit+0, 0
L__main15:
;transmissor.c,146 :: 		Send_NRF(valor);
	MOVF       _valor+0, 0
	MOVWF      FARG_Send_NRF_dat+0
	CALL       _Send_NRF+0
;transmissor.c,147 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main12:
	DECFSZ     R13+0, 1
	GOTO       L_main12
	DECFSZ     R12+0, 1
	GOTO       L_main12
	DECFSZ     R11+0, 1
	GOTO       L_main12
	NOP
	NOP
;transmissor.c,150 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,151 :: 		SPI1_Write(0xE1);
	MOVLW      225
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,152 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,155 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;transmissor.c,156 :: 		SPI1_Write(0x27);
	MOVLW      39
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,157 :: 		SPI1_Write(0x70);
	MOVLW      112
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;transmissor.c,158 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;transmissor.c,160 :: 		}
	GOTO       L_main3
;transmissor.c,161 :: 		}
	GOTO       $+0
; end of _main
