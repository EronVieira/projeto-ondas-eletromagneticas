#define IRQ RB0_bit     //PIC(RB0)  <->  MODULO(IRQ)
#define CSN RE1_bit     //PIC(RE1)  <->  MODULO(CSN)
#define CE RE2_bit      //PIC(RE2)  <->  MODULO(CE)
#define ENDER 0x78
#define RIGHT RB4_bit
#define UP RB5_bit
#define DOWN RB6_bit
#define LEFT RB7_bit
#define LED RD0_bit

unsigned short flag = 0, buff = 0,valor;

void interrupt(){
     if(INTF_bit){                  //Flag do RB0/int
         INTF_bit = 0;
         flag = 1;
     }
}

void Config_NRF(){

     //CONFIG_reg - configurado como TX
     CSN = 0;
     SPI1_Write(0x20);
     SPI1_Write(0x0E);
     CSN = 1;

     //EN_AA - Habilita ACK no pipe 0
     CSN = 0;
     SPI1_Write(0x21);
     SPI1_Write(0x01);
     CSN = 1;

     //EN_RXADDR
     CSN = 0;
     SPI1_Write(0x22);
     SPI1_Write(0x01);
     CSN = 1;

     //SETUP_AW - Tamanho do endereço RX/TX (5 bytes)
     CSN = 0;
     SPI1_Write(0x23);
     SPI1_Write(0x03);
     CSN = 1;

     //SETUP_RETR - Habilita Retransmissão de dados (1 retransmissao em 500uS)
     CSN = 0;
     SPI1_Write(0x24);
     SPI1_Write(0x01);
     CSN = 1;

     //RF_CH - Canal RF (canal 1)
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

     //TX_ADDR - Endereço de transmissão
     CSN = 0;
     SPI1_Write(0x30);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     CSN = 1;

     //RX_ADDR_P0- Endereço de Recepção pipe 0
     CSN = 0;
     SPI1_Write(0x2A);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     SPI1_Write(ENDER);
     CSN = 1;
}


void Send_NRF(unsigned short dat){
     //Escreve no TX payload
     CSN = 0;
     SPI1_Write(0b10100000);
     SPI1_Write(dat);
     CSN = 1;

     CE = 1;
     delay_us(20);
     CE = 0;
}

void main() {
     CMCON = 0x07;
     ADCON0 = 0b00000001;    //Ativa o conversor AD
     ADCON1 = 0b00001110;    //Seleciona o pino analógico AN0
     
     TRISE.TRISE1 = 0;
     TRISE.TRISE2 = 0;
     TRISB.TRISB2 = 0;
     RB2_bit = 0;
     TRISB.TRISB0 = 1;       //Entrada do RB0 para interrupção
     TRISB.TRISB1 = 1;
     CSN = 1;                //Pino CSN do SPI
     CE = 0;                 //NRF em standby - I
     
     TRISB.TRISB7 = 1;
     TRISB.TRISB6 = 1;
     TRISB.TRISB5 = 1;
     TRISB.TRISB4 = 1;
     TRISD.TRISD0 = 0;

     // CONFIGURAÇÃO DE INTERRUPÇÃO
     INTCON = 0b11010000;          //Configuração de interrupções e flags de interrupção (Timer0, RB0)

     //Inicia Protocolo SPI
     SPI1_Init();
     delay_ms(100);

     Config_NRF();                 // Configura NRF24L01+
     
     while(1){
                       delay_ms(1000);
                       valor = 0;
                       if(RIGHT)
                                valor = 1;
                       if(UP)
                             valor = 2;
                       if(DOWN)
                               valor = 3;
                       if(LEFT)
                               valor = 4;

                       LED = RIGHT || UP || DOWN || LEFT;
                       Send_NRF(valor);
                       delay_ms(100);
                       
                       //FLush TX
                       CSN = 0;
                       SPI1_Write(0xE1);
                       CSN = 1;

                       //STATUS - Reseta as flags de interrupção
                       CSN = 0;
                       SPI1_Write(0x27);
                       SPI1_Write(0x70);
                       CSN = 1;

     }
}