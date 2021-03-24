#line 1 "C:/Users/Eron Almeida/Desktop/Comunicação/Receptor/receptor.c"










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



unsigned short buff1 = 0, flag = 0, store=0;
float temperature = 0.0;
char txt[15];


void interrupt(){

 if(INTF_bit){
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


  RE1_bit  = 0;
 SPI1_Write(0x20);
 SPI1_Write(0x0F);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x21);
 SPI1_Write(0x01);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x22);
 SPI1_Write(0x01);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x23);
 SPI1_Write(0x03);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x25);
 SPI1_Write(0x01);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x26);
 SPI1_Write(0x26);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x27);
 SPI1_Write(0x70);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x2A);
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x31);
 SPI1_Write(1);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0xE2);
  RE1_bit  = 1;

  RE2_bit  = 1;
 delay_us(130);
}


void main(){
 TRISD = 0x00;
 ADCON1 = 0x07;
 ADCON0 = 0x00;
 CMCON = 0x07;
 TRISE.TRISE1 = 0;
 TRISE.TRISE2 = 0;
 TRISB.TRISB0 = 1;
 TRISB.TRISB7 = 0;
  RE1_bit  = 1;
  RE2_bit  = 0;

 TRISB.TRISB6 = 0;
 TRISB.TRISB5 = 0;
 TRISB.TRISB4 = 0;
 TRISB.TRISB3 = 0;


 INTEDG_bit = 0;
 INTCON = 0b11010000;


 SPI1_Init();
 delay_ms(100);

 Config_NRF();

 Lcd_Init();
 Lcd_Cmd(_Lcd_Cursor_Off);
 Lcd_Cmd(_LCD_CLEAR);
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
 while(1){

 if(flag == 1){

 RB7_bit = 1;

  RE2_bit  = 0;
  RE1_bit  = 0;
 buff1 = SPI1_Read(0x61);
 store = SPI1_Read(0xFF);
  RE1_bit  = 1;

 temperature = store;

 if(store == 0)
 {
  RB5_bit  = 0;
  RB6_bit  = 0;
  RB3_bit  = 0;
  RB6_bit  = 0;
 Lcd_Out(2,1,"->   PARADO   <-");
 }
 if(store == 1)
 {
  RB5_bit  = 1;
  RB6_bit  = 0;
  RB3_bit  = 0;
  RB6_bit  = 1;
 Lcd_Out(2,1,"->   DIREITA  <-");
 }
 if(store == 2)
 {
  RB5_bit  = 0;
  RB6_bit  = 1;
  RB3_bit  = 0;
  RB6_bit  = 1;
 Lcd_Out(2,1,"->   FRENTE   <-");
 }
 if(store == 3)
 {
  RB5_bit  = 1;
  RB6_bit  = 0;
  RB3_bit  = 1;
  RB6_bit  = 0;
 Lcd_Out(2,1,"->    TRAS    <-");
 }
 if(store == 4)
 {
  RB5_bit  = 0;
  RB6_bit  = 1;
  RB3_bit  = 1;
  RB6_bit  = 0;
 Lcd_Out(2,1,"->  ESQUERDA  <-");
 }


  RE1_bit  = 0;
 SPI1_Write(0x27);
 SPI1_Write(0x70);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0xE2);
  RE1_bit  = 1;

 flag = 0;
  RE2_bit  = 1;

 }
 RB7_bit = 0;
 }

}
