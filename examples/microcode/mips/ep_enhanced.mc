
#
# WepSIM (https://wepsim.github.io/wepsim/)
#

begin
{
	  # if (NOT INT) go fetch
	    (A0=0, B=1, C=1, MADDR=fetch),
	  # push PC
	    (MR=1, SELA=11101, MA=0, MB=10, MC=1, SELCOP=1011, T6=1, SELC=11101, LC=1, C0),
	    (T2=1, M1=0, C1),
	    (BW=11, TA=1, TD=1, W=1)
	  # push SR
	    (MR=1, SELA=11101, MA=0, MB=10, MC=1, SELCOP=1011, T6=1, SELC=11101, LC=1, C0),
	    (T8=1, M1=0, C1),
	    (BW=11, TA=1, TD=1, W=1),
	  # MBR <- DB <- INTV
	    (INTA, BW=11, M1=1, C1=1),
	  # RT1 <- MBR
	    (T1=1, C4=1),
	  # MAR <- RT1*4
	    (MA=1, MB=10, MC=1, SELCOP=1100, T6, M2=0, C0),
	  # MBR <- MP[MAR]
	    (TA=1, R=1, BW=11, M1=1, C1=1),
	  # PC <- MAR
	    (T1, M2=0, C2),

fetch:
	  # MAR <- PC
	    (T2, C0),
	  # MBR <- M[MAR]
	    (TA, R, BW=11, M1=1, C1=1),
	  # RI <- MBR, PC <- PC + 4
	    (M2, C2, T1, C3),
	  # go co2maddr
	    (A0, B=0, C=0)
}


#
# INT
#

reti {
     co=111110,
     nwords=1,
     help='return from event (interruption, exception, syscall)',
     {
           # pop SR
           (MR=1, SELA=11101, T9, C0),
           (MR=1, SELA=11101, MA=0, MB=10, MC=1, SELCOP=1010, T6=1, SELC=11101, LC=1),
           (TA=1, R=1, BW=11, M1=1, C1),
           (T1=1, M7=0, C7),
           # pop PC
           (MR=1, SELA=11101, T9, C0),
           (MR=1, SELA=11101, MA=0, MB=10, MC=1, SELCOP=1010, T6=1, SELC=11101, LC=1),
           (TA=1, R=1, BW=11, M1=1, C1),
           (T1=1, M2=0, C2, A0=1, B=1 ,C=0)
     }
}


#
# ALU
#

