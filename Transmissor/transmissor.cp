#line 1 "C:/Users/Eron Almeida/Desktop/Comunicação/Transmissor/transmissor.c"










unsigned short flag = 0, buff = 0,valor;

void interrupt(){
 if(INTF_bit){
 INTF_bit = 0;
 flag = 1;
 }
}

void Config_NRF(){


  RE1_bit  = 0;
 SPI1_Write(0x20);
 SPI1_Write(0x0E);
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
 SPI1_Write(0x24);
 SPI1_Write(0x01);
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
 SPI1_Write(0x30);
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x2A);
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
 SPI1_Write( 0x78 );
  RE1_bit  = 1;
}


void Send_NRF(unsigned short dat){

  RE1_bit  = 0;
 SPI1_Write(0b10100000);
 SPI1_Write(dat);
  RE1_bit  = 1;

  RE2_bit  = 1;
 delay_us(20);
  RE2_bit  = 0;
}

void main() {
 CMCON = 0x07;
 ADCON0 = 0b00000001;
 ADCON1 = 0b00001110;

 TRISE.TRISE1 = 0;
 TRISE.TRISE2 = 0;
 TRISB.TRISB2 = 0;
 RB2_bit = 0;
 TRISB.TRISB0 = 1;
 TRISB.TRISB1 = 1;
  RE1_bit  = 1;
  RE2_bit  = 0;

 TRISB.TRISB7 = 1;
 TRISB.TRISB6 = 1;
 TRISB.TRISB5 = 1;
 TRISB.TRISB4 = 1;
 TRISD.TRISD0 = 0;


 INTCON = 0b11010000;


 SPI1_Init();
 delay_ms(100);

 Config_NRF();

 while(1){
 delay_ms(1000);
 valor = 0;
 if( RB4_bit )
 valor = 1;
 if( RB5_bit )
 valor = 2;
 if( RB6_bit )
 valor = 3;
 if( RB7_bit )
 valor = 4;

  RD0_bit  =  RB4_bit  ||  RB5_bit  ||  RB6_bit  ||  RB7_bit ;
 Send_NRF(valor);
 delay_ms(100);


  RE1_bit  = 0;
 SPI1_Write(0xE1);
  RE1_bit  = 1;


  RE1_bit  = 0;
 SPI1_Write(0x27);
 SPI1_Write(0x70);
  RE1_bit  = 1;

 }
}
