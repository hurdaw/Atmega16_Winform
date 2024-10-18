/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 21-Dec-2023
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <string.h>
#include <delay.h>

// Alphanumeric LCD Module functions
#include <alcd.h>

// External Interrupt 0 service routine

#ifndef RXB8
#define RXB8 1
#endif

#ifndef TXB8
#define TXB8 0
#endif

#ifndef UPE
#define UPE 2
#endif

#ifndef DOR
#define DOR 3
#endif

#ifndef FE
#define FE 4
#endif

#ifndef UDRE
#define UDRE 5
#endif

#ifndef RXC
#define RXC 7
#endif

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<DOR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
#define ADC_VREF_TYPE 0x00

unsigned long ADC_OUT, dienap;
unsigned char tram, chuc, chuclcd, dvilcd, dvi, txt[10], dem=0, rx_data,cnt;
int i=0, tcn1=240, tcn2=189;
//unsigned char offLed[3];
//char received_string[5];   
char count_str[10], temp[10], nhietdo, rx_buffer[5], myString[]="Nhiet do la: ";

//void getstring(char *string, unsigned char length);

void uart_char_send(unsigned char c){
    while(!(UCSRA & (1<<UDRE)));
    UDR=c;
}

void uart_string_send(unsigned char *txt, char terminator){
    unsigned long n, i;
    n=strlen(txt);  
    for(i=0;i<n;i++){
        uart_char_send(txt[i]);
    } 
    uart_char_send(terminator);    
}
char uart_receive(){
     while(!(UCSRA & (1<<RXC)));
     return UDR;
}
void uart_string_receive(){
     char rx=uart_receive();
     for(i=0;i<10;i++){
        txt[i]=rx;        
     }    
}
// interrupt receive
//char rx_buffer[5];
interrupt [USART_RXC] void usart_rx_isr (void){
    char data;
    data = UDR;
    //uart_char_send(data);
    if(data=='a'){
        PORTB.0=~PORTB.0;
    }else if(data=='b'){
        PORTB.1=~PORTB.1;        
    }else if(data=='c'){
        PORTB.2=~PORTB.2;        
    }else if(data=='d'){
        PORTB.3=~PORTB.3;        
    }else if(data=='e'){
        PORTB.4=~PORTB.4;        
    }else if(data=='f'){
        PORTB.5=~PORTB.5;        
    }else if(data=='g'){
        PORTB.6=~PORTB.6;        
    }else if(data=='h'){
        PORTB.7=~PORTB.7;        
    }
    if(data>='A'&&data<='F'||data>='0'&&data<='9'){
        rx_buffer[i]=data;
        i++;
    }
    if(i==4){  
         if(strcmp(rx_buffer, "F0BD")==0){
            tcn1=240; 
            tcn2=189;
    }else if(strcmp(rx_buffer, "E17C")==0){
            tcn1=225;
            tcn2=124;            
    }else if(strcmp(rx_buffer, "D23A")==0){
            tcn1=210;
            tcn2=58;
    }else if(strcmp(rx_buffer, "C2F8")==0){
            tcn1=194;
            tcn2=248;
    }else if(strcmp(rx_buffer, "B3B5")==0){
            tcn1=179;
            tcn2=181;
    }else if(strcmp(rx_buffer, "A473")==0){
            tcn1=164;
            tcn2=115;
    }else if(strcmp(rx_buffer, "9531")==0){
            tcn1=149;
            tcn2=49;
    }else if(strcmp(rx_buffer, "85EF")==0){
            tcn1=133;  
            tcn2=239;
    }else if(strcmp(rx_buffer, "76AC")==0){
            tcn1=118;
            tcn2=172;
    }else if(strcmp(rx_buffer, "676A")==0){
            tcn1=103;
            tcn2=106;
    }   
        i=0;                                     
    }
}
// Standard Input/Output functions
#include <stdio.h>

// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
    // khoi tao thanh ghi
    TCNT1H=tcn1;
    TCNT1L=tcn2;       
    PORTC.0=~PORTC.0;
}

//External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
    cnt++;
    PORTC.5=~PORTC.5;
    chuc=cnt/10;
    dvi=cnt%10; 
                       
    uart_char_send(chuc+0x30);
    uart_char_send(dvi+0x30); 
    uart_char_send('#');  
   
}

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}
void send_temp(){
        ADC_OUT=read_adc(0);                   
        dienap = ADC_OUT*5000/1023;
        nhietdo=dienap/10;
                            
        chuc=nhietdo/10;
        dvi=nhietdo%10;  
        sprintf(temp, "%d", nhietdo);  
        uart_string_send(temp, '$');
        delay_ms(200);
        uart_char_send(13);
}

void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0xFF;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=Out 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=0 
PORTC=0x00;
DDRC=0x21;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T 
PORTD=0x04;
DDRD=0x02;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 7.813 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x05;

TCNT1H=tcn1;
TCNT1L=tcn2; 

ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: On
// INT0 Mode: Falling Edge
// INT1: Off
// INT2: Off
GICR|=0x40;
MCUCR=0x02;
MCUCSR=0x00;
GIFR=0x40;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x04;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x33;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;


// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AREF pin
// ADC Auto Trigger Source: ADC Stopped
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x83;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

// Alphanumeric LCD initialization
// Connections specified in the
// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
// RS - PORTA Bit 7
// RD - PORTA Bit 6
// EN - PORTA Bit 5
// D4 - PORTA Bit 4
// D5 - PORTA Bit 3
// D6 - PORTA Bit 2
// D7 - PORTA Bit 1
// Characters/line: 16
lcd_init(16);

// Global enable interrupts
#asm("sei")
ADC_OUT=read_adc(0); 

while (1)
      {
        ADC_OUT=read_adc(0);                   
        dienap = ADC_OUT*5000/1023;
        nhietdo=dienap/10;
                            
        chuc=nhietdo/10;
        dvi=nhietdo%10;  
  
        sprintf(temp, "%d", nhietdo);
        lcd_gotoxy(0, 0);
        lcd_puts("nhiet do: ");
        lcd_gotoxy(9, 0);
        lcd_putchar(chuc+0x30);
        lcd_putchar(dvi+0x30);      
       
        send_temp();
      }
}