and reg1 reg2 reg3 {
         co=000000,
         cop=0000,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 & r3',
         {
             (MC=1, MR=0, SELA=1011, SELB=10000, MA=0, MB=0, SELCOP=1, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

andi reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val =inm(15,0),
         help='r1 = r2 & val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C5=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=01, SELCOP=1, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

or reg1 reg2 reg3 {
         co=000000,
         cop=0001,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 | r3',
         {
             (MC=1, MR=0, SELA=1011, SELB=10000, MA=0, MB=0, SELCOP=10, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

ori reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val =inm(15,0),
         help='r1 = r2 | val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C5=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=01, SELCOP=10, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

not reg {
         co=000000,
         cop=0010,
         nwords=1,
         reg=reg(25,21),
         help='r1 = ~r1',
         {
             (MC=1, MR=0, SELA=10101, MA=0, SELCOP=11, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

xor reg1 reg2 reg3 {
         co=000000,
         cop=0011,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 ^ r3',
         {
             (MC=1, MR=0, SELA=1011, SELB=10000, MA=0, MB=0, SELCOP=100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

xori reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val =inm(15,0),
         help='r1 = r2 ^ val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C5=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=01, SELCOP=100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

add reg1 reg2 reg3 {
         co=000000,
         cop=1001,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 + r3',
         {
             (MC=1, MR=0, SELA=1011, SELB=10000, MA=0, MB=0, SELCOP=1010, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

addi reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         val  = inm(15,0),
         help ='r1 = r2 + val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C4=1),
             (MC=1, MR=0, SELB=10000, MA=1, MB=0, SELCOP=1010, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

sub reg1 reg2 reg3 {
         co=000000,
         cop=1010,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 - r3',
         {
             (MC=1, MR=0, SELB=1011, SELA=10000, MA=0, MB=0, SELCOP=1011, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

sub reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         val  = inm(15,0),
         help ='r1 = r2 - val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C5=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=1, SELCOP=1011, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

mul reg1 reg2 reg3 {
         co=000000,
         cop=1011,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 * r3',
         {
             (MC=1, MR=0, SELA=1011, SELB=10000, MA=0, MB=0, SELCOP=1100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

mul reg1 reg2 val {
         co=111111,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val  = inm(15,0),
         help='r1 = r2 * val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, C5=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=1, SELCOP=1100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

div reg1 reg2 reg3 {
         co=000000,
         cop=1100,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 / r3',
         {
             (MC=1, MR=0, SELB=1011, SELA=10000, MA=0, MB=0, SELCOP=1101, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

rem reg1 reg2 reg3 {
         co=000000,
         cop=1110,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         reg3=reg(15,11),
         help='r1 = r2 % r3',
         {
             (MC=1, MR=0, SELA=10000, SELB=1011, MA=0, MB=0, SELCOP=1110, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
         }
}

srl reg1 reg2 val {
         co=010111,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val=inm(5,0),
         help='$r1 = $r2 >>> val',
         {
             (SE=1, OFFSET=0, SIZE=110, T3=1, C4=1),
             (MC=1, MR=0, SELA=10000, MA=0, MB=11, SELCOP=1100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7),
      loop9: (A0=0, B=0, C=110, MADDR=bck9ftch),
             (MC=1, MR=0, SELA=10101, SELB=10101, MA=0, MB=0, SELCOP=101, T6=1, LC=1, SELC=10101),
             (MC=1, MR=0, MA=1, MB=11, SELCOP=1011, T6=1, C4=1, SELP=11, M7, C7),
             (A0=0, B=1, C=0, MADDR=loop9),
   bck9ftch: (A0=1, B=1, C=0)
         }
}

sll reg1 reg2 val {
         co=011000,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         val=inm(5,0),
         help='$r1 = $r2 << val',
         {
             (SE=1, OFFSET=0, SIZE=110, T3=1, C4=1, C5=1),
             (MC=1, MR=0, SELA=10000, SELB=10000, MA=0, MB=0, SELCOP=1, T6=1, SELC=10101),
             (MC=1, MR=0,                         MA=1, MB=1, SELCOP=1, SELP=11, M7, C7),
             (A0=0, B=0, C=110, MADDR=bckAftch),
      loopA: (MC=1, MR=0, SELA=10101, SELB=10101, MA=0, MB=0, SELCOP=111, T6=1, LC=1, SELC=10101),
             (MC=1, MR=0, MA=1, MB=11, SELCOP=1011, T6=1, C4=1, SELP=11, M7, C7),
             (A0=0, B=1, C=110, MADDR=loopA),
   bckAftch: (A0=1, B=1, C=0)
         }
}


#
# MV/L*
#

move reg1 reg2 {
         co=000001,
         nwords=1,
         reg1=reg(25,21),
         reg2=reg(20,16),
         help='r1 = r2',
         {
             (SELA=10000, T9, SELC=10101, LC, A0=1, B=1, C=0)
         }
}

li reg val {
         co=000010,
         nwords=1,
         reg=reg(25,21),
         val=inm(15,0),
         help='r1 = SignExt val',
         {
             (SE=1, OFFSET=0, SIZE=10000, T3=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

liu reg val {
         co=111100,
         nwords=1,
         reg=reg(25,21),
         val=inm(15,0),
         help='r1 = (00 00 val)',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

la  reg addr {
         co=000011,
         nwords=1,
         reg=reg(25,21),
         addr=address(15,0)abs,
         help='r1 = addr16',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

la  reg addr {
         co=111111,
         nwords=2,
         reg=reg(25,21),
         addr=address(63,32)abs,
         help='r1 = addr32',
         {
             (T2, C0),
             (TA, R, BW=11, M1=1, C1=1),
             (M2, C2, T1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

lw reg addr {
         co=000100,
         nwords=1,
         reg=reg(25,21),
         addr=address(15,0)abs,
         help='r1 = (MEM[addr] ... MEM[addr+3])',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (TA=1, R=1, BW=11, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

lw reg1 (reg2) {
         co=111001,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         help='$r1 = (MEM[$r2+3] ... MEM[$r2])',
         {
             (MR=0, SELA=10000, T9=1, C0),
             (TA=1, R=1, BW=11, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, SE=1, A0=1, B=1, C=0)
         }
}

lb reg1 (reg2) {
         co=100101,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         help='r1 = MEM[r2]',
         {
             (MR=0, SELA=10000, T9=1, C0),
             (TA=1, R=1, BW=00, SE=1, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, SE=1, A0=1, B=1, C=0)
         }
}

lbu reg1 (reg2) {
         co=101111,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         help ='$r1 = (00 00 00 MEM[$r2])',
         {
             (MR=0, SELA=10000, T9=1, C0),
             (TA=1, R=1, BW=00, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, SE=0, A0=1, B=1, C=0)
         }
}

lw reg1 (reg2) {
         co=100000,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         help='$r1 = (MEM[$r2+3] ... MEM[$r2])',
         {
             (MR=0, SELA=10000, T9=1, C0),
             (TA=1, R=1, BW=11, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

sw reg addr {
         co=000101,
         nwords=1,
         reg=reg(25,21),
         addr=address(15,0)abs,
         help='MEM[addr] = r1',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (MR=0, SELA=10101,    T9=1, M1=0, C1=1),
             (BW=11, TA=1, TD=1,     W=1,  A0=1, B=1, C=0)
         }
}

sw reg1 (reg2) {
         co=111010,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         {
             (MR=0,  SELA=10000, T9=1, C0=1),
             (MR=0,  SELA=10101, T9=1, M1=0, C1=1),
             (BW=11, TA=1, TD=1, W=1,  A0=1, B=1, C=0)
         }
}

lb reg addr {
         co=001000,
         nwords=1,
         reg=reg(25,21),
         addr=address(15,0)abs,
         help='r1 = MEM[addr]',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (TA=1, R=1, BW=00, SE=1, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

sb reg addr {
         co=001001,
         nwords=1,
         reg=reg(25,21),
         addr=address(15,0)abs,
         help='MEM[addr] = r1',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (MR=0, SELA=10101,    T9=1, M1=0, C1=1),
             (BW=0, TA=1, TD=1,     W=1,  A0=1, B=1, C=0)
         }
}

sb reg1 inm1(reg2) {
         co=111111,
         nwords=1,
         reg1 = reg(25,21),
         inm1 = inm(15,0),
         reg2 = reg(20,16),
         {
             (SE=1,  SIZE=10000, OFFSET=0, T3, C5),
             (MR=0,  SELA=10000, MB=1, MC=1, SELCOP=1010, T6=1, C0=1),
             (MR=0,  SELA=10101, T9=1, M1=0, C1=1),
             (BW=0,  TA=1, TD=1, W=1,  A0=1, B=1, C=0)
         }
}


#
# IN/OUT
#

in reg val {
         co=001010,
         nwords=1,
         reg=reg(25,21),
         val=inm(15,0),
         help='r1 = device_register(val)',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (TA=1, IOR=1,    M1=1, C1=1),
             (T1=1, LC=1,     MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}

out reg val {
         co=001011,
         nwords=1,
         reg=reg(25,21),
         val=inm(15,0),
         help='device_register(val) = r1',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, C0=1),
             (MR=0, SELA=10101,  T9=1,    M1=0, C1=1),
             (TA=1, TD=1, BW=11, IOW=1,   A0=1, B=1, C=0)
         }
}


#
# b*
#

b offset {
         co=001100,
         nwords=1,
         offset=address(15,0)rel,
         help='pc = pc + offset',
         {
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0)
         }
}

beq reg reg offset {
         co=001101,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 == $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=1, C=110, MADDR=bck2ftch),
             (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0),
   bck2ftch: (T5, M7=0, C7),
             (A0=1, B=1, C=0)
         }
}

bne reg reg offset {
         co=001110,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 != $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=0, C=110, MADDR=bck3ftch),
             (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0),
   bck3ftch: (T5, M7=0, C7),
             (A0=1, B=1, C=0)
         }
}

bge reg reg offset {
         co=001111,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 >= $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=0, C=111, MADDR=bck4ftch),
             (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0),
   bck4ftch: (T5, M7=0, C7),
             (A0=1, B=1, C=0)
         }
}

blt reg reg offset {
         co=010000,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 < $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=1, C=111, MADDR=bck5ftch),
             (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0),
   bck5ftch: (T5, M7=0, C7),
             (A0=1, B=1, C=0)
         }
}

bgt reg reg offset {
         co=010001,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 > $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=0, C=111, MADDR=bck6ftch),
             (A0=0, B=0, C=110, MADDR=bck6ftch),
             (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0),
   bck6ftch: (T5, M7=0, C7),
             (A0=1, B=1, C=0)
         }
}

ble reg reg offset {
         co=010010,
         nwords=1,
         reg=reg(25,21),
         reg=reg(20,16),
         offset=address(15,0)rel,
         help='if ($r1 <= $r2) pc += offset',
         {
             (T8, C5),
             (SELA=10101, SELB=10000, MC=1, SELCOP=1011, SELP=11, M7, C7),
             (A0=0, B=0, C=111, MADDR=ble_ys),
             (A0=0, B=0, C=110, MADDR=ble_ys),
             (T5, M7=0, C7),
             (A0=1, B=1, C=0),
     ble_ys: (T5, M7=0, C7),
             (T2, C4),
             (SE=1, OFFSET=0, SIZE=10000, T3, C5),
             (MA=1, MB=1, MC=1, SELCOP=1010, T6, C2, A0=1, B=1, C=0)
         }
}


#
# j*
#

j addr {
         co=010011,
         nwords=1,
         addr=address(15,0)abs,
         help='pc = addr',
         {
             (SE=0, OFFSET=0, SIZE=10000, T3=1, M2=0, C2=1, A0=1, B=1, C=0)
         }
}

jal addr {
         co=010100,
         nwords=1,
         addr=address(15,0)abs,
         help='$ra = pc; pc = addr',
         {
             (T2, SELC=11111, MR=1, LC),
             (SE=0, OFFSET=0, SIZE=10000, T3=1, M2=0, C2=1, A0=1, B=1, C=0)
         }
}

jr reg1 {
         co=010101,
         nwords=1,
         reg1=reg(25,21),
         help='pc = r1',
         {
             (SELA=10101, T9=1, C2=1, A0=1, B=1, C=0)
         }
}


#
# IEEE 754 (32 bits)
#

add.s reg1 reg2 reg3 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      reg3=reg(15,11),
      help='r1 = r2 + r3',
      {
          (MC=1, MR=0, SELA=10000, SELB=1011, MA=0, MB=0, SELCOP=10000, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

sub.s reg1 reg2 reg3 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      reg3=reg(15,11),
      help='r1 = r2 - r3',
      {
          (MC=1, MR=0, SELA=10000, SELB=1011, MA=0, MB=0, SELCOP=10001, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

mul.s reg1 reg2 reg3 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      reg3=reg(15,11),
      help='r1 = r2 * r3',
      {
          (MC=1, MR=0, SELA=10000, SELB=1011, MA=0, MB=0, SELCOP=10010, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

div.s reg1 reg2 reg3 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      reg3=reg(15,11),
      help='r1 = r2 / r3',
      {
          (MC=1, MR=0, SELA=10000, SELB=1011, MA=0, MB=0, SELCOP=10011, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

cvt.w.s reg1 reg2 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      help='r1 = float2int(r2)',
      {
          (MC=1, MR=0, SELA=10000, MA=0, MB=11, SELCOP=10100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

cvt.s.w reg1 reg2 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      help='r1 = int2float(r2)',
      {
          (MC=1, MR=0, SELA=10000, MA=0, MB=10, SELCOP=10100, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}

fclass.s reg1 reg2 {
      co=111111,
      nwords=1,
      reg1=reg(25,21),
      reg2=reg(20,16),
      help='r1 = classify(r2)',
      {
          (MC=1, MR=0, SELA=10000, SELB=0000, MA=0, MB=0, SELCOP=10101, T6=1, SELC=10101, LC=1, SELP=11, M7, C7, A0=1, B=1, C=0)
      }
}


#
# Misc
#

nop {
        co=010110,
        nwords=1,
        {
             (A0=1, B=1, C=0)
        }
}

savesr reg1 {
	co=100011,
	nwords=1,
	reg1 = reg(25,21),
	{
	     (T8=1, SELC=10101, LC=1, A0=1, B=1, C=0)
	}
}

restoresr reg1 {
	co=100100,
	nwords=1,
	reg1 = reg(25,21),
	{
	      (MR=0, SELA=10101, T9=1, M7=0, C7, A0=1, B=1, C=0)
	}
}

lw reg1 reg2+(reg3) {
         co=100110,
         nwords=1,
         reg1 = reg(25,21),
         reg2 = reg(20,16),
         reg3 = reg(15,11),
         {
             (MR=0, SELA=10000, MA=0, SELB=1011, MB=0, MC=1, SELCOP=1001, T6=1, C0),
             (TA=1, R=1, BW=11, M1=1, C1=1),
             (T1=1, LC=1, MR=0, SELC=10101, A0=1, B=1, C=0)
         }
}


##
## Register Section
##

registers
{
      0=($zero, $0),
      1=($at, $1),
      2=($v0, $2),
      3=($v1, $3),
      4=($a0, $4),
      5=($a1, $5),
      6=($a2, $6),
      7=($a3, $7),
      8=($t0, $8),
      9=($t1, $9),
     10=($t2, $10),
     11=($t3, $11),
     12=($t4, $12),
     13=($t5, $13),
     14=($t6, $14),
     15=($t7, $15),
     16=($s0, $16),
     17=($s1, $17),
     18=($s2, $18),
     19=($s3, $19),
     20=($s4, $20),
     21=($s5, $21),
     22=($s6, $22),
     23=($s7, $23),
     24=($t8, $24),
     25=($t9, $25),
     26=($k0, $26),
     27=($k1, $27),
     28=($gp, $28),
     29=($sp, $29) (stack_pointer),
     30=($fp, $30),
     31=($ra, $31)
}


##
## Pseudo-instructions Section
##

pseudoinstructions
{
	li reg1=reg num=inm
        {	
            li  reg1 sel(31,16,num)
            sll reg1 reg1 16
            li  $0   sel(15,0,num)
            or  reg1 reg1 $0
        }
}

