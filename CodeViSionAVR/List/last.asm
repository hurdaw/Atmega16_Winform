
;CodeVisionAVR C Compiler V2.05.0 Professional
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega16
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1119
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _tram=R5
	.DEF _chuc=R4
	.DEF _chuclcd=R7
	.DEF _dvilcd=R6
	.DEF _dvi=R9
	.DEF _dem=R8
	.DEF _rx_data=R11
	.DEF _cnt=R10
	.DEF _i=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  _ext_int0_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  _usart_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x3:
	.DB  0xF0
_0x4:
	.DB  0xBD
_0x5:
	.DB  0x4E,0x68,0x69,0x65,0x74,0x20,0x64,0x6F
	.DB  0x20,0x6C,0x61,0x3A,0x20
_0x5B:
	.DB  0x0,0x0,0x0,0x0,0x0,0x0
_0x0:
	.DB  0x46,0x30,0x42,0x44,0x0,0x45,0x31,0x37
	.DB  0x43,0x0,0x44,0x32,0x33,0x41,0x0,0x43
	.DB  0x32,0x46,0x38,0x0,0x42,0x33,0x42,0x35
	.DB  0x0,0x41,0x34,0x37,0x33,0x0,0x39,0x35
	.DB  0x33,0x31,0x0,0x38,0x35,0x45,0x46,0x0
	.DB  0x37,0x36,0x41,0x43,0x0,0x36,0x37,0x36
	.DB  0x41,0x0,0x25,0x64,0x0,0x6E,0x68,0x69
	.DB  0x65,0x74,0x20,0x64,0x6F,0x3A,0x20,0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x01
	.DW  _tcn1
	.DW  _0x3*2

	.DW  0x01
	.DW  _tcn2
	.DW  _0x4*2

	.DW  0x05
	.DW  _0x3A
	.DW  _0x0*2

	.DW  0x05
	.DW  _0x3A+5
	.DW  _0x0*2+5

	.DW  0x05
	.DW  _0x3A+10
	.DW  _0x0*2+10

	.DW  0x05
	.DW  _0x3A+15
	.DW  _0x0*2+15

	.DW  0x05
	.DW  _0x3A+20
	.DW  _0x0*2+20

	.DW  0x05
	.DW  _0x3A+25
	.DW  _0x0*2+25

	.DW  0x05
	.DW  _0x3A+30
	.DW  _0x0*2+30

	.DW  0x05
	.DW  _0x3A+35
	.DW  _0x0*2+35

	.DW  0x05
	.DW  _0x3A+40
	.DW  _0x0*2+40

	.DW  0x05
	.DW  _0x3A+45
	.DW  _0x0*2+45

	.DW  0x0B
	.DW  _0x57
	.DW  _0x0*2+53

	.DW  0x06
	.DW  0x08
	.DW  _0x5B*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 21-Dec-2023
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <string.h>
;#include <delay.h>
;
;// Alphanumeric LCD Module functions
;#include <alcd.h>
;
;// External Interrupt 0 service routine
;
;#ifndef RXB8
;#define RXB8 1
;#endif
;
;#ifndef TXB8
;#define TXB8 0
;#endif
;
;#ifndef UPE
;#define UPE 2
;#endif
;
;#ifndef DOR
;#define DOR 3
;#endif
;
;#ifndef FE
;#define FE 4
;#endif
;
;#ifndef UDRE
;#define UDRE 5
;#endif
;
;#ifndef RXC
;#define RXC 7
;#endif
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<DOR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;#define ADC_VREF_TYPE 0x00
;
;unsigned long ADC_OUT, dienap;
;unsigned char tram, chuc, chuclcd, dvilcd, dvi, txt[10], dem=0, rx_data,cnt;
;int i=0, tcn1=240, tcn2=189;

	.DSEG
