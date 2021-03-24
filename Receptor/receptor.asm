
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;receptor.c,32 :: 		void interrupt(){
;receptor.c,34 :: 		if(INTF_bit){                  //Flag do RB0/int
	BTFSS      INTF_bit+0, 1
	GOTO       L_interrupt0
;receptor.c,35 :: 		INTF_bit = 0;
	BCF        INTF_bit+0, 1
;receptor.c,36 :: 		flag = 1;
	MOVLW      1
	MOVWF      _flag+0
;receptor.c,37 :: 		}
L_interrupt0:
;receptor.c,38 :: 		}
L__interrupt18:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_CustomChar:

;receptor.c,42 :: 		void CustomChar(char pos_row, char pos_char) {
;receptor.c,44 :: 		Lcd_Cmd(64);
	MOVLW      64
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;receptor.c,45 :: 		for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
	CLRF       CustomChar_i_L0+0
L_CustomChar1:
	MOVF       CustomChar_i_L0+0, 0
	SUBLW      7
	BTFSS      STATUS+0, 0
	GOTO       L_CustomChar2
	MOVF       CustomChar_i_L0+0, 0
	ADDLW      _character+0
	MOVWF      R0+0
	MOVLW      hi_addr(_character+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
	INCF       CustomChar_i_L0+0, 1
	GOTO       L_CustomChar1
L_CustomChar2:
;receptor.c,46 :: 		Lcd_Cmd(_LCD_RETURN_HOME);
	MOVLW      2
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;receptor.c,47 :: 		Lcd_Chr(pos_row, pos_char, 0);
	MOVF       FARG_CustomChar_pos_row+0, 0
	MOVWF      FARG_Lcd_Chr_row+0
	MOVF       FARG_CustomChar_pos_char+0, 0
	MOVWF      FARG_Lcd_Chr_column+0
	CLRF       FARG_Lcd_Chr_out_char+0
	CALL       _Lcd_Chr+0
;receptor.c,48 :: 		}
	RETURN
; end of _CustomChar

_Config_NRF:

;receptor.c,51 :: 		void Config_NRF(){
;receptor.c,54 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,55 :: 		SPI1_Write(0x20);
	MOVLW      32
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,56 :: 		SPI1_Write(0x0F);
	MOVLW      15
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,57 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,60 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,61 :: 		SPI1_Write(0x21);
	MOVLW      33
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,62 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,63 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,66 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,67 :: 		SPI1_Write(0x22);
	MOVLW      34
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,68 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,69 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,72 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,73 :: 		SPI1_Write(0x23);
	MOVLW      35
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,74 :: 		SPI1_Write(0x03);
	MOVLW      3
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,75 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,78 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,79 :: 		SPI1_Write(0x25);
	MOVLW      37
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,80 :: 		SPI1_Write(0x01);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,81 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,84 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,85 :: 		SPI1_Write(0x26);
	MOVLW      38
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,86 :: 		SPI1_Write(0x26);
	MOVLW      38
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,87 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,90 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,91 :: 		SPI1_Write(0x27);
	MOVLW      39
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,92 :: 		SPI1_Write(0x70);
	MOVLW      112
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,93 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,96 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,97 :: 		SPI1_Write(0x2A);
	MOVLW      42
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,98 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,99 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,100 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,101 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,102 :: 		SPI1_Write(ENDER);
	MOVLW      120
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,103 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,106 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,107 :: 		SPI1_Write(0x31);
	MOVLW      49
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,108 :: 		SPI1_Write(1);
	MOVLW      1
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,109 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,112 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,113 :: 		SPI1_Write(0xE2);
	MOVLW      226
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,114 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,116 :: 		CE = 1;
	BSF        RE2_bit+0, 2
;receptor.c,117 :: 		delay_us(130);
	MOVLW      216
	MOVWF      R13+0
L_Config_NRF4:
	DECFSZ     R13+0, 1
	GOTO       L_Config_NRF4
	NOP
;receptor.c,118 :: 		}
	RETURN
; end of _Config_NRF

_main:

;receptor.c,121 :: 		void main(){
;receptor.c,122 :: 		TRISD = 0x00;      //Configura todo PORTD como saída
	CLRF       TRISD+0
;receptor.c,123 :: 		ADCON1 = 0x07;     //Desabilita o conversor A/D do PIC e torna as saidas digitais
	MOVLW      7
	MOVWF      ADCON1+0
;receptor.c,124 :: 		ADCON0 = 0x00;
	CLRF       ADCON0+0
;receptor.c,125 :: 		CMCON = 0x07;      //Desabilita os comparadores internos do PIC
	MOVLW      7
	MOVWF      CMCON+0
;receptor.c,126 :: 		TRISE.TRISE1 = 0;
	BCF        TRISE+0, 1
;receptor.c,127 :: 		TRISE.TRISE2 = 0;
	BCF        TRISE+0, 2
;receptor.c,128 :: 		TRISB.TRISB0 = 1;  //Entrada do RB0 para interrupção
	BSF        TRISB+0, 0
;receptor.c,129 :: 		TRISB.TRISB7 = 0;
	BCF        TRISB+0, 7
;receptor.c,130 :: 		CSN = 1;           //Pino CSN do SPI
	BSF        RE1_bit+0, 1
;receptor.c,131 :: 		CE = 0;            //NRF em standby - I
	BCF        RE2_bit+0, 2
;receptor.c,133 :: 		TRISB.TRISB6 = 0;
	BCF        TRISB+0, 6
;receptor.c,134 :: 		TRISB.TRISB5 = 0;
	BCF        TRISB+0, 5
;receptor.c,135 :: 		TRISB.TRISB4 = 0;
	BCF        TRISB+0, 4
;receptor.c,136 :: 		TRISB.TRISB3 = 0;
	BCF        TRISB+0, 3
;receptor.c,139 :: 		INTEDG_bit = 0;
	BCF        INTEDG_bit+0, 6
;receptor.c,140 :: 		INTCON = 0b11010000;           //Configuração de interrupções e flags de interrupção  RB0
	MOVLW      208
	MOVWF      INTCON+0
;receptor.c,143 :: 		SPI1_Init();
	CALL       _SPI1_Init+0
;receptor.c,144 :: 		delay_ms(100);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
	NOP
;receptor.c,146 :: 		Config_NRF();                      // Configura NRF24L01+
	CALL       _Config_NRF+0
;receptor.c,148 :: 		Lcd_Init();                         //Inicializa o display
	CALL       _Lcd_Init+0
;receptor.c,149 :: 		Lcd_Cmd(_Lcd_Cursor_Off);           //Apaga o cursor
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;receptor.c,150 :: 		Lcd_Cmd(_LCD_CLEAR);                //Limpa o display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;receptor.c,151 :: 		Lcd_Out(2,1,".");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,152 :: 		delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main6:
	DECFSZ     R13+0, 1
	GOTO       L_main6
	DECFSZ     R12+0, 1
	GOTO       L_main6
	DECFSZ     R11+0, 1
	GOTO       L_main6
	NOP
	NOP
;receptor.c,153 :: 		Lcd_Out(2,1,"..");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,154 :: 		delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main7:
	DECFSZ     R13+0, 1
	GOTO       L_main7
	DECFSZ     R12+0, 1
	GOTO       L_main7
	DECFSZ     R11+0, 1
	GOTO       L_main7
	NOP
	NOP
;receptor.c,155 :: 		Lcd_Out(2,1,"...");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,156 :: 		delay_ms(200);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;receptor.c,157 :: 		Lcd_Out(1,1,"    MEU 100");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,158 :: 		Lcd_Out(2,1,"   MINHA VIDA");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,159 :: 		delay_ms(800);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
;receptor.c,162 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;receptor.c,163 :: 		while(1){                         //Início do loop infinito
L_main10:
;receptor.c,165 :: 		if(flag == 1){
	MOVF       _flag+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;receptor.c,167 :: 		RB7_bit = 1;
	BSF        RB7_bit+0, 7
;receptor.c,169 :: 		CE = 0;
	BCF        RE2_bit+0, 2
;receptor.c,170 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,171 :: 		buff1 = SPI1_Read(0x61);             //Le registrador STATUS
	MOVLW      97
	MOVWF      FARG_SPI1_Read_buffer+0
	CALL       _SPI1_Read+0
	MOVF       R0+0, 0
	MOVWF      _buff1+0
;receptor.c,172 :: 		store = SPI1_Read(0xFF);             //Le RX Payload
	MOVLW      255
	MOVWF      FARG_SPI1_Read_buffer+0
	CALL       _SPI1_Read+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _store+0
;receptor.c,173 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,175 :: 		temperature = store;        //Converte para tensão em Volts
	MOVF       FLOC__main+0, 0
	MOVWF      R0+0
	CALL       _Byte2Double+0
	MOVF       R0+0, 0
	MOVWF      _temperature+0
	MOVF       R0+1, 0
	MOVWF      _temperature+1
	MOVF       R0+2, 0
	MOVWF      _temperature+2
	MOVF       R0+3, 0
	MOVWF      _temperature+3
;receptor.c,177 :: 		if(store == 0)
	MOVF       FLOC__main+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;receptor.c,179 :: 		MOTOR1_TRAS = 0;
	BCF        RB5_bit+0, 5
;receptor.c,180 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,181 :: 		MOTOR2_TRAS = 0;
	BCF        RB3_bit+0, 3
;receptor.c,182 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,183 :: 		Lcd_Out(2,1,"->   PARADO   <-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,184 :: 		}
L_main13:
;receptor.c,185 :: 		if(store == 1)
	MOVF       _store+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;receptor.c,187 :: 		MOTOR1_TRAS = 1;
	BSF        RB5_bit+0, 5
;receptor.c,188 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,189 :: 		MOTOR2_TRAS = 0;
	BCF        RB3_bit+0, 3
;receptor.c,190 :: 		MOTOR1_FRENTE = 1;
	BSF        RB6_bit+0, 6
;receptor.c,191 :: 		Lcd_Out(2,1,"->   DIREITA  <-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,192 :: 		}
L_main14:
;receptor.c,193 :: 		if(store == 2)
	MOVF       _store+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;receptor.c,195 :: 		MOTOR1_TRAS = 0;
	BCF        RB5_bit+0, 5
;receptor.c,196 :: 		MOTOR1_FRENTE = 1;
	BSF        RB6_bit+0, 6
;receptor.c,197 :: 		MOTOR2_TRAS = 0;
	BCF        RB3_bit+0, 3
;receptor.c,198 :: 		MOTOR1_FRENTE = 1;
	BSF        RB6_bit+0, 6
;receptor.c,199 :: 		Lcd_Out(2,1,"->   FRENTE   <-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,200 :: 		}
L_main15:
;receptor.c,201 :: 		if(store == 3)
	MOVF       _store+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;receptor.c,203 :: 		MOTOR1_TRAS = 1;
	BSF        RB5_bit+0, 5
;receptor.c,204 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,205 :: 		MOTOR2_TRAS = 1;
	BSF        RB3_bit+0, 3
;receptor.c,206 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,207 :: 		Lcd_Out(2,1,"->    TRAS    <-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,208 :: 		}
L_main16:
;receptor.c,209 :: 		if(store == 4)
	MOVF       _store+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;receptor.c,211 :: 		MOTOR1_TRAS = 0;
	BCF        RB5_bit+0, 5
;receptor.c,212 :: 		MOTOR1_FRENTE = 1;
	BSF        RB6_bit+0, 6
;receptor.c,213 :: 		MOTOR2_TRAS = 1;
	BSF        RB3_bit+0, 3
;receptor.c,214 :: 		MOTOR1_FRENTE = 0;
	BCF        RB6_bit+0, 6
;receptor.c,215 :: 		Lcd_Out(2,1,"->  ESQUERDA  <-");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_receptor+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;receptor.c,216 :: 		}
L_main17:
;receptor.c,219 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,220 :: 		SPI1_Write(0x27);
	MOVLW      39
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,221 :: 		SPI1_Write(0x70);
	MOVLW      112
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,222 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,225 :: 		CSN = 0;
	BCF        RE1_bit+0, 1
;receptor.c,226 :: 		SPI1_Write(0xE2);
	MOVLW      226
	MOVWF      FARG_SPI1_Write_data_+0
	CALL       _SPI1_Write+0
;receptor.c,227 :: 		CSN = 1;
	BSF        RE1_bit+0, 1
;receptor.c,229 :: 		flag = 0;
	CLRF       _flag+0
;receptor.c,230 :: 		CE = 1;
	BSF        RE2_bit+0, 2
;receptor.c,232 :: 		}
L_main12:
;receptor.c,233 :: 		RB7_bit = 0;
	BCF        RB7_bit+0, 7
;receptor.c,234 :: 		} //end while
	GOTO       L_main10
;receptor.c,236 :: 		} //end main
	GOTO       $+0
; end of _main
