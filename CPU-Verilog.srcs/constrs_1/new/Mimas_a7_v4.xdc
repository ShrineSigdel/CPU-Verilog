set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

####################################################################################################################
#                                               CLOCK 100MHz                                                       #
####################################################################################################################
set_property -dict { PACKAGE_PIN "H4"    IOSTANDARD LVCMOS33       SLEW FAST} [get_ports { CLK1 }]     ;                # IO_L12P_T1_MRCC_35            Sch = CLK1

####################################################################################################################
#                                                   RESET - S3                                                     #
####################################################################################################################
set_property -dict { PACKAGE_PIN "M2"    IOSTANDARD LVCMOS33   SLEW FAST   } [get_ports { RESET }]    ;                 # IO_L16N_T2_35                 Sch = RESET



####################################################################################################################
#                                               LEDs                                                               #
####################################################################################################################
set_property -dict { PACKAGE_PIN "K17"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[0] }];                      # IO_L21P_T3_DQS_15             Sch = LED0
set_property -dict { PACKAGE_PIN "J17"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[1] }];                      # IO_L21N_T3_DQS_A18_15         Sch = LED1
set_property -dict { PACKAGE_PIN "L14"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[2] }];                      # IO_L22P_T3_A17_15             Sch = LED2
set_property -dict { PACKAGE_PIN "L15"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[3] }];                      # IO_L22N_T3_A16_15             Sch = LED3
set_property -dict { PACKAGE_PIN "L16"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[4] }];                      # IO_L23P_T3_FOE_B_15           Sch = LED4
set_property -dict { PACKAGE_PIN "K16"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[5] }];                      # IO_L23N_T3_FWE_B_15           Sch = LED5
set_property -dict { PACKAGE_PIN "M15"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[6] }];                      # IO_L24P_T3_RS1_15             Sch = LED6
set_property -dict { PACKAGE_PIN "M16"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { LED[7] }];                      # IO_L24N_T3_RS0_15             Sch = LED7

####################################################################################################################
#                                               DIP Switches                                                       #
####################################################################################################################
set_property -dict { PACKAGE_PIN "B21"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[0] }];                   # IO_L21P_T3_DQS_16             Sch = DP0
set_property -dict { PACKAGE_PIN "A21"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[1] }];                   # IO_L21N_T3_DQS_16             Sch = DP1
set_property -dict { PACKAGE_PIN "E22"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[2] }];                   # IO_L22P_T3_16                 Sch = DP2
set_property -dict { PACKAGE_PIN "D22"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[3] }];                   # IO_L22N_T3_16                 Sch = DP3
set_property -dict { PACKAGE_PIN "E21"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[4] }];                   # IO_L23P_T3_16                 Sch = DP4
set_property -dict { PACKAGE_PIN "D21"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[5] }];                   # IO_L23N_T3_16                 Sch = DP5
set_property -dict { PACKAGE_PIN "G21"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[6] }];                   # IO_L24P_T3_16                 Sch = DP6
set_property -dict { PACKAGE_PIN "G22"   IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { dip_sw[7] }];                   # IO_L24N_T3_16                 Sch = DP7


####################################################################################################################
#                                               Seven Segment                                                      #
####################################################################################################################
set_property -dict { PACKAGE_PIN "N3"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { enable[0] }];                   # IO_L19N_T3_VREF_35            Sch = 7_SEG1_EN
set_property -dict { PACKAGE_PIN "R1"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { enable[1] }];                   # IO_L20P_T3_35                 Sch = 7_SEG2_EN
set_property -dict { PACKAGE_PIN "P1"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { enable[2] }];                   # IO_L20N_T3_35                 Sch = 7_SEG3_EN
set_property -dict { PACKAGE_PIN "L4"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { enable[3] }];                   # IO_L18N_T2_35                 Sch = 7_SEG4_EN
set_property -dict { PACKAGE_PIN "P4"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[0] }];            # IO_L21N_T3_DQS_35             Sch = 7SEG_0
set_property -dict { PACKAGE_PIN "N4"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[1] }];            # IO_L19P_T3_35                 Sch = 7SEG_1
set_property -dict { PACKAGE_PIN "M3"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[2] }];            # IO_L16P_T2_35                 Sch = 7SEG_2
set_property -dict { PACKAGE_PIN "M5"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[3] }];            # IO_L23N_T3_35                 Sch = 7SEG_3
set_property -dict { PACKAGE_PIN "L5"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[4] }];            # IO_L18P_T2_35                 Sch = 7SEG_4
set_property -dict { PACKAGE_PIN "L6"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[5] }];            # IO_25_35                      Sch = 7SEG_5
set_property -dict { PACKAGE_PIN "M6"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[6] }];            # IO_L23P_T3_35                 Sch = 7SEG_6
set_property -dict { PACKAGE_PIN "P5"    IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { seven_segment[7] }];            # IO_L21P_T3_DQS_35             Sch = 7SEG_7

####################################################################################################################
#                                               Push Buttons                                                       #
####################################################################################################################
set_property -dict { PACKAGE_PIN "P20"  IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { sw_in[0] }];                     # IO_0_14                       Sch = SW0
set_property -dict { PACKAGE_PIN "P19"  IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { sw_in[1] }];                     # IO_L5P_T0_D06_14              Sch = SW1
set_property -dict { PACKAGE_PIN "P17"  IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { sw_in[2] }];                     # IO_L21N_T3_DQS_A06_D22_14     Sch = SW2
set_property -dict { PACKAGE_PIN "N17"  IOSTANDARD LVCMOS33    SLEW FAST} [get_ports { sw_in[3] }];                     # IO_L21P_T3_DQS_14             Sch = SW3
