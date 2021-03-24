#define IRQ RB0_bit     //PIC(RB0)  <->  MODULO(IRQ)
#define CSN RE1_bit     //PIC(RE1)  <->  MODULO(CSN)
#define CE RE2_bit      //PIC(RE2)  <->  MODULO(CE)
#define ENDER 0x78
#define MOTOR1_FRENTE RB6_bit
#define MOTOR1_TRAS RB5_bit
#define MOTOR2_FRENTE RB4_bit
#define MOTOR2_TRAS RB3_bit

//Comunicação entre o PIC e o display
sbit LCD_RS at RD2_bit;
sbit LCD_EN at RD3_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD2_bit;
sbit LCD_EN_Direction at TRISD3_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
//end comunicação

//Variáveis
unsigned short buff1 = 0, flag = 0, store=0;
float temperature = 0.0;                       //Armazena a temperatura em graus Celsius
char txt[15];                                  //String para texto
//end variáveis

void interrupt(){

     if(INTF_bit){                  //Flag do RB0/int
        INTF_bit = 0;
        flag = 1;
     }
}

const char character[] = {6,9,6,0,0,0,0,0};

void CustomChar(char pos_row, char pos_char) {
  char i;
    Lcd_Cmd(64);
    for (i = 0; i<=7; i++) Lcd_Chr_CP(character[i]);
    Lcd_Cmd(_LCD_RETURN_HOME);
    Lcd_Chr(pos_row, pos_char, 0);
}


void Config_NRF(){

     //CONFIG_reg - configurado como RX
     CSN = 0;
     SPI1_Write(0x20);
     SPI1_Write(0x0F);
     CSN = 1;

     //EN_AA - Habilita ACK no pipe 0
     CSN = 0;
     SPI1_Write(0x21);
     SPI1_Write(0x01);
     CSN = 1;

     //EN_RXADDR - Habilita Endereço no pipe 0
     CSN = 0;
     SPI1_Write(0x22);
     SPI1_Write(0x01);
     CSN = 1;

     //SETUP_AW - Tamanho do endereço RX/TX (5 bytes)
     CSN = 0;
     SPI1_Write(0x23);
     SPI1_Write(0x03);
     CSN = 1;

     //RF_CH - Canal de RF
     CSN = 0;
     SPI1_Write(0x25);
     SPI1_Write(0x01);
     CSN = 1;

     //RF_SETUP - Taxa de transmissão em 250kps e potencia em 0 bBm
     CSN = 0;
     SPI1_Write(0x26);
     SPI1_Write(0x26);
     CSN = 1;

     //STATUS - Reseta as flags de interrupção
     CSN = 0;
     SPI1_Write(0x27);
     SPI1_Write(0x70);
     CSN = 1;

     //RX_ADDR_P0- Endereço de Recepção
     CSN = 0;
     SPI1_Write(0x2A);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     CSN = 1;

     //RX_PW_P0 - Numero de bytes no RX payload pipe0
     CSN = 0;
     SPI1_Write(0x31);
     SPI1_Write(1);
     CSN = 1;

     //RX Flush
     CSN = 0;
     SPI1_Write(0xE2);
     CSN = 1;

     CE = 1;
     delay_us(130);
}

//Função principal
void main(){
     TRISD = 0x00;      //Configura todo PORTD como saída
     ADCON1 = 0x07;     //Desabilita o conversor A/D do PIC e torna as saidas digitais
     ADCON0 = 0x00;
     CMCON = 0x07;      //Desabilita os comparadores internos do PIC
     TRISE.TRISE1 = 0;
     TRISE.TRISE2 = 0;
     TRISB.TRISB0 = 1;  //Entrada do RB0 para interrupção
     TRISB.TRISB7 = 0;
     CSN = 1;           //Pino CSN do SPI
     CE = 0;            //NRF em standby - I

     TRISB.TRISB6 = 0;
     TRISB.TRISB5 = 0;
     TRISB.TRISB4 = 0;
     TRISB.TRISB3 = 0;

     // CONFIGURAÇÃO DE interrupção do RB0
     INTEDG_bit = 0;
     INTCON = 0b11010000;           //Configuração de interrupções e flags de interrupção  RB0
     
     //Inicia Protocolo SPI
     SPI1_Init();
     delay_ms(100);

     Config_NRF();                      // Configura NRF24L01+

     Lcd_Init();                         //Inicializa o display
     Lcd_Cmd(_Lcd_Cursor_Off);           //Apaga o cursor
     Lcd_Cmd(_LCD_CLEAR);                //Limpa o display
     Lcd_Out(2,1,".");
     delay_ms(200);
     Lcd_Out(2,1,"..");
     delay_ms(200);
     Lcd_Out(2,1,"...");
     delay_ms(200);
     Lcd_Out(1,1,"    MEU 100");
     Lcd_Out(2,1,"   MINHA VIDA");
     delay_ms(800);
     
     
     Lcd_Cmd(_LCD_CLEAR);
   while(1){                         //Início do loop infinito
     
     if(flag == 1){

             RB7_bit = 1;

             CE = 0;
             CSN = 0;
             buff1 = SPI1_Read(0x61);             //Le registrador STATUS
             store = SPI1_Read(0xFF);             //Le RX Payload
             CSN = 1;

             temperature = store;        //Converte para tensão em Volts

             if(store == 0)
             {
                      MOTOR1_TRAS = 0;
                      MOTOR1_FRENTE = 0;
                      MOTOR2_TRAS = 0;
                      MOTOR1_FRENTE = 0;
                      Lcd_Out(2,1,"->   PARADO   <-");
             }
             if(store == 1)
             {
                      MOTOR1_TRAS = 1;
                      MOTOR1_FRENTE = 0;
                      MOTOR2_TRAS = 0;
                      MOTOR1_FRENTE = 1;
                      Lcd_Out(2,1,"->   DIREITA  <-");
             }
             if(store == 2)
             {
                      MOTOR1_TRAS = 0;
                      MOTOR1_FRENTE = 1;
                      MOTOR2_TRAS = 0;
                      MOTOR1_FRENTE = 1;
                      Lcd_Out(2,1,"->   FRENTE   <-");
             }
             if(store == 3)
             {
                      MOTOR1_TRAS = 1;
                      MOTOR1_FRENTE = 0;
                      MOTOR2_TRAS = 1;
                      MOTOR1_FRENTE = 0;
                      Lcd_Out(2,1,"->    TRAS    <-");
             }
             if(store == 4)
             {
                      MOTOR1_TRAS = 0;
                      MOTOR1_FRENTE = 1;
                      MOTOR2_TRAS = 1;
                      MOTOR1_FRENTE = 0;
                      Lcd_Out(2,1,"->  ESQUERDA  <-");
             }
             
             //STATUS - Reseta as flags de interrupção
             CSN = 0;
             SPI1_Write(0x27);
             SPI1_Write(0x70);
             CSN = 1;

             //RX Flush
             CSN = 0;
             SPI1_Write(0xE2);
             CSN = 1;

             flag = 0;
             CE = 1;
             
        }
        RB7_bit = 0;
     } //end while

} //end main