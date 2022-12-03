#
# WepSIM (https://wepsim.github.io/wepsim/)
#

.data
   palette: .byte    0x00, 0x00, 0x00, 0x00,
                     0x20, 0xff, 0xff, 0xff,
                     0x10, 0x80, 0xF0, 0xff,
                     0x00, 0x00, 0xff, 0xff,
                     0x00, 0x00, 0x80, 0xff,
                     0x00, 0x00, 0x80, 0x00,
                     0x00, 0x80, 0x00, 0xff,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0xFF, 0xFF, 0xFF,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0x00, 0x00, 0x00,
                     0x00, 0x00, 0x00, 0x00

   msg1: .byte 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,1,0,1,0,1,1,1, 0,1,1,1,0,1,1,1, 0,1,0,1,0,0,0,0,
               0,1,0,1,0,1,0,1, 0,1,0,1,0,1,0,1, 0,1,0,1,0,0,0,0,
               0,1,1,1,0,1,1,1, 0,1,1,1,0,1,1,1, 0,1,1,1,0,0,0,0,
               0,1,0,1,0,1,0,1, 0,1,0,0,0,1,0,0, 0,0,0,1,0,0,0,0,
               0,1,0,1,0,1,0,1, 0,1,0,0,0,1,0,0, 0,1,1,1,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,

               0,1,0,1,0,1,1,1, 0,1,1,1,0,1,1,1, 0,0,0,0,0,0,0,0,
               0,1,0,1,0,1,0,0, 0,1,0,1,0,1,0,1, 0,0,0,0,0,0,0,0,
               0,1,1,1,0,1,1,1, 0,1,1,1,0,1,0,1, 0,0,0,0,0,0,0,0,
               0,0,0,1,0,1,0,0, 0,1,0,1,0,1,1,0, 0,0,0,0,0,0,0,0,
               0,1,1,1,0,1,1,1, 0,1,0,1,0,1,0,1, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,

               0,1,1,1,0,1,1,1, 0,1,1,1,0,1,1,1, 0,0,1,0,0,0,0,0,
               0,0,0,1,0,1,0,1, 0,0,0,1,0,0,0,1, 0,0,1,0,0,0,0,0,
               0,1,1,1,0,1,0,1, 0,1,1,1,0,1,1,1, 0,0,1,0,0,0,0,0,
               0,1,0,0,0,1,0,1, 0,1,0,0,0,0,0,1, 0,0,0,0,0,0,0,0,
               0,1,1,1,0,1,1,1, 0,1,1,1,0,1,1,1, 0,0,1,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
               0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0

.text

   main:
           # out address to data
           la   s5 msg1
           out  s5 0x3108
           # out 'DMA'   to control
           li   s6 0x20
           out  s6 0x3104

           # for (i=10; i!=0; i--)
           li   s0 10
    loop3: beq  s0 zero end3

           # initial address
           la   t5 palette
           out  t5 0x3108
           # out 'DMA color' to control
           li   t6 0x40
           out  t6 0x3104

           # next
           li    t0 16
           mul   t0 s0 t0
           sbu   t0 4(t5)

           li    t0 32
           mul   t0 s0 t0
           sbu   t0 5(t5)

           li    t0 64
           mul   t0 s0 t0
           sbu   t0 6(t5)

           addi  s0 s0 -1
           beq zero zero loop3
     end3:
           # the end
           jr ra