;//unsigned char offLed[3];
;//char received_string[5];
;char count_str[10], temp[10], nhietdo, rx_buffer[5], myString[]="Nhiet do la: ";
;
;//void getstring(char *string, unsigned char length);
;
;void uart_char_send(unsigned char c){
; 0000 004D void uart_char_send(unsigned char c){

	.CSEG
_uart_char_send:
; 0000 004E     while(!(UCSRA & (1<<UDRE)));
;	c -> Y+0
_0x6:
	SBIS 0xB,5
	RJMP _0x6
; 0000 004F     UDR=c;
	LD   R30,Y
	OUT  0xC,R30
; 0000 0050 }
	JMP  _0x2080002
;
;void uart_string_send(unsigned char *txt, char terminator){
; 0000 0052 void uart_string_send(unsigned char *txt, char terminator){
_uart_string_send:
; 0000 0053     unsigned long n, i;
; 0000 0054     n=strlen(txt);
	SBIW R28,8
;	*txt -> Y+9
;	terminator -> Y+8
;	n -> Y+4
;	i -> Y+0
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _strlen
	CLR  R22
	CLR  R23
	__PUTD1S 4
; 0000 0055     for(i=0;i<n;i++){
	LDI  R30,LOW(0)
	CALL __CLRD1S0
_0xA:
	__GETD1S 4
	CALL __GETD2S0
	CALL __CPD21
	BRSH _0xB
; 0000 0056         uart_char_send(txt[i]);
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+9
	LDD  R27,Y+9+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 0057     }
	CALL __GETD1S0
	__SUBD1N -1
	CALL __PUTD1S0
	RJMP _0xA
_0xB:
; 0000 0058     uart_char_send(terminator);
	LDD  R30,Y+8
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 0059 }
	ADIW R28,11
	RET
;char uart_receive(){
; 0000 005A char uart_receive(){
; 0000 005B      while(!(UCSRA & (1<<RXC)));
; 0000 005C      return UDR;
; 0000 005D }
;void uart_string_receive(){
; 0000 005E void uart_string_receive(){
; 0000 005F      char rx=uart_receive();
; 0000 0060      for(i=0;i<10;i++){
;	rx -> R17
; 0000 0061         txt[i]=rx;
; 0000 0062      }
; 0000 0063 }
;// interrupt receive
;//char rx_buffer[5];
;interrupt [USART_RXC] void usart_rx_isr (void){
; 0000 0066 interrupt [12] void usart_rx_isr (void){
_usart_rx_isr:
	CALL SUBOPT_0x0
; 0000 0067     char data;
; 0000 0068     data = UDR;
	ST   -Y,R17
;	data -> R17
	IN   R17,12
; 0000 0069     //uart_char_send(data);
; 0000 006A     if(data=='a'){
	CPI  R17,97
	BRNE _0x12
; 0000 006B         PORTB.0=~PORTB.0;
	SBIS 0x18,0
	RJMP _0x13
	CBI  0x18,0
	RJMP _0x14
_0x13:
	SBI  0x18,0
_0x14:
; 0000 006C     }else if(data=='b'){
	RJMP _0x15
_0x12:
	CPI  R17,98
	BRNE _0x16
; 0000 006D         PORTB.1=~PORTB.1;
	SBIS 0x18,1
	RJMP _0x17
	CBI  0x18,1
	RJMP _0x18
_0x17:
	SBI  0x18,1
_0x18:
; 0000 006E     }else if(data=='c'){
	RJMP _0x19
_0x16:
	CPI  R17,99
	BRNE _0x1A
; 0000 006F         PORTB.2=~PORTB.2;
	SBIS 0x18,2
	RJMP _0x1B
	CBI  0x18,2
	RJMP _0x1C
_0x1B:
	SBI  0x18,2
_0x1C:
; 0000 0070     }else if(data=='d'){
	RJMP _0x1D
_0x1A:
	CPI  R17,100
	BRNE _0x1E
; 0000 0071         PORTB.3=~PORTB.3;
	SBIS 0x18,3
	RJMP _0x1F
	CBI  0x18,3
	RJMP _0x20
_0x1F:
	SBI  0x18,3
_0x20:
; 0000 0072     }else if(data=='e'){
	RJMP _0x21
_0x1E:
	CPI  R17,101
	BRNE _0x22
; 0000 0073         PORTB.4=~PORTB.4;
	SBIS 0x18,4
	RJMP _0x23
	CBI  0x18,4
	RJMP _0x24
_0x23:
	SBI  0x18,4
_0x24:
; 0000 0074     }else if(data=='f'){
	RJMP _0x25
_0x22:
	CPI  R17,102
	BRNE _0x26
; 0000 0075         PORTB.5=~PORTB.5;
	SBIS 0x18,5
	RJMP _0x27
	CBI  0x18,5
	RJMP _0x28
_0x27:
	SBI  0x18,5
_0x28:
; 0000 0076     }else if(data=='g'){
	RJMP _0x29
_0x26:
	CPI  R17,103
	BRNE _0x2A
; 0000 0077         PORTB.6=~PORTB.6;
	SBIS 0x18,6
	RJMP _0x2B
	CBI  0x18,6
	RJMP _0x2C
_0x2B:
	SBI  0x18,6
_0x2C:
; 0000 0078     }else if(data=='h'){
	RJMP _0x2D
_0x2A:
	CPI  R17,104
	BRNE _0x2E
; 0000 0079         PORTB.7=~PORTB.7;
	SBIS 0x18,7
	RJMP _0x2F
	CBI  0x18,7
	RJMP _0x30
_0x2F:
	SBI  0x18,7
_0x30:
; 0000 007A     }
; 0000 007B     if(data>='A'&&data<='F'||data>='0'&&data<='9'){
_0x2E:
_0x2D:
_0x29:
_0x25:
_0x21:
_0x1D:
_0x19:
_0x15:
	CPI  R17,65
	BRLO _0x32
	CPI  R17,71
	BRLO _0x34
_0x32:
	CPI  R17,48
	BRLO _0x35
	CPI  R17,58
	BRLO _0x34
_0x35:
	RJMP _0x31
_0x34:
; 0000 007C         rx_buffer[i]=data;
	MOVW R30,R12
	SUBI R30,LOW(-_rx_buffer)
	SBCI R31,HIGH(-_rx_buffer)
	ST   Z,R17
; 0000 007D         i++;
	MOVW R30,R12
	ADIW R30,1
	MOVW R12,R30
; 0000 007E     }
; 0000 007F     if(i==4){
_0x31:
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R12
	CPC  R31,R13
	BREQ PC+3
	JMP _0x38
; 0000 0080          if(strcmp(rx_buffer, "F0BD")==0){
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,0
	CALL SUBOPT_0x2
	BRNE _0x39
; 0000 0081             tcn1=240;
	LDI  R30,LOW(240)
	LDI  R31,HIGH(240)
	CALL SUBOPT_0x3
; 0000 0082             tcn2=189;
	LDI  R30,LOW(189)
	LDI  R31,HIGH(189)
	RJMP _0x59
; 0000 0083     }else if(strcmp(rx_buffer, "E17C")==0){
_0x39:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,5
	CALL SUBOPT_0x2
	BRNE _0x3C
; 0000 0084             tcn1=225;
	LDI  R30,LOW(225)
	LDI  R31,HIGH(225)
	CALL SUBOPT_0x3
; 0000 0085             tcn2=124;
	LDI  R30,LOW(124)
	LDI  R31,HIGH(124)
	RJMP _0x59
; 0000 0086     }else if(strcmp(rx_buffer, "D23A")==0){
_0x3C:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,10
	CALL SUBOPT_0x2
	BRNE _0x3E
; 0000 0087             tcn1=210;
	LDI  R30,LOW(210)
	LDI  R31,HIGH(210)
	CALL SUBOPT_0x3
; 0000 0088             tcn2=58;
	LDI  R30,LOW(58)
	LDI  R31,HIGH(58)
	RJMP _0x59
; 0000 0089     }else if(strcmp(rx_buffer, "C2F8")==0){
_0x3E:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,15
	CALL SUBOPT_0x2
	BRNE _0x40
; 0000 008A             tcn1=194;
	LDI  R30,LOW(194)
	LDI  R31,HIGH(194)
	CALL SUBOPT_0x3
; 0000 008B             tcn2=248;
	LDI  R30,LOW(248)
	LDI  R31,HIGH(248)
	RJMP _0x59
; 0000 008C     }else if(strcmp(rx_buffer, "B3B5")==0){
_0x40:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,20
	CALL SUBOPT_0x2
	BRNE _0x42
; 0000 008D             tcn1=179;
	LDI  R30,LOW(179)
	LDI  R31,HIGH(179)
	CALL SUBOPT_0x3
; 0000 008E             tcn2=181;
	LDI  R30,LOW(181)
	LDI  R31,HIGH(181)
	RJMP _0x59
; 0000 008F     }else if(strcmp(rx_buffer, "A473")==0){
_0x42:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,25
	CALL SUBOPT_0x2
	BRNE _0x44
; 0000 0090             tcn1=164;
	LDI  R30,LOW(164)
	LDI  R31,HIGH(164)
	CALL SUBOPT_0x3
; 0000 0091             tcn2=115;
	LDI  R30,LOW(115)
	LDI  R31,HIGH(115)
	RJMP _0x59
; 0000 0092     }else if(strcmp(rx_buffer, "9531")==0){
_0x44:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,30
	CALL SUBOPT_0x2
	BRNE _0x46
; 0000 0093             tcn1=149;
	LDI  R30,LOW(149)
	LDI  R31,HIGH(149)
	CALL SUBOPT_0x3
; 0000 0094             tcn2=49;
	LDI  R30,LOW(49)
	LDI  R31,HIGH(49)
	RJMP _0x59
; 0000 0095     }else if(strcmp(rx_buffer, "85EF")==0){
_0x46:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,35
	CALL SUBOPT_0x2
	BRNE _0x48
; 0000 0096             tcn1=133;
	LDI  R30,LOW(133)
	LDI  R31,HIGH(133)
	CALL SUBOPT_0x3
; 0000 0097             tcn2=239;
	LDI  R30,LOW(239)
	LDI  R31,HIGH(239)
	RJMP _0x59
; 0000 0098     }else if(strcmp(rx_buffer, "76AC")==0){
_0x48:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,40
	CALL SUBOPT_0x2
	BRNE _0x4A
; 0000 0099             tcn1=118;
	LDI  R30,LOW(118)
	LDI  R31,HIGH(118)
	CALL SUBOPT_0x3
; 0000 009A             tcn2=172;
	LDI  R30,LOW(172)
	LDI  R31,HIGH(172)
	RJMP _0x59
; 0000 009B     }else if(strcmp(rx_buffer, "676A")==0){
_0x4A:
	CALL SUBOPT_0x1
	__POINTW1MN _0x3A,45
	CALL SUBOPT_0x2
	BRNE _0x4C
; 0000 009C             tcn1=103;
	LDI  R30,LOW(103)
	LDI  R31,HIGH(103)
	CALL SUBOPT_0x3
; 0000 009D             tcn2=106;
	LDI  R30,LOW(106)
	LDI  R31,HIGH(106)
_0x59:
	STS  _tcn2,R30
	STS  _tcn2+1,R31
; 0000 009E     }
; 0000 009F         i=0;
_0x4C:
	CLR  R12
	CLR  R13
; 0000 00A0     }
; 0000 00A1 }
_0x38:
	LD   R17,Y+
	RJMP _0x5A

	.DSEG
_0x3A:
	.BYTE 0x32
;// Standard Input/Output functions
;#include <stdio.h>
;
;// Timer1 overflow interrupt service routine
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0000 00A7 {

	.CSEG
_timer1_ovf_isr:
	ST   -Y,R30
; 0000 00A8     // khoi tao thanh ghi
; 0000 00A9     TCNT1H=tcn1;
	CALL SUBOPT_0x4
; 0000 00AA     TCNT1L=tcn2;
; 0000 00AB     PORTC.0=~PORTC.0;
	SBIS 0x15,0
	RJMP _0x4D
	CBI  0x15,0
	RJMP _0x4E
_0x4D:
	SBI  0x15,0
_0x4E:
; 0000 00AC }
	LD   R30,Y+
	RETI
;
;//External Interrupt 0 service routine
;interrupt [EXT_INT0] void ext_int0_isr(void)
; 0000 00B0 {
_ext_int0_isr:
	CALL SUBOPT_0x0
; 0000 00B1     cnt++;
	INC  R10
; 0000 00B2     PORTC.5=~PORTC.5;
	SBIS 0x15,5
	RJMP _0x4F
	CBI  0x15,5
	RJMP _0x50
_0x4F:
	SBI  0x15,5
_0x50:
; 0000 00B3     chuc=cnt/10;
	MOV  R26,R10
	CALL SUBOPT_0x5
; 0000 00B4     dvi=cnt%10;
	MOV  R26,R10
	CALL SUBOPT_0x6
; 0000 00B5 
; 0000 00B6     uart_char_send(chuc+0x30);
	MOV  R30,R4
	SUBI R30,-LOW(48)
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 00B7     uart_char_send(dvi+0x30);
	MOV  R30,R9
	SUBI R30,-LOW(48)
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 00B8     uart_char_send('#');
	LDI  R30,LOW(35)
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 00B9 
; 0000 00BA }
_0x5A:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 00BE {
_read_adc:
; 0000 00BF ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
;	adc_input -> Y+0
	LD   R30,Y
	OUT  0x7,R30
; 0000 00C0 // Delay needed for the stabilization of the ADC input voltage
; 0000 00C1 delay_us(10);
	__DELAY_USB 27
; 0000 00C2 // Start the AD conversion
; 0000 00C3 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 00C4 // Wait for the AD conversion to complete
; 0000 00C5 while ((ADCSRA & 0x10)==0);
_0x51:
	SBIS 0x6,4
	RJMP _0x51
; 0000 00C6 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 00C7 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	JMP  _0x2080002
; 0000 00C8 }
;void send_temp(){
; 0000 00C9 void send_temp(){
_send_temp:
; 0000 00CA         ADC_OUT=read_adc(0);
	CALL SUBOPT_0x7
; 0000 00CB         dienap = ADC_OUT*5000/1023;
	CALL SUBOPT_0x8
; 0000 00CC         nhietdo=dienap/10;
; 0000 00CD 
; 0000 00CE         chuc=nhietdo/10;
; 0000 00CF         dvi=nhietdo%10;
	LDS  R26,_nhietdo
	CALL SUBOPT_0x6
; 0000 00D0         sprintf(temp, "%d", nhietdo);
	CALL SUBOPT_0x9
	CALL SUBOPT_0xA
; 0000 00D1         uart_string_send(temp, '$');
	CALL SUBOPT_0x9
	LDI  R30,LOW(36)
	ST   -Y,R30
	RCALL _uart_string_send
; 0000 00D2         delay_ms(200);
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CALL SUBOPT_0xB
; 0000 00D3         uart_char_send(13);
	LDI  R30,LOW(13)
	ST   -Y,R30
	RCALL _uart_char_send
; 0000 00D4 }
	RET
;
;void main(void)
; 0000 00D7 {
_main:
; 0000 00D8 // Declare your local variables here
; 0000 00D9 
; 0000 00DA // Input/Output Ports initialization
; 0000 00DB // Port A initialization
; 0000 00DC // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 00DD // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 00DE PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 00DF DDRA=0x00;
	OUT  0x1A,R30
; 0000 00E0 
; 0000 00E1 // Port B initialization
; 0000 00E2 // Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 00E3 // State7=0 State6=0 State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 00E4 PORTB=0x00;
	OUT  0x18,R30
; 0000 00E5 DDRB=0xFF;
	LDI  R30,LOW(255)
	OUT  0x17,R30
; 0000 00E6 
; 0000 00E7 // Port C initialization
; 0000 00E8 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=Out
; 0000 00E9 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=0
; 0000 00EA PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 00EB DDRC=0x21;
	LDI  R30,LOW(33)
	OUT  0x14,R30
; 0000 00EC 
; 0000 00ED // Port D initialization
; 0000 00EE // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In
; 0000 00EF // State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T
; 0000 00F0 PORTD=0x04;
	LDI  R30,LOW(4)
	OUT  0x12,R30
; 0000 00F1 DDRD=0x02;
	LDI  R30,LOW(2)
	OUT  0x11,R30
; 0000 00F2 
; 0000 00F3 // Timer/Counter 0 initialization
; 0000 00F4 // Clock source: System Clock
; 0000 00F5 // Clock value: Timer 0 Stopped
; 0000 00F6 // Mode: Normal top=0xFF
; 0000 00F7 // OC0 output: Disconnected
; 0000 00F8 TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 00F9 TCNT0=0x00;
	OUT  0x32,R30
; 0000 00FA OCR0=0x00;
	OUT  0x3C,R30
; 0000 00FB 
; 0000 00FC // Timer/Counter 1 initialization
; 0000 00FD // Clock source: System Clock
; 0000 00FE // Clock value: 7.813 kHz
; 0000 00FF // Mode: Normal top=0xFFFF
; 0000 0100 // OC1A output: Discon.
; 0000 0101 // OC1B output: Discon.
; 0000 0102 // Noise Canceler: Off
; 0000 0103 // Input Capture on Falling Edge
; 0000 0104 // Timer1 Overflow Interrupt: On
; 0000 0105 // Input Capture Interrupt: Off
; 0000 0106 // Compare A Match Interrupt: Off
; 0000 0107 // Compare B Match Interrupt: Off
; 0000 0108 TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 0109 TCCR1B=0x05;
	LDI  R30,LOW(5)
	OUT  0x2E,R30
; 0000 010A 
; 0000 010B TCNT1H=tcn1;
	CALL SUBOPT_0x4
; 0000 010C TCNT1L=tcn2;
; 0000 010D 
; 0000 010E ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0000 010F ICR1L=0x00;
	OUT  0x26,R30
; 0000 0110 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0111 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0112 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0113 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0114 
; 0000 0115 // Timer/Counter 2 initialization
; 0000 0116 // Clock source: System Clock
; 0000 0117 // Clock value: Timer2 Stopped
; 0000 0118 // Mode: Normal top=0xFF
; 0000 0119 // OC2 output: Disconnected
; 0000 011A ASSR=0x00;
	OUT  0x22,R30
; 0000 011B TCCR2=0x00;
	OUT  0x25,R30
; 0000 011C TCNT2=0x00;
	OUT  0x24,R30
; 0000 011D OCR2=0x00;
	OUT  0x23,R30
; 0000 011E 
; 0000 011F // External Interrupt(s) initialization
; 0000 0120 // INT0: On
; 0000 0121 // INT0 Mode: Falling Edge
; 0000 0122 // INT1: Off
; 0000 0123 // INT2: Off
; 0000 0124 GICR|=0x40;
	IN   R30,0x3B
	ORI  R30,0x40
	OUT  0x3B,R30
; 0000 0125 MCUCR=0x02;
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 0126 MCUCSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0127 GIFR=0x40;
	LDI  R30,LOW(64)
	OUT  0x3A,R30
; 0000 0128 
; 0000 0129 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 012A TIMSK=0x04;
	LDI  R30,LOW(4)
	OUT  0x39,R30
; 0000 012B 
; 0000 012C // USART initialization
; 0000 012D // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0000 012E // USART Receiver: On
; 0000 012F // USART Transmitter: On
; 0000 0130 // USART Mode: Asynchronous
; 0000 0131 // USART Baud Rate: 9600
; 0000 0132 UCSRA=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
; 0000 0133 UCSRB=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0000 0134 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
; 0000 0135 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
; 0000 0136 UBRRL=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0000 0137 
; 0000 0138 // Analog Comparator initialization
; 0000 0139 // Analog Comparator: Off
; 0000 013A // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 013B ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 013C SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 013D 
; 0000 013E 
; 0000 013F // ADC initialization
; 0000 0140 // ADC Clock frequency: 1000.000 kHz
; 0000 0141 // ADC Voltage Reference: AREF pin
; 0000 0142 // ADC Auto Trigger Source: ADC Stopped
; 0000 0143 ADMUX=ADC_VREF_TYPE & 0xff;
	OUT  0x7,R30
; 0000 0144 ADCSRA=0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
; 0000 0145 
; 0000 0146 // SPI initialization
; 0000 0147 // SPI disabled
; 0000 0148 SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 0149 
; 0000 014A // TWI initialization
; 0000 014B // TWI disabled
; 0000 014C TWCR=0x00;
	OUT  0x36,R30
; 0000 014D 
; 0000 014E // Alphanumeric LCD initialization
; 0000 014F // Connections specified in the
; 0000 0150 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 0151 // RS - PORTA Bit 7
; 0000 0152 // RD - PORTA Bit 6
; 0000 0153 // EN - PORTA Bit 5
; 0000 0154 // D4 - PORTA Bit 4
; 0000 0155 // D5 - PORTA Bit 3
; 0000 0156 // D6 - PORTA Bit 2
; 0000 0157 // D7 - PORTA Bit 1
; 0000 0158 // Characters/line: 16
; 0000 0159 lcd_init(16);
	LDI  R30,LOW(16)
	ST   -Y,R30
	CALL _lcd_init
; 0000 015A 
; 0000 015B // Global enable interrupts
; 0000 015C #asm("sei")
	sei
; 0000 015D ADC_OUT=read_adc(0);
	CALL SUBOPT_0x7
; 0000 015E 
; 0000 015F while (1)
_0x54:
; 0000 0160       {
; 0000 0161         ADC_OUT=read_adc(0);
	CALL SUBOPT_0x7
; 0000 0162         dienap = ADC_OUT*5000/1023;
	CALL SUBOPT_0x8
; 0000 0163         nhietdo=dienap/10;
; 0000 0164 
; 0000 0165         chuc=nhietdo/10;
; 0000 0166         dvi=nhietdo%10;
	LDS  R26,_nhietdo
	CALL SUBOPT_0x6
; 0000 0167 
; 0000 0168         sprintf(temp, "%d", nhietdo);
	CALL SUBOPT_0x9
	CALL SUBOPT_0xA
; 0000 0169         lcd_gotoxy(0, 0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	CALL _lcd_gotoxy
; 0000 016A         lcd_puts("nhiet do: ");
	__POINTW1MN _0x57,0
	ST   -Y,R31
	ST   -Y,R30
	CALL _lcd_puts
; 0000 016B         lcd_gotoxy(9, 0);
	LDI  R30,LOW(9)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _lcd_gotoxy
; 0000 016C         lcd_putchar(chuc+0x30);
	MOV  R30,R4
	SUBI R30,-LOW(48)
	ST   -Y,R30
	CALL _lcd_putchar
; 0000 016D         lcd_putchar(dvi+0x30);
	MOV  R30,R9
	SUBI R30,-LOW(48)
	ST   -Y,R30
	CALL _lcd_putchar
; 0000 016E 
; 0000 016F         send_temp();
	RCALL _send_temp
; 0000 0170       }
	RJMP _0x54
; 0000 0171 }
_0x58:
	RJMP _0x58

	.DSEG
_0x57:
	.BYTE 0xB

	.CSEG
_strcmp:
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
strcmp0:
    ld   r22,x+
    ld   r23,z+
    cp   r22,r23
    brne strcmp1
    tst  r22
    brne strcmp0
strcmp3:
    clr  r30
    ret
strcmp1:
    sub  r22,r23
    breq strcmp3
    ldi  r30,1
    brcc strcmp2
    subi r30,2
strcmp2:
    ret
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
_strlenf:
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2020004
	SBI  0x1B,4
	RJMP _0x2020005
_0x2020004:
	CBI  0x1B,4
_0x2020005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2020006
	SBI  0x1B,3
	RJMP _0x2020007
_0x2020006:
	CBI  0x1B,3
_0x2020007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2020008
	SBI  0x1B,2
	RJMP _0x2020009
_0x2020008:
	CBI  0x1B,2
_0x2020009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x202000A
	SBI  0x1B,1
	RJMP _0x202000B
_0x202000A:
	CBI  0x1B,1
_0x202000B:
	__DELAY_USB 5
	SBI  0x1B,5
	__DELAY_USB 13
	CBI  0x1B,5
	__DELAY_USB 13
	RJMP _0x2080002
__lcd_write_data:
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	RJMP _0x2080002
_lcd_gotoxy:
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R30,R26
	ST   -Y,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
_lcd_clear:
	LDI  R30,LOW(2)
	CALL SUBOPT_0xC
	LDI  R30,LOW(12)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(1)
	CALL SUBOPT_0xC
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
_lcd_putchar:
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2020010
_0x2020011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,__lcd_y
	SUBI R30,-LOW(1)
	STS  __lcd_y,R30
	ST   -Y,R30
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020013
	RJMP _0x2080002
_0x2020013:
_0x2020010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,7
	LD   R30,Y
	ST   -Y,R30
	RCALL __lcd_write_data
	CBI  0x1B,7
	RJMP _0x2080002
_lcd_puts:
	ST   -Y,R17
_0x2020014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020016
	ST   -Y,R17
	RCALL _lcd_putchar
	RJMP _0x2020014
_0x2020016:
	LDD  R17,Y+0
	ADIW R28,3
	RET
_lcd_init:
	SBI  0x1A,4
	SBI  0x1A,3
	SBI  0x1A,2
	SBI  0x1A,1
	SBI  0x1A,5
	SBI  0x1A,7
	SBI  0x1A,6
	CBI  0x1B,5
	CBI  0x1B,7
	CBI  0x1B,6
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	CALL SUBOPT_0xB
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	CALL SUBOPT_0xD
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R30,LOW(40)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(4)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(133)
	ST   -Y,R30
	RCALL __lcd_write_data
	LDI  R30,LOW(6)
	ST   -Y,R30
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080002:
	ADIW R28,1
	RET
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G102:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2040010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2040012
	__CPWRN 16,17,2
	BRLO _0x2040013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2040012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2040014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2040014:
_0x2040013:
	RJMP _0x2040015
_0x2040010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2040015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
__print_G102:
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2040016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+3
	JMP _0x2040018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x204001C
	CPI  R18,37
	BRNE _0x204001D
	LDI  R17,LOW(1)
	RJMP _0x204001E
_0x204001D:
	CALL SUBOPT_0xE
_0x204001E:
	RJMP _0x204001B
_0x204001C:
	CPI  R30,LOW(0x1)
	BRNE _0x204001F
	CPI  R18,37
	BRNE _0x2040020
	CALL SUBOPT_0xE
	RJMP _0x20400C9
_0x2040020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2040021
	LDI  R16,LOW(1)
	RJMP _0x204001B
_0x2040021:
	CPI  R18,43
	BRNE _0x2040022
	LDI  R20,LOW(43)
	RJMP _0x204001B
_0x2040022:
	CPI  R18,32
	BRNE _0x2040023
	LDI  R20,LOW(32)
	RJMP _0x204001B
_0x2040023:
	RJMP _0x2040024
_0x204001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2040025
_0x2040024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2040026
	ORI  R16,LOW(128)
	RJMP _0x204001B
_0x2040026:
	RJMP _0x2040027
_0x2040025:
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0x204001B
_0x2040027:
	CPI  R18,48
	BRLO _0x204002A
	CPI  R18,58
	BRLO _0x204002B
_0x204002A:
	RJMP _0x2040029
_0x204002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x204001B
_0x2040029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x204002F
	CALL SUBOPT_0xF
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x10
	RJMP _0x2040030
_0x204002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2040032
	CALL SUBOPT_0xF
	CALL SUBOPT_0x11
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2040033
_0x2040032:
	CPI  R30,LOW(0x70)
	BRNE _0x2040035
	CALL SUBOPT_0xF
	CALL SUBOPT_0x11
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2040033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2040036
_0x2040035:
	CPI  R30,LOW(0x64)
	BREQ _0x2040039
	CPI  R30,LOW(0x69)
	BRNE _0x204003A
_0x2040039:
	ORI  R16,LOW(4)
	RJMP _0x204003B
_0x204003A:
	CPI  R30,LOW(0x75)
	BRNE _0x204003C
_0x204003B:
	LDI  R30,LOW(_tbl10_G102*2)
	LDI  R31,HIGH(_tbl10_G102*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x204003D
_0x204003C:
	CPI  R30,LOW(0x58)
	BRNE _0x204003F
	ORI  R16,LOW(8)
	RJMP _0x2040040
_0x204003F:
	CPI  R30,LOW(0x78)
	BREQ PC+3
	JMP _0x2040071
_0x2040040:
	LDI  R30,LOW(_tbl16_G102*2)
	LDI  R31,HIGH(_tbl16_G102*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x204003D:
	SBRS R16,2
	RJMP _0x2040042
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2040043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2040043:
	CPI  R20,0
	BREQ _0x2040044
	SUBI R17,-LOW(1)
	RJMP _0x2040045
_0x2040044:
	ANDI R16,LOW(251)
_0x2040045:
	RJMP _0x2040046
_0x2040042:
	CALL SUBOPT_0xF
	CALL SUBOPT_0x12
_0x2040046:
_0x2040036:
	SBRC R16,0
	RJMP _0x2040047
_0x2040048:
	CP   R17,R21
	BRSH _0x204004A
	SBRS R16,7
	RJMP _0x204004B
	SBRS R16,2
	RJMP _0x204004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x204004D
_0x204004C:
	LDI  R18,LOW(48)
_0x204004D:
	RJMP _0x204004E
_0x204004B:
	LDI  R18,LOW(32)
_0x204004E:
	CALL SUBOPT_0xE
	SUBI R21,LOW(1)
	RJMP _0x2040048
_0x204004A:
_0x2040047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x204004F
_0x2040050:
	CPI  R19,0
	BREQ _0x2040052
	SBRS R16,3
	RJMP _0x2040053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2040054
_0x2040053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2040054:
	CALL SUBOPT_0xE
	CPI  R21,0
	BREQ _0x2040055
	SUBI R21,LOW(1)
_0x2040055:
	SUBI R19,LOW(1)
	RJMP _0x2040050
_0x2040052:
	RJMP _0x2040056
_0x204004F:
_0x2040058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x204005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x204005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x204005A
_0x204005C:
	CPI  R18,58
	BRLO _0x204005D
	SBRS R16,3
	RJMP _0x204005E
	SUBI R18,-LOW(7)
	RJMP _0x204005F
_0x204005E:
	SUBI R18,-LOW(39)
_0x204005F:
_0x204005D:
	SBRC R16,4
	RJMP _0x2040061
	CPI  R18,49
	BRSH _0x2040063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2040062
_0x2040063:
	RJMP _0x20400CA
_0x2040062:
	CP   R21,R19
	BRLO _0x2040067
	SBRS R16,0
	RJMP _0x2040068
_0x2040067:
	RJMP _0x2040066
_0x2040068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2040069
	LDI  R18,LOW(48)
_0x20400CA:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x204006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x204006B
	SUBI R21,LOW(1)
_0x204006B:
_0x204006A:
_0x2040069:
_0x2040061:
	CALL SUBOPT_0xE
	CPI  R21,0
	BREQ _0x204006C
	SUBI R21,LOW(1)
_0x204006C:
_0x2040066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2040059
	RJMP _0x2040058
_0x2040059:
_0x2040056:
	SBRS R16,0
	RJMP _0x204006D
_0x204006E:
	CPI  R21,0
	BREQ _0x2040070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x10
	RJMP _0x204006E
_0x2040070:
_0x204006D:
_0x2040071:
_0x2040030:
_0x20400C9:
	LDI  R17,LOW(0)
_0x204001B:
	RJMP _0x2040016
_0x2040018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
_sprintf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x13
	SBIW R30,0
	BRNE _0x2040072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x2040072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x13
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G102)
	LDI  R31,HIGH(_put_buff_G102)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R28
	ADIW R30,10
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G102
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2080001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET

	.CSEG

	.DSEG
_ADC_OUT:
	.BYTE 0x4
_dienap:
	.BYTE 0x4
_txt:
	.BYTE 0xA
_tcn1:
	.BYTE 0x2
_tcn2:
	.BYTE 0x2
_temp:
	.BYTE 0xA
_nhietdo:
	.BYTE 0x1
_rx_buffer:
	.BYTE 0x5
__base_y_G101:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x0:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(_rx_buffer)
	LDI  R31,HIGH(_rx_buffer)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:24 WORDS
SUBOPT_0x2:
	ST   -Y,R31
	ST   -Y,R30
	CALL _strcmp
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3:
	STS  _tcn1,R30
	STS  _tcn1+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	LDS  R30,_tcn1
	OUT  0x2D,R30
	LDS  R30,_tcn2
	OUT  0x2C,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	LDI  R27,0
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	MOV  R4,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	CLR  R27
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21
	MOV  R9,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _read_adc
	CLR  R22
	CLR  R23
	STS  _ADC_OUT,R30
	STS  _ADC_OUT+1,R31
	STS  _ADC_OUT+2,R22
	STS  _ADC_OUT+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x8:
	LDS  R30,_ADC_OUT
	LDS  R31,_ADC_OUT+1
	LDS  R22,_ADC_OUT+2
	LDS  R23,_ADC_OUT+3
	__GETD2N 0x1388
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3FF
	CALL __DIVD21U
	STS  _dienap,R30
	STS  _dienap+1,R31
	STS  _dienap+2,R22
	STS  _dienap+3,R23
	LDS  R26,_dienap
	LDS  R27,_dienap+1
	LDS  R24,_dienap+2
	LDS  R25,_dienap+3
	__GETD1N 0xA
	CALL __DIVD21U
	STS  _nhietdo,R30
	LDS  R26,_nhietdo
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(_temp)
	LDI  R31,HIGH(_temp)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xA:
	__POINTW1FN _0x0,50
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_nhietdo
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xB:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	ST   -Y,R30
	CALL __lcd_write_data
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP SUBOPT_0xB

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(48)
	ST   -Y,R30
	CALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0xE:
	ST   -Y,R18
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0xF:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x10:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+17
	LDD  R31,Y+17+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x11:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__CLRD1S0:
	ST   Y,R30
	STD  Y+1,R30
	STD  Y+2,R30
	STD  Y+3,R30
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
