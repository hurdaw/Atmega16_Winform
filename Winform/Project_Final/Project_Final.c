z/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 14-Dec-2023
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
#include <delay.h>
#include <string.h>
// Standard Input/Output functions
#include <stdio.h>
// Alphanumeric LCD Module functions
#include <alcd.h>
#define ADC_VREF_TYPE 0x00

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

void uart_char_send(unsigned char c){
    while(!(UCSRA & (1<<UDRE)));
    UDR=c;
}

void uart_string_send(unsigned char *txt){
    unsigned char n, i;
    n=strlen(txt);
    for(i=0;i<n;i++){
        uart_char_send(txt[i]);
    }
}
char uart_receive(){
     while(!(UCSRA & (1<<UDRE)));
     return UDR;
}
// interrupt receive
interrupt [USART_RXC] void usart_rx_isr (void){
    char data;
    data = UDR;
    uart_char_send(data);
    lcd_gotoxy(0,0);
    lcd_putchar(data);
    if(data=='1'){
        PORTC.5=1;
    }else if(data=='a'){
        PORTC.5=0;
    }else if(data=='2'){
        PORTC.4=1;
    }else if(data=='b'){
        PORTC.4=0;
    }
}

// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
    PORTC.0=~PORTC.0;
}
// Declare your global variables here

unsigned long ADC_OUT, dienap, nhietdo;
unsigned char tram, chuc, dvi;

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
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0xFF;                                                                                         

// Port C initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x01;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=In 
// State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=T 
PORTD=0x00;
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
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x03;
TCNT1H=0x0B;
TCNT1L=0xDD;
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
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x04;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: On
// USART Transmitter: Off
// USART Mode: Asynchronous
// USART Baud Rate: 9600
UCSRA=0x00;
UCSRB=0x98;
UCSRC=0x03;
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
//            ADC_OUT=read_adc(0);
           
     
//            dienap = (ADC_OUT*5000)/1023;
//            nhietdo=dienap/10;
//            chuc=nhietdo/10;
//            dvi=nhietdo%10;
//
//              
//            uart_char_send(chuc+0x30);
//            uart_char_send(dvi+0x30);
//            uart_char_send(10);
//            uart_char_send(13);
//            delay_ms(100);  
        
      }
}

