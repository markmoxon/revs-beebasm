\ ******************************************************************************
\
\ REVS BRANDS HATCH TRACK SOURCE
\
\ Revs was written by Geoffrey J Crammond and is copyright Acornsoft 1985
\
\ The code on this site has been reconstructed from a disassembly of the
\ original game binaries
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://revs.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://revs.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * BrandsHatch.bin
\
\ ******************************************************************************

GUARD &7C00             \ Guard against assembling over screen memory

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

LOAD% = &70DB           \ The load address of the track binary

CODE% = &5300           \ The assembly address of the track data

thisSectionFlags = &0001
thisVectorNumber = &0002
yStore = &001B
horizonLine = &001F
frontSegmentIndex = &0024
directionFacing = &0025
segmentCounter = &0042
playerPastSegment = &0043
xStore = &0045
vergeBufferEnd = &004B
horizonListIndex = &0051
playerSpeedHi = &0063
currentPlayer = &006F
T = &0074
U = &0075
V = &0076
W = &0077
topTrackLine = &007F
blockOffset = &0082
objTrackSection = &06E8
Multiply8x8 = &0C00
Absolute16Bit = &0E40
UpdateVectorNumber = &13E0
MovePlayerBack = &140B
CheckVergeOnScreen = &1933
gseg13 = &2490
gtrm2 = &2535
Absolute8Bit = &3450
MultiplyHeight = &4610
xTrackSegmentI = &5400
yTrackSegmentI = &5500
zTrackSegmentI = &5600
xTrackSegmentO = &5700
zTrackSegmentO = &5800
trackSectionFrom = &5905
xVergeRightLo = &5E40
xVergeLeftLo = &5E68
xVergeRightHi = &5E90
xVergeLeftHi = &5EB8
yVergeRight = &5F20
yVergeLeft = &5F48

\ ******************************************************************************
\
\ REVS BRANDS HATCH TRACK
\
\ Produces the binary file BrandsHatch.bin that contains the Brands Hatch track.
\
\ ******************************************************************************

ORG CODE%

.trackData

\ ******************************************************************************
\
\       Name: Track section data (Part 1 of 2)
\       Type: Variable
\   Category: Extra track data
\    Summary: Data for the track sections
\  Deep dive: The track data file format
\
\ ******************************************************************************

                        \ Track section 0

 EQUB &01               \ trackSectionData       sign = 0, sectionListSize = 1
 EQUB &D1               \ xTrackSectionIHi       xTrackSectionI = &D120 = -12000
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &1400 =   5120
 EQUB &0F               \ zTrackSectionIHi       zTrackSectionI = &0FA0 =   4000
 EQUB &D0               \ xTrackSectionOHi       xTrackSectionO = &D021 = -12255
 EQUB 52                \ trackSectionTurn
 EQUB &0F               \ zTrackSectionOHi       zTrackSectionO = &0FA0 =   4000
 EQUB 127               \ trackDriverSpeed

                        \ Track section 1

 EQUB &13               \ trackSectionData       sign = 1, sectionListSize = 3
 EQUB &D4               \ xTrackSectionIHi       xTrackSectionI = &D4DC = -11044
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &1487 =   5255
 EQUB &2A               \ zTrackSectionIHi       zTrackSectionI = &2A5C =  10844
 EQUB &D3               \ xTrackSectionOHi       xTrackSectionO = &D3F6 = -11274
 EQUB 41                \ trackSectionTurn
 EQUB &2A               \ zTrackSectionOHi       zTrackSectionO = &2AC8 =  10952
 EQUB 28                \ trackDriverSpeed

                        \ Track section 2

 EQUB &22               \ trackSectionData       sign = 2, sectionListSize = 2
 EQUB &E0               \ xTrackSectionIHi       xTrackSectionI = &E052 =  -8110
 EQUB &0F               \ yTrackSectionIHi       yTrackSectionI = &0F2B =   3883
 EQUB &2D               \ zTrackSectionIHi       zTrackSectionI = &2DE3 =  11747
 EQUB &E0               \ xTrackSectionOHi       xTrackSectionO = &E0B5 =  -8011
 EQUB 255               \ trackSectionTurn
 EQUB &2E               \ zTrackSectionOHi       zTrackSectionO = &2ECC =  11980
 EQUB 255               \ trackDriverSpeed

                        \ Track section 3

 EQUB &31               \ trackSectionData       sign = 3, sectionListSize = 1
 EQUB &EA               \ xTrackSectionIHi       xTrackSectionI = &EA2B =  -5589
 EQUB &0E               \ yTrackSectionIHi       yTrackSectionI = &0EDE =   3806
 EQUB &29               \ zTrackSectionIHi       zTrackSectionI = &2996 =  10646
 EQUB &EA               \ xTrackSectionOHi       xTrackSectionO = &EAAA =  -5462
 EQUB 22                \ trackSectionTurn
 EQUB &2A               \ zTrackSectionOHi       zTrackSectionO = &2A73 =  10867
 EQUB 73                \ trackDriverSpeed

                        \ Track section 4

 EQUB &31               \ trackSectionData       sign = 3, sectionListSize = 1
 EQUB &F3               \ xTrackSectionIHi       xTrackSectionI = &F3EB =  -3093
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &116C =   4460
 EQUB &23               \ zTrackSectionIHi       zTrackSectionI = &23F6 =   9206
 EQUB &F4               \ xTrackSectionOHi       xTrackSectionO = &F46A =  -2966
 EQUB 24                \ trackSectionTurn
 EQUB &24               \ zTrackSectionOHi       zTrackSectionO = &24D3 =   9427
 EQUB 6                 \ trackDriverSpeed

                        \ Track section 5

 EQUB &43               \ trackSectionData       sign = 4, sectionListSize = 3
 EQUB &F1               \ xTrackSectionIHi       xTrackSectionI = &F171 =  -3727
 EQUB &0D               \ yTrackSectionIHi       yTrackSectionI = &0D53 =   3411
 EQUB &1E               \ zTrackSectionIHi       zTrackSectionI = &1E53 =   7763
 EQUB &F1               \ xTrackSectionOHi       xTrackSectionO = &F100 =  -3840
 EQUB 21                \ trackSectionTurn
 EQUB &1D               \ zTrackSectionOHi       zTrackSectionO = &1D6D =   7533
 EQUB 255               \ trackDriverSpeed

                        \ Track section 6

 EQUB &44               \ trackSectionData       sign = 4, sectionListSize = 4
 EQUB &E6               \ xTrackSectionIHi       xTrackSectionI = &E60D =  -6643
 EQUB &08               \ yTrackSectionIHi       yTrackSectionI = &0843 =   2115
 EQUB &23               \ zTrackSectionIHi       zTrackSectionI = &23EA =   9194
 EQUB &E5               \ xTrackSectionOHi       xTrackSectionO = &E59C =  -6756
 EQUB 31                \ trackSectionTurn
 EQUB &23               \ zTrackSectionOHi       zTrackSectionO = &2304 =   8964
 EQUB 18                \ trackDriverSpeed

                        \ Track section 7

 EQUB &53               \ trackSectionData       sign = 5, sectionListSize = 3
 EQUB &DE               \ xTrackSectionIHi       xTrackSectionI = &DE2F =  -8657
 EQUB &05               \ yTrackSectionIHi       yTrackSectionI = &05EB =   1515
 EQUB &21               \ zTrackSectionIHi       zTrackSectionI = &2120 =   8480
 EQUB &DE               \ xTrackSectionOHi       xTrackSectionO = &DEF0 =  -8464
 EQUB 1                 \ trackSectionTurn
 EQUB &20               \ zTrackSectionOHi       zTrackSectionO = &207A =   8314
 EQUB 255               \ trackDriverSpeed

                        \ Track section 8

 EQUB &54               \ trackSectionData       sign = 5, sectionListSize = 4
 EQUB &DA               \ xTrackSectionIHi       xTrackSectionI = &DA39 =  -9671
 EQUB &05               \ yTrackSectionIHi       yTrackSectionI = &05EB =   1515
 EQUB &1C               \ zTrackSectionIHi       zTrackSectionI = &1C81 =   7297
 EQUB &DA               \ xTrackSectionOHi       xTrackSectionO = &DAFA =  -9478
 EQUB 39                \ trackSectionTurn
 EQUB &1B               \ zTrackSectionOHi       zTrackSectionO = &1BDB =   7131
 EQUB 19                \ trackDriverSpeed

                        \ Track section 9

 EQUB &53               \ trackSectionData       sign = 5, sectionListSize = 3
 EQUB &D8               \ xTrackSectionIHi       xTrackSectionI = &D836 = -10186
 EQUB &05               \ yTrackSectionIHi       yTrackSectionI = &05EB =   1515
 EQUB &16               \ zTrackSectionIHi       zTrackSectionI = &16CE =   5838
 EQUB &D9               \ xTrackSectionOHi       xTrackSectionO = &D930 =  -9936
 EQUB 43                \ trackSectionTurn
 EQUB &16               \ zTrackSectionOHi       zTrackSectionO = &16A1 =   5793
 EQUB 117               \ trackDriverSpeed

                        \ Track section 10

 EQUB &62               \ trackSectionData       sign = 6, sectionListSize = 2
 EQUB &D9               \ xTrackSectionIHi       xTrackSectionI = &D90A =  -9974
 EQUB &05               \ yTrackSectionIHi       yTrackSectionI = &05EB =   1515
 EQUB &01               \ zTrackSectionIHi       zTrackSectionI = &0152 =    338
 EQUB &DA               \ xTrackSectionOHi       xTrackSectionO = &DA00 =  -9728
 EQUB 40                \ trackSectionTurn
 EQUB &01               \ zTrackSectionOHi       zTrackSectionO = &018F =    399
 EQUB 20                \ trackDriverSpeed

                        \ Track section 11

 EQUB &61               \ trackSectionData       sign = 6, sectionListSize = 1
 EQUB &E5               \ xTrackSectionIHi       xTrackSectionI = &E558 =  -6824
 EQUB &0A               \ yTrackSectionIHi       yTrackSectionI = &0ADF =   2783
 EQUB &FC               \ zTrackSectionIHi       zTrackSectionI = &FC7C =   -900
 EQUB &E4               \ xTrackSectionOHi       xTrackSectionO = &E496 =  -7018
 EQUB 1                 \ trackSectionTurn
 EQUB &FD               \ zTrackSectionOHi       zTrackSectionO = &FD21 =   -735
 EQUB 123               \ trackDriverSpeed

                        \ Track section 12

 EQUB &73               \ trackSectionData       sign = 7, sectionListSize = 3
 EQUB &EF               \ xTrackSectionIHi       xTrackSectionI = &EF18 =  -4328
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &1173 =   4467
 EQUB &07               \ zTrackSectionIHi       zTrackSectionI = &07DC =   2012
 EQUB &EE               \ xTrackSectionOHi       xTrackSectionO = &EE56 =  -4522
 EQUB 255               \ trackSectionTurn
 EQUB &08               \ zTrackSectionOHi       zTrackSectionO = &0881 =   2177
 EQUB 255               \ trackDriverSpeed

                        \ Track section 13

 EQUB &82               \ trackSectionData       sign = 8, sectionListSize = 2
 EQUB &06               \ xTrackSectionIHi       xTrackSectionI = &0661 =   1633
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &1132 =   4402
 EQUB &1B               \ zTrackSectionIHi       zTrackSectionI = &1B7F =   7039
 EQUB &05               \ xTrackSectionOHi       xTrackSectionO = &05C5 =   1477
 EQUB 255               \ trackSectionTurn
 EQUB &1C               \ zTrackSectionOHi       zTrackSectionO = &1C4B =   7243
 EQUB 255               \ trackDriverSpeed

                        \ Track section 14

 EQUB &81               \ trackSectionData       sign = 8, sectionListSize = 1
 EQUB &12               \ xTrackSectionIHi       xTrackSectionI = &1261 =   4705
 EQUB &0E               \ yTrackSectionIHi       yTrackSectionI = &0E12 =   3602
 EQUB &24               \ zTrackSectionIHi       zTrackSectionI = &249F =   9375
 EQUB &11               \ xTrackSectionOHi       xTrackSectionO = &11C5 =   4549
 EQUB 19                \ trackSectionTurn
 EQUB &25               \ zTrackSectionOHi       zTrackSectionO = &256B =   9579
 EQUB 142               \ trackDriverSpeed

                        \ Track section 15

 EQUB &90               \ trackSectionData       sign = 9, sectionListSize = 0
 EQUB &1B               \ xTrackSectionIHi       xTrackSectionI = &1B61 =   7009
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &11C0 =   4544
 EQUB &2B               \ zTrackSectionIHi       zTrackSectionI = &2B77 =  11127
 EQUB &1A               \ xTrackSectionOHi       xTrackSectionO = &1AC5 =   6853
 EQUB 46                \ trackSectionTurn
 EQUB &2C               \ zTrackSectionOHi       zTrackSectionO = &2C43 =  11331
 EQUB 23                \ trackDriverSpeed

                        \ Track section 16

 EQUB &92               \ trackSectionData       sign = 9, sectionListSize = 2
 EQUB &2A               \ xTrackSectionIHi       xTrackSectionI = &2AA6 =  10918
 EQUB &15               \ yTrackSectionIHi       yTrackSectionI = &15DC =   5596
 EQUB &2A               \ zTrackSectionIHi       zTrackSectionI = &2AF6 =  10998
 EQUB &2B               \ xTrackSectionOHi       xTrackSectionO = &2B63 =  11107
 EQUB 50                \ trackSectionTurn
 EQUB &2B               \ zTrackSectionOHi       zTrackSectionO = &2BA2 =  11170
 EQUB 127               \ trackDriverSpeed

                        \ Track section 17

 EQUB &A1               \ trackSectionData       sign = 10, sectionListSize = 1
 EQUB &3C               \ xTrackSectionIHi       xTrackSectionI = &3C0D =  15373
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &14C9 =   5321
 EQUB &17               \ zTrackSectionIHi       zTrackSectionI = &17D7 =   6103
 EQUB &3C               \ xTrackSectionOHi       xTrackSectionO = &3CCA =  15562
 EQUB 37                \ trackSectionTurn
 EQUB &18               \ zTrackSectionOHi       zTrackSectionO = &1883 =   6275
 EQUB 18                \ trackDriverSpeed

                        \ Track section 18

 EQUB &A3               \ trackSectionData       sign = 10, sectionListSize = 3
 EQUB &3A               \ xTrackSectionIHi       xTrackSectionI = &3A6B =  14955
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &14A8 =   5288
 EQUB &0C               \ zTrackSectionIHi       zTrackSectionI = &0C7C =   3196
 EQUB &3B               \ xTrackSectionOHi       xTrackSectionO = &3B17 =  15127
 EQUB 21                \ trackSectionTurn
 EQUB &0B               \ zTrackSectionOHi       zTrackSectionO = &0BBE =   3006
 EQUB 255               \ trackDriverSpeed

                        \ Track section 19

 EQUB &A2               \ trackSectionData       sign = 10, sectionListSize = 2
 EQUB &2D               \ xTrackSectionIHi       xTrackSectionI = &2D35 =  11573
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &1128 =   4392
 EQUB &00               \ zTrackSectionIHi       zTrackSectionI = &0076 =    118
 EQUB &2D               \ xTrackSectionOHi       xTrackSectionO = &2DE1 =  11745
 EQUB 40                \ trackSectionTurn
 EQUB &FF               \ zTrackSectionOHi       zTrackSectionO = &FFB8 = -72
 EQUB 20                \ trackDriverSpeed

                        \ Track section 20

 EQUB &A1               \ trackSectionData       sign = 10, sectionListSize = 1
 EQUB &29               \ xTrackSectionIHi       xTrackSectionI = &29E7 =  10727
 EQUB &11               \ yTrackSectionIHi       yTrackSectionI = &11AC =   4524
 EQUB &FE               \ zTrackSectionIHi       zTrackSectionI = &FEC6 =   -314
 EQUB &2A               \ xTrackSectionOHi       xTrackSectionO = &2A28 =  10792
 EQUB 21                \ trackSectionTurn
 EQUB &FD               \ zTrackSectionOHi       zTrackSectionO = &FDCF =   -561
 EQUB 123               \ trackDriverSpeed

                        \ Track section 21

 EQUB &B1               \ trackSectionData       sign = 11, sectionListSize = 1
 EQUB &1D               \ xTrackSectionIHi       xTrackSectionI = &1D37 =   7479
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &14A0 =   5280
 EQUB &FB               \ zTrackSectionIHi       zTrackSectionI = &FB62 =  -1182
 EQUB &1D               \ xTrackSectionOHi       xTrackSectionO = &1D78 =   7544
 EQUB 24                \ trackSectionTurn
 EQUB &FA               \ zTrackSectionOHi       zTrackSectionO = &FA6B =  -1429
 EQUB 12                \ trackDriverSpeed

                        \ Track section 22

 EQUB &B3               \ trackSectionData       sign = 11, sectionListSize = 3
 EQUB &18               \ xTrackSectionIHi       xTrackSectionI = &18F2 =   6386
 EQUB &15               \ yTrackSectionIHi       yTrackSectionI = &1509 =   5385
 EQUB &FC               \ zTrackSectionIHi       zTrackSectionI = &FC9E =   -866
 EQUB &18               \ xTrackSectionOHi       xTrackSectionO = &1834 =   6196
 EQUB 33                \ trackSectionTurn
 EQUB &FB               \ zTrackSectionOHi       zTrackSectionO = &FBF1 =  -1039
 EQUB 108               \ trackDriverSpeed

                        \ Track section 23

 EQUB &C2               \ trackSectionData       sign = 12, sectionListSize = 2
 EQUB &0C               \ xTrackSectionIHi       xTrackSectionI = &0CEC =   3308
 EQUB &14               \ yTrackSectionIHi       yTrackSectionI = &1497 =   5271
 EQUB &09               \ zTrackSectionIHi       zTrackSectionI = &09D4 =   2516
 EQUB &0C               \ xTrackSectionOHi       xTrackSectionO = &0C2E =   3118
 EQUB 27                \ trackSectionTurn
 EQUB &09               \ zTrackSectionOHi       zTrackSectionO = &0927 =   2343
 EQUB 13                \ trackDriverSpeed

                        \ Track section 24

 EQUB &C1               \ trackSectionData       sign = 12, sectionListSize = 1
 EQUB &05               \ xTrackSectionIHi       xTrackSectionI = &05D0 =   1488
 EQUB &15               \ yTrackSectionIHi       yTrackSectionI = &1599 =   5529
 EQUB &0A               \ zTrackSectionIHi       zTrackSectionI = &0A0B =   2571
 EQUB &06               \ xTrackSectionOHi       xTrackSectionO = &067E =   1662
 EQUB 255               \ trackSectionTurn
 EQUB &09               \ zTrackSectionOHi       zTrackSectionO = &0950 =   2384
 EQUB 255               \ trackDriverSpeed

                        \ Track section 25

 EQUB &D3               \ trackSectionData       sign = 13, sectionListSize = 3
 EQUB &F9               \ xTrackSectionIHi       xTrackSectionI = &F970 =  -1680
 EQUB &19               \ yTrackSectionIHi       yTrackSectionI = &1923 =   6435
 EQUB &FE               \ zTrackSectionIHi       zTrackSectionI = &FE83 =   -381
 EQUB &FA               \ xTrackSectionOHi       xTrackSectionO = &FA1E =  -1506
 EQUB 47                \ trackSectionTurn
 EQUB &FD               \ zTrackSectionOHi       zTrackSectionO = &FDC8 =   -568
 EQUB 125               \ trackDriverSpeed

                        \ Track section 26

 EQUB &E2               \ trackSectionData       sign = 14, sectionListSize = 2
 EQUB &E5               \ xTrackSectionIHi       xTrackSectionI = &E5D8 =  -6696
 EQUB &19               \ yTrackSectionIHi       yTrackSectionI = &193C =   6460
 EQUB &EC               \ zTrackSectionIHi       zTrackSectionI = &EC41 =  -5055
 EQUB &E6               \ xTrackSectionOHi       xTrackSectionO = &E686 =  -6522
 EQUB 42                \ trackSectionTurn
 EQUB &EB               \ zTrackSectionOHi       zTrackSectionO = &EB86 =  -5242
 EQUB 24                \ trackDriverSpeed

                        \ Track section 27

 EQUB &E1               \ trackSectionData       sign = 14, sectionListSize = 1
 EQUB &DB               \ xTrackSectionIHi       xTrackSectionI = &DB15 =  -9451
 EQUB &16               \ yTrackSectionIHi       yTrackSectionI = &16E6 =   5862
 EQUB &ED               \ zTrackSectionIHi       zTrackSectionI = &EDCA =  -4662
 EQUB &DA               \ xTrackSectionOHi       xTrackSectionO = &DA64 =  -9628
 EQUB 255               \ trackSectionTurn
 EQUB &ED               \ zTrackSectionOHi       zTrackSectionO = &ED11 =  -4847
 EQUB 125               \ trackDriverSpeed

                        \ Track section 28

 EQUB &F2               \ trackSectionData       sign = 15, sectionListSize = 2
 EQUB &D3               \ xTrackSectionIHi       xTrackSectionI = &D398 = -11368
 EQUB &17               \ yTrackSectionIHi       yTrackSectionI = &179A =   6042
 EQUB &F7               \ zTrackSectionIHi       zTrackSectionI = &F7D9 =  -2087
 EQUB &D2               \ xTrackSectionOHi       xTrackSectionO = &D2A5 = -11611
 EQUB 255               \ trackSectionTurn
 EQUB &F7               \ zTrackSectionOHi       zTrackSectionO = &F78C =  -2164
 EQUB 255               \ trackDriverSpeed

 EQUB &00, &00          \ These bytes appear to be unused
 EQUB &00, &00
 EQUB &00, &34
 EQUB &00, &7F

\ ******************************************************************************
\
\       Name: Hook80Percent
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Calculate (A T) = 0.8 * A
\
\ ******************************************************************************

.Hook80Percent

 STA U                  \ Set U = A

 LDA #205               \ Set A = 205

 JMP Multiply8x8        \ Set (A T) = A * U
                        \           = 205 * A
                        \
                        \ returning from the subroutine using a tail call
                        \
                        \ This calculates the following in A:
                        \
                        \   A = (A T) / 256
                        \     = 205 * A / 256
                        \     = 0.80 * A

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: dataIndex
\       Type: Variable
\   Category: Extra track data
\    Summary: The data index for the current section
\
\ ******************************************************************************

.dataIndex

 EQUB 0

\ ******************************************************************************
\
\       Name: L53F9
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.L53F9

 EQUB 58

\ ******************************************************************************
\
\       Name: thisSectionData1Lo
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.thisSectionData1Lo

 EQUB 0

\ ******************************************************************************
\
\       Name: thisSectionData1Hi
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.thisSectionData1Hi

 EQUB 0

\ ******************************************************************************
\
\       Name: yThisSectionData
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.yThisSectionData

 EQUB 0

\ ******************************************************************************
\
\       Name: dataCounter
\       Type: Variable
\   Category: Extra track data
\    Summary: The number of the data within the current data block, counting
\             the start of the block
\
\ ******************************************************************************

.dataCounter

 EQUB 0

\ ******************************************************************************
\
\       Name: L53FE
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.L53FE

 EQUB 0

\ ******************************************************************************
\
\       Name: L53FF
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.L53FF

 EQUB 0

\ ******************************************************************************
\
\       Name: modifyAddressLo
\       Type: Variable
\   Category: Extra track data
\    Summary: Low byte of the location in the main game code where we modify a
\             two-byte address
\
\ ------------------------------------------------------------------------------
\
\ This is where the xTrackSegmentI table is built.
\
\ ******************************************************************************

.modifyAddressLo

 EQUB &49               \ !&1249 = HookSectionFrom
 EQUB &8A               \ !&128A = HookFirstSegment
 EQUB &CA               \ !&13CA = HookSectionFlag6a
 EQUB &27               \ !&1427 = HookSectionFlag6a
 EQUB &FC               \ !&12FC = HookSectionFlag6b
 EQUB &1B               \ !&261B = HookUpdateHorizon
 EQUB &8C               \ !&248C = HookFieldOfView
 EQUB &39               \ !&2539 = HookCollapseTrack
 EQUB &94               \ !&1594 = HookSection4Steer
 EQUB &D1               \ !&4CD1 = xTrackSignVector
 EQUB &C9               \ !&4CC9 = yTrackSignVector
 EQUB &C1               \ !&4CC1 = zTrackSignVector
 EQUB &D6               \ !&44D6 = trackRacingLine
 EQUB &D7               \ !&4CD7 = trackSignData
 EQUB &E1               \ !&4CE1 = trackSignData
 EQUB &47               \ !&1947 = HookFlattenHills
 EQUB &F3               \ !&24F3 = HookMoveBack
 EQUB &2C               \ !&462C = HookFlipAbsolute
 EQUB &43               \ !&2543 = Hook80Percent

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: modifyAddressHi
\       Type: Variable
\   Category: Extra track data
\    Summary: High byte of the location in the main game code where we modify a
\             two-byte address
\
\ ******************************************************************************

.modifyAddressHi

 EQUB &12               \ !&1249 = HookSectionFrom
 EQUB &12               \ !&128A = HookFirstSegment
 EQUB &13               \ !&13CA = HookSectionFlag6a
 EQUB &14               \ !&1427 = HookSectionFlag6a
 EQUB &12               \ !&12FC = HookSectionFlag6b
 EQUB &26               \ !&261B = HookUpdateHorizon
 EQUB &24               \ !&248C = HookFieldOfView
 EQUB &25               \ !&2539 = HookCollapseTrack
 EQUB &15               \ !&1594 = HookSection4Steer
 EQUB &4C               \ !&4CD1 = xTrackSignVector
 EQUB &4C               \ !&4CC9 = yTrackSignVector
 EQUB &4C               \ !&4CC1 = zTrackSignVector
 EQUB &44               \ !&44D6 = trackRacingLine
 EQUB &4C               \ !&4CD7 = trackSignData
 EQUB &4C               \ !&4CE1 = trackSignData
 EQUB &19               \ !&1947 = HookFlattenHills
 EQUB &24               \ !&24F3 = HookMoveBack
 EQUB &46               \ !&462C = HookFlipAbsolute
 EQUB &25               \ !&2543 = Hook80Percent

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: data1Hi
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.data1Hi

 EQUB &00, &00, &00, &01, &05, &01, &00, &02
 EQUB &00, &00, &00, &06, &00, &FC, &FD, &FC
 EQUB &FE, &FF, &FF, &FF, &FD, &FE, &FD, &FB
 EQUB &00, &00, &00, &01, &00, &00, &00, &00
 EQUB &00, &01, &01, &01, &04, &01, &03, &01
 EQUB &00, &00, &02, &03, &05, &FC, &FB, &00
 EQUB &00, &00, &00, &05, &02, &02, &00, &01
 EQUB &00, &00

\ ******************************************************************************
\
\       Name: trackSignData
\       Type: Variable
\   Category: Track data
\    Summary: Base coordinates and object types for 16 road signs
\  Deep dive: The track data file format
\
\ ******************************************************************************

.trackSignData

 EQUB %00001100         \ Sign  0: 00001 100   Type 11   Right turn   Section  1
 EQUB %00010000         \ Sign  1: 00010 000   Type 7    Straight     Section  2
 EQUB %00100011         \ Sign  2: 00100 011   Type 10   Hairpin      Section  4
 EQUB %00100000         \ Sign  3: 00100 000   Type 7    Straight     Section  4
 EQUB %00111000         \ Sign  4: 00111 000   Type 7    Straight     Section  7
 EQUB %01001101         \ Sign  5: 01001 101   Type 12   Left turn    Section  9
 EQUB %01011000         \ Sign  6: 01011 000   Type 7    Straight     Section 11
 EQUB %01100000         \ Sign  7: 01100 000   Type 7    Straight     Section 12
 EQUB %01101100         \ Sign  8: 01101 100   Type 11   Right turn   Section 13
 EQUB %10001100         \ Sign  9: 10001 100   Type 11   Right turn   Section 17
 EQUB %10100100         \ Sign 10: 10100 100   Type 11   Right turn   Section 20
 EQUB %10110101         \ Sign 11: 10110 101   Type 12   Left turn    Section 22
 EQUB %11000000         \ Sign 12: 11000 000   Type 7    Straight     Section 24
 EQUB %11010100         \ Sign 13: 11010 100   Type 11   Right turn   Section 26
 EQUB %11100000         \ Sign 14: 11100 000   Type 7    Straight     Section 28
 EQUB %00000001         \ Sign 15: 00000 001   Type 8    Start flag   Section  0

\ ******************************************************************************
\
\       Name: SetSegmentVector
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Calculate the segment vector for the current segment
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.SetSegmentVector

 LDA thisSectionData1Lo \ Set A = (thisSectionData1Hi thisSectionData1Lo) << 1
 ASL A                  \ keeping the high byte only and rotating bit 7 into
 LDA thisSectionData1Hi \ the C flag
 ROL A

 PHA                    \ Push the high byte in A onto the stack

 ROL A                  \ Set bits 0-2 of U to bits 5-7 of thisSectionData1Hi
 ROL A                  \ (i.e. the top three bits)
 ROL A
 AND #%00000111
 STA U

 LSR A                  \ Set the C flag to bit 0 of A, i.e. bit 5 of
                        \ thisSectionData1Hi

 PLA                    \ Retrieve the high byte that we pushed onto the stack,
                        \ i.e. the high byte of thisSectionData1 << 1

 AND #%00111111         \ Clear bits 6 and 7 of A, so A now contains two zeroes,
                        \ then bits 4, 3, 2, 1 of thisSectionData1Hi, then bits
                        \ 7 and 6 of thisSectionData1Lo

 BCC L548C              \ If the C flag, i.e. bit 5 of thisSectionData1Hi, is
                        \ clear, jump to L548C to skip the following

.L5488

 EOR #%00111111         \ Negate A using two's complement (the ADC adds 1 as the
 ADC #0                 \ C flag is set)

.L548C

 TAX                    \ Set X = A

 LDY segmentCoord1,X    \ Set Y = X-th entry in segmentCoord1

 LDA segmentCoord2,X    \ Set X = X-th entry in segmentCoord2
 TAX

 LDA U                  \ If bit 1 of U + 1 is set, i.e. U ends in %01 or %10,
 CLC                    \ i.e. bits 5 and 6 of thisSectionData1Hi are different,
 ADC #1                 \ then jump to L54A3 to set V and W the other way round
 AND #%00000010
 BNE L54A3

 STY V                  \ Set V = Y

 STX W                  \ Set W = X

 BEQ L54A7              \ Jump to L54A7 (this BEQ is effectively a JMP as we
                        \ passed through a BNE above)

.L54A3

 STX V                  \ Set V = X

 STY W                  \ Set W = Y

.L54A7

 LDA U                  \ If U < 4, i.e. bit 3 of U is clear, i.e. bit 7 of
 CMP #4                 \ thisSectionData1Hi is clear, jump to L54B3 to skip the
 BCC L54B3              \ following

                        \ If we get here then bit 3 of U is set, i.e. bit 7 of
                        \ thisSectionData1Hi is set

 LDA #0                 \ Set V = -V
 SBC V
 STA V

.L54B3

 LDA U                  \ If U >= 6, i.e. bits 1 and 2 of U are set, i.e. bits
 CMP #6                 \ 6 and 7 of thisSectionData1Hi are set, jump to L54C3
 BCS L54C3              \ to skip the following

 CMP #2                 \ If U < 2, i.e. bits 1 and 2 of U are clear, i.e. bits
 BCC L54C3              \ 6 and 7 of thisSectionData1Hi are clear, jump to L54C3
                        \ to skip the following

                        \ If we get here then bits 1 and 2 of U are different,
                        \ i.e. bits 6 and 7 of thisSectionData1Hi are different

 LDA #0                 \ Set W = -W
 SBC W
 STA W

.L54C3

 LDY thisVectorNumber   \ Set Y to thisVectorNumber, which contains the value of
                        \ trackSectionFrom for this track section (i.e. the
                        \ number of the first segment vector in the section)

                        \ We now store the following for this vector, where V
                        \ and W are based on segmentCoord1 and segmentCoord2:
                        \
                        \   * xTrackSegmentI = V
                        \   * zTrackSegmentI = W
                        \
                        \   * zTrackSegmentO = V * 0.53
                        \   * xTrackSegmentO = -W * 0.53
                        \
                        \   * yTrackSegmentI = yThisSectionData

 LDA #136               \ Set U = 136
 STA U

 LDA V                  \ Set the x-coordinate of the Y-th inner track segment
 STA xTrackSegmentI,Y   \ vector to V

 JSR Multiply8x8Signed  \ Set A = A * U / 256
                        \       = V * 136 / 256
                        \       = V * 0.53

 STA zTrackSegmentO,Y   \ Set the z-coordinate of the Y-th outer track segment
                        \ vector to V * 0.53

 LDA W                  \ Set the z-coordinate of the Y-th inner track segment
 STA zTrackSegmentI,Y   \ vector to W

 JSR Multiply8x8Signed  \ Set A = A * U / 256
                        \       = W * 136 / 256
                        \       = W * 0.53

 EOR #&FF               \ Negate A using two's complement, so:
 CLC                    \
 ADC #1                 \   A = -W * 0.53

 STA xTrackSegmentO,Y   \ Set the x-coordinate of the Y-th outer track segment
                        \ vector to -W * 0.53

 LDA yThisSectionData   \ Set the y-coordinate of the Y-th track segment vector
 STA yTrackSegmentI,Y   \ to yThisSectionData

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HookFlipAbsolute
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ If we are facing forwards along the track, set A = |A|.
\
\ If we are facing backwards along the track, set A = -|A|.
\
\ ******************************************************************************

.HookFlipAbsolute

 EOR directionFacing    \ Flip the sign bit of A if we are facing backwards
                        \ along the track
                        \
                        \ The Absolute8Bit routine does the following:
                        \
                        \   * If A is positive leave it alone
                        \
                        \   * If A is negative, set A = -A
                        \
                        \ So if bit 7 of directionFacing is set (i.e. we are
                        \ facing backwards along the track), this flips bit 7 of
                        \ A, which changes the Absolute8Bit routine to the
                        \ following (if we consider the original value of A):
                        \
                        \   * If A is negative leave it alone
                        \
                        \   * If A is positive, set A = -A
                        \
                        \ So this sets set A = -|A| instead  of A = |A|

 JSR Absolute8Bit       \ Set A = |A|, unless we are facing backwards along the
                        \ track, in which case set A = -|A|

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HookSectionFlag6b
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Implement bit 6 of the track section flags
\
\ ------------------------------------------------------------------------------
\
\ If bit 6 of the current section's flags is set, call UpdateDataPointers (this
\ bit is unused in the original track data file).
\
\ ******************************************************************************

.HookSectionFlag6b

 LDA thisSectionFlags   \ If bit 6 of the current section's flags is clear, jump
 AND #%01000000         \ to flab1 to skip the following call, so we just
 BEQ flab1              \ implement the same code as in the original

 JSR UpdateDataPointers \ Bit 6 of the current section's flags is set, so call
                        \ UpdateDataPointers before continuing with the same
                        \ code as in the original

.flab1

 LDA frontSegmentIndex  \ Set A to the index * 3 of the front track segment in
                        \ the track segment buffer

 CLC                    \ Set A = frontSegmentIndex + 3
 ADC #3                 \
                        \ to move on to the next track segment ahead of the
                        \ current front segment in the track segment buffer,
                        \ which will become the new front segment

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: newContentLo
\       Type: Variable
\   Category: Extra track data
\    Summary: Low byte of the two-byte address that we want to poke into the
\             main game code at the modify location
\
\ ------------------------------------------------------------------------------
\
\ This is where the zTrackSegmentI table is built.
\
\ ******************************************************************************

.newContentLo

 EQUB LO(HookSectionFrom)
 EQUB LO(HookFirstSegment)
 EQUB LO(HookSectionFlag6a)
 EQUB LO(HookSectionFlag6a)
 EQUB LO(HookSectionFlag6b)
 EQUB LO(HookUpdateHorizon)
 EQUB LO(HookFieldOfView)
 EQUB LO(HookCollapseTrack)
 EQUB LO(HookSection4Steer)
 EQUB LO(xTrackSignVector)
 EQUB LO(yTrackSignVector)
 EQUB LO(zTrackSignVector)
 EQUB LO(trackRacingLine)
 EQUB LO(trackSignData)
 EQUB LO(trackSignData)
 EQUB LO(HookFlattenHills)
 EQUB LO(HookMoveBack)
 EQUB LO(HookFlipAbsolute)
 EQUB LO(Hook80Percent)

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: newContentHi
\       Type: Variable
\   Category: Extra track data
\    Summary: High byte of the two-byte address that we want to poke into the
\             main game code at the modify location
\
\ ******************************************************************************

.newContentHi

 EQUB HI(HookSectionFrom)
 EQUB HI(HookFirstSegment)
 EQUB HI(HookSectionFlag6a)
 EQUB HI(HookSectionFlag6a)
 EQUB HI(HookSectionFlag6b)
 EQUB HI(HookUpdateHorizon)
 EQUB HI(HookFieldOfView)
 EQUB HI(HookCollapseTrack)
 EQUB HI(HookSection4Steer)
 EQUB HI(xTrackSignVector)
 EQUB HI(yTrackSignVector)
 EQUB HI(zTrackSignVector)
 EQUB HI(trackRacingLine)
 EQUB HI(trackSignData)
 EQUB HI(trackSignData)
 EQUB HI(HookFlattenHills)
 EQUB HI(HookMoveBack)
 EQUB HI(HookFlipAbsolute)
 EQUB HI(Hook80Percent)

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: data1Lo
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.data1Lo

 EQUB &23, &48, &CB, &AC, &5C, &9D, &00, &AB
 EQUB &00, &00, &00, &3D, &00, &0A, &DE, &17
 EQUB &F8, &4A, &E1, &16, &46, &52, &5C, &BC
 EQUB &00, &00, &00, &6C, &00, &00, &00, &00
 EQUB &00, &32, &9A, &FB, &17, &A3, &11, &5A
 EQUB &00, &00, &72, &7C, &7A, &BB, &F8, &00
 EQUB &00, &00, &00, &55, &11, &11, &60, &B0
 EQUB &78, &20

\ ******************************************************************************
\
\       Name: xTrackSignVector
\       Type: Variable
\   Category: Extra track data
\    Summary: The x-coordinate of the track sign vector for each sign, to be
\             scaled and added to the inner track section vector for the sign
\
\ ******************************************************************************

.xTrackSignVector

 EQUB -16               \ Sign  0 = (-16 << 6,  26 << 4, -46 << 6) + section  0
 EQUB -42               \ Sign  1 = (-42 << 6,  76 << 4,   4 << 6) + section  2
 EQUB -40               \ Sign  2 = (-40 << 6, -39 << 4,  28 << 6) + section  3
 EQUB  12               \ Sign  3 = ( 12 << 6, -26 << 4, -20 << 6) + section  5
 EQUB   9               \ Sign  4 = (  9 << 6,  13 << 4,  10 << 6) + section  7
 EQUB  -2               \ Sign  5 = ( -2 << 6,   8 << 4, -21 << 6) + section  9
 EQUB -10               \ Sign  6 = (-10 << 6, -20 << 4,  -9 << 6) + section 12
 EQUB  50               \ Sign  7 = ( 50 << 6,   6 << 4,  45 << 6) + section 14
 EQUB  28               \ Sign  8 = ( 28 << 6, -32 << 4,  27 << 6) + section 14
 EQUB -33               \ Sign  9 = (-33 << 6,  16 << 4,  43 << 6) + section 14
 EQUB -12               \ Sign 10 = (-12 << 6,  18 << 4,  -8 << 6) + section 18
 EQUB -14               \ Sign 11 = (-14 << 6,   5 << 4,  16 << 6) + section 19
 EQUB  -8               \ Sign 12 = ( -8 << 6,  30 << 4, -14 << 6) + section 20
 EQUB  51               \ Sign 13 = ( 51 << 6,   1 << 4,  41 << 6) + section 21
 EQUB  13               \ Sign 14 = ( 13 << 6,  -6 << 4, -20 << 6) + section 22
 EQUB  -4               \ Sign 15 = ( -4 << 6,   8 << 4,   0 << 6) + section 23

\ ******************************************************************************
\
\       Name: HookSectionFlag6a
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ If bit 6 of the current section's flags is set, call sub_C55C4 after moving to
\ the nest vector along (this bit is unused in the original track data file).
\
\ ******************************************************************************

.HookSectionFlag6a

 LDA thisSectionFlags   \ If bit 6 of the current section's flags is clear, jump
 AND #%01000000         \ to flag1 to return from the subroutine
 BEQ flag1

 JSR UpdateVectorNumber \ Update thisVectorNumber to the next vector along the
                        \ track in the direction we are facing (we replaced a
                        \ call to UpdateCurveVector with the call to the hook,
                        \ so this implements that call, knowing that this is a
                        \ curve)

 JSR sub_C55C4          \ Bit 6 of the current section's flags is set, so call
                        \ sub_C55C4 before returning from the subroutine

.flag1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: sub_C557F
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sub_C557F

 JSR UpdateVectorNumber \ Update thisVectorNumber to the next vector along the
                        \ track in the direction we are facing 

\ ******************************************************************************
\
\       Name: UpdateDataPointers
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Increment or decrement the data index and counter to point to the
\             next bit of data along the track
\
\ ******************************************************************************

.UpdateDataPointers

 LDY dataIndex          \ Set Y to the data index for this data block

 LDA dataCounter        \ Set A to the number of the data index within the block

 SEC                    \ Set the C flag for use in the following addition or
                        \ subtraction

 BIT directionFacing    \ If we are facing backwards along the track, jump to
 BMI L55A0              \ L55A0

                        \ If we get here then we are facing forwards along the
                        \ track, so we increment dataCounter
                        \
                        \ If dataCounter reaches dataSize for this data block,
                        \ we wrap it round to zero and increment dataIndex
                        \
                        \ If dataIndex reaches L53F9, we wrap it round to zero

 ADC #0                 \ Set A = A + 1
                        \       = dataCounter + 1
                        \
                        \ This works as the C flag is set

 CMP dataSize,Y         \ If A < dataSize for this index, jump to L55B6 to
 BCC L55B6              \ update the pointers and return from the subroutine

 LDA #0                 \ Set A = 0 to store as the new value of dataCounter

 INY                    \ Increment Y to point to the next data index

 CPY L53F9              \ If Y < L53F9, jump to L55B6 to update the pointers and
 BCC L55B6              \ return from the subroutine

 LDY #0                 \ Set Y = 0, to set as the new value of dataIndex

 BEQ L55B6              \ Jump to L55B6 to update the pointers and return from
                        \ the subroutine (this BEQ is effectively a JMP as Y is
                        \ always zero)

.L55A0

                        \ If we get here then we are facing backwards along the
                        \ track, so we decrement dataCounter
                        \
                        \ If dataCounter reaches 0, we wrap it round to ???
                        \ and decrement dataIndex
                        \
                        \ If ???

 SBC #1                 \ Set A = A - 1
                        \       = dataCounter - 1
                        \
                        \ This works as the C flag is set

 BCS L55B6              \ If the subtraction didn't underflow, jump to L55B6 to
                        \ update the pointers and return from the subroutine

 TYA                    \ Clear bit 7 of Y
 AND #%01111111
 TAY

 CPY #1                 \ If Y >= 1, jump to L55AF as we haven't reached the
 BCS L55AF              \ start of the data

 LDY L53F9              \ Set Y = L53F9 to point to the start of the data

.L55AF

 DEY                    \ Decrement Y to point to the previous data index

 LDA dataSize,Y         \ Set A to dataSize - 1 for this index
 SEC
 SBC #1

.L55B6

 STA dataCounter        \ Store the updated value of A in the data counter

 STY dataIndex          \ Store the updated value of Y in the data index

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HookMoveBack
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Only move the player backwards if the player has not yet driven
\             past the segment
\
\ ------------------------------------------------------------------------------
\
\ Only move the player backwards by one segment if bit 7 of playerPastSegment is
\ clear (in other words, if the player has not yet driven past the segment).
\
\ ******************************************************************************

.HookMoveBack

 BIT playerPastSegment  \ If bit 7 of playerPastSegment is set, return from the
 BMI HookMoveBack-1     \ subroutine (as HookMoveBack-1 contains an RTS)

 JMP MovePlayerBack     \ Move the player backwards by one segment, returning
                        \ from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: sub_C55C4
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sub_C55C4

 STX xStore             \ Store X in xStore so we can retrieve it at the end of
                        \ the routine

 LDY dataIndex          \ Set Y to the data index for this data block

 BMI L55FA              \ If bit 7 of Y is set, jump to L55FA to skip the
                        \ following calculation

 LDA data1Lo,Y          \ Set (A T) = (data1Hi data1Lo) for this section
 STA T
 LDA data1Hi,Y

 BIT directionFacing    \ Set the N flag to the sign of directionFacing, so the
                        \ call to Absolute16Bit sets the sign of (A T) to
                        \ abs(directionFacing)

 JSR Absolute16Bit      \ Set the sign of (A T) to match the sign bit in
                        \ directionFacing, so this negates (A T) if we are
                        \ facing backwards along the track

 STA U                  \ Set (U T) = (A T)
                        \           = signed (data1Hi data1Lo) for this section

 LDA T                  \ Set thisSectionData1 = thisSectionData1 + (U T)
 CLC                    \                      = thisSectionData1 + data1
 ADC thisSectionData1Lo \
 STA thisSectionData1Lo \ starting with the low bytes

 LDA U                  \ And then the high bytes
 ADC thisSectionData1Hi
 STA thisSectionData1Hi

 LDA yData,Y            \ Set A = yData for this section

 BIT directionFacing    \ Set the N flag to the sign of directionFacing, so the
                        \ call to Absolute8Bit sets the sign of A to
                        \ abs(directionFacing)

 JSR Absolute8Bit       \ Set the sign of A to match the sign bit in
                        \ directionFacing, so this negates A if we are facing
                        \ backwards along the track

 CLC                    \ Set yThisSectionData = yThisSectionData + A
 ADC yThisSectionData   \                      = yThisSectionData + yData
 STA yThisSectionData

.L55FA

 JSR SetSegmentVector   \ Calculate the segment vector for the current segment
                        \ and put it in the xSegmentVectorI, ySegmentVectorI,
                        \ zSegmentVectorI, xSegmentVectorO and zSegmentVectorO
                        \ tables

 LDX xStore             \ Retrieve the value of X we stores above, so we can
                        \ return it unchanged by the routine

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ModifyGameCode (Part 3 of 3)
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Modify the game code to support the extra track data
\
\ ------------------------------------------------------------------------------
\
\ The code modifications are done in three parts.
\
\ This part performs five single-byte modifications.
\
\ This is where the zTrackSegmentI table is built.
\
\ ******************************************************************************

.mods3

 LDA #4                 \ ?&3574 = 4
 STA &3574

 LDA #11                \ ?&35F4 = 11
 STA &35F4

 LDA #&E9               \ ?&45CC = &E9
 STA &45CC

 LDA #&59               \ ?&45CD = &59
 STA &45CD

 LDA #&4B               \ ?&2772 = &4B
 STA &2772

 RTS                    \ Return from the subroutine

 EQUB &00, &00          \ These bytes appear to be unused
 EQUB &00, &00
 EQUB &00, &00
 EQUB &00, &00
 EQUB &00, &00
 EQUB &00, &00
 EQUB &00, &00

\ ******************************************************************************
\
\       Name: yData
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.yData

 EQUB &01, &FE, &FF, &FE, &FF, &00, &04, &09
 EQUB &00, &F9, &F9, &00, &00, &00, &04, &00
 EQUB &00, &00, &00, &00, &03, &02, &02, &01
 EQUB &00, &FA, &00, &00, &00, &FD, &03, &04
 EQUB &01, &FF, &FE, &FE, &01, &00, &00, &00
 EQUB &FC, &02, &03, &FD, &FD, &01, &03, &00
 EQUB &FE, &00, &01, &FC, &FC, &03, &03, &FC
 EQUB &FE, &01

\ ******************************************************************************
\
\       Name: yTrackSignVector
\       Type: Subroutine
\   Category: Extra track data
\    Summary: The y-coordinate of the track sign vector for each sign, to be
\             scaled and added to the inner track section vector for the sign
\
\ ******************************************************************************

.yTrackSignVector

 EQUB  26               \ Sign  0 = (-16 << 6,  26 << 4, -46 << 6) + section  0
 EQUB  76               \ Sign  1 = (-42 << 6,  76 << 4,   4 << 6) + section  2
 EQUB -39               \ Sign  2 = (-40 << 6, -39 << 4,  28 << 6) + section  3
 EQUB -26               \ Sign  3 = ( 12 << 6, -26 << 4, -20 << 6) + section  5
 EQUB  13               \ Sign  4 = (  9 << 6,  13 << 4,  10 << 6) + section  7
 EQUB   8               \ Sign  5 = ( -2 << 6,   8 << 4, -21 << 6) + section  9
 EQUB -20               \ Sign  6 = (-10 << 6, -20 << 4,  -9 << 6) + section 12
 EQUB   6               \ Sign  7 = ( 50 << 6,   6 << 4,  45 << 6) + section 14
 EQUB -32               \ Sign  8 = ( 28 << 6, -32 << 4,  27 << 6) + section 14
 EQUB  16               \ Sign  9 = (-33 << 6,  16 << 4,  43 << 6) + section 14
 EQUB  18               \ Sign 10 = (-12 << 6,  18 << 4,  -8 << 6) + section 18
 EQUB   5               \ Sign 11 = (-14 << 6,   5 << 4,  16 << 6) + section 19
 EQUB  30               \ Sign 12 = ( -8 << 6,  30 << 4, -14 << 6) + section 20
 EQUB   1               \ Sign 13 = ( 51 << 6,   1 << 4,  41 << 6) + section 21
 EQUB  -6               \ Sign 14 = ( 13 << 6,  -6 << 4, -20 << 6) + section 22
 EQUB   8               \ Sign 15 = ( -4 << 6,   8 << 4,   0 << 6) + section 23

\ ******************************************************************************
\
\       Name: HookSectionFrom
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ Do some extra processing when reading trackSectionFrom.
\
\ Arguments:
\
\   Y                   The number of the track section * 8 whose coordinates we
\                       want to fetch
\
\ ******************************************************************************

.HookSectionFrom

 STY yStore             \ Store the section number in yStore, so we can retrieve
                        \ it at the end of the hook routine

 LDA trackSectionFrom,Y \ Set thisVectorNumber = the Y-th trackSectionFrom, just
 STA thisVectorNumber   \ like the code that we overwrote with the call to the
                        \ hook routine

 TYA                    \ Set Y = Y / 8
 LSR A                  \
 LSR A                  \ So Y now contains the number of the track section (as
 LSR A                  \ trackSectionFrom contains the track section * 8)
 TAY

 LDA sectionData1Lo,Y   \ Set (thisSectionData1Hi thisSectionData1Lo) to this
 STA thisSectionData1Lo \ section's entry from (sectionData1Hi sectionData1Lo)
 LDA sectionData1Hi,Y
 STA thisSectionData1Hi

 LDA ySectionData,Y     \ Set ySectionData to this section's entry from
 STA yThisSectionData   \ yThisSectionData

 LDA sectionIndex,Y     \ Set A to this section's entry from sectionIndex

 LSR A                  \ Set A = A >> 2, with bit 6 cleared, bit 7 set to the
 ROR A                  \ bit 0 of the sectionIndex entry, and the C flag set to
                        \ bit 1 of the sectionIndex entry

 STA dataIndex          \ Store A in dataIndex, so it contains the index
                        \ from bits 2-7 of sectionIndex, and bit 7 is set if
                        \ bit 0 of sectionIndex is set

 LDA #14                \ Set A = 7, with bit 7 set to the C flag (so if this
 ROR A                  \ section's sectionIndex has bit 1 set, then A is 135,
                        \ otherwise it is 7)

 STA &23B3              \ Modify the GetSectionAngles routine, at instruction
                        \ #4 after gsec11, to test prevHorizonIndex against the
                        \ value we just calculated in A rather than 7
                        \ 
                        \ So if this section's sectionIndex has bit 1 set, the
                        \ test becomes prevHorizonIndex <= 135, which is always
                        \ true, so this modification makes us never set the
                        \ horizon line to 7 for sections that have bit 1 of
                        \ sectionIndex set

 LDA #0                 \ Set dataCounter = 0
 STA dataCounter

 BIT directionFacing    \ If we are facing backwards along the track, jump to
 BMI from1              \ from1 to skip the following call to sub_C55C4

 JSR sub_C55C4          \ We are facing forwards along the track, so ???

.from1

 LDY yStore             \ Retrieve the section number from yStore

 LDA thisVectorNumber   \ Set A to the Y-th trackSectionFrom that we set above,
                        \ so the routine sets A to the segment vector number,
                        \ just like the code that we overwrote with the call to
                        \ the hook routine

 RTS                    \ Return from the subrouting

\ ******************************************************************************
\
\       Name: HookUpdateHorizon
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Only update the horizon if we have found fewer than 12 visible
\             segments
\
\ ------------------------------------------------------------------------------
\
\ Only store horizonLine and horizonListIndex if segmentCounter < 12.
\
\ ******************************************************************************

.HookUpdateHorizon

 PHA                    \ Store A on the stack so we can retrueve it below

 LDA segmentCounter     \ Set the C flag if segmentCounter >= 12
 CMP #12

 PLA                    \ Retrieve the value of A from the stack

 BCS upho1              \ If segmentCounter >= 12, jump to upho1 to skip the
                        \ following two instructions

                        \ Otherwise we set the horizon line and index using the
                        \ same code that we overwrote with the call to the hook
                        \ routine

 STA horizonLine        \ This track segment is higher than the current horizon
                        \ pitch angle, so the track obscures the horizon and we
                        \ need to update horizonLine to this new pitch angle

 STY horizonListIndex   \ Set horizonListIndex to the track segment number in Y

.upho1

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HookFieldOfView
\       Type: Subroutine
\   Category: Extra track data
\    Summary: When populating the verge buffer in GetSegmentAngles, don't give
\             up so easily when we get segments outside the field of view
\
\ ------------------------------------------------------------------------------
\
\ Changes logic in gseg12, which is applied when a segment is out of the field
\ of view, so we fetch details of the previous segment (i.e. the one further
\ away).
\
\ In the original code:
\
\   * If previous segment's yaw angle >= 20 then the previous segment was also
\     outside the field of view, so return from the subroutine
\
\   * Otherwise go to gseg4 to try reducing the size of the segment before
\     returning
\
\ In the new code:
\
\   * If previous segment's yaw angle >= 20 and segmentCounter >= 10, then the
\     previous segment was also outside the field of view AND we have already
\     marked at least 10 segments as being visible, so return from the
\     subroutine
\
\   * Otherwise go to gseg13 to mark this segment as visible and keep checking
\     segments
\
\ So we keep checking segments until we have reached at least 10.
\
\ Arguments:
\
\   A                   Yaw angle for the previous segment's right verge
\
\   C flag              Set according to CMP #20
\
\ ******************************************************************************

.HookFieldOfView

 BCC fovw1              \ If A < 20, then this segment is within the 20-degree
                        \ field of view,jump to gseg13 via fovw1

 LDA segmentCounter     \ If segmentCounter < 10, jump to gseg13 via fovw1
 CMP #10
 BCC fovw1

 RTS                    \ Return from the subroutine

.fovw1

 JMP gseg13             \ Jump to gseg13

\******************************************************************************
\
\       Name: HookFlattenHills
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Flatten any hills in the verge buffer, calculate the hill height
\             and track width, cut objects off at the hill height
\
\ ------------------------------------------------------------------------------
\
\ Flatten the height of the verge entries in the verge buffer that are hidden by
\ the nearest hill to the player, so that the ground behind the nearest hill is
\ effectively levelled off, and set horizonTrackWidth to 80% of the track width
\ at the hill crest
\
\ Arguments:
\
\   Y                   Index of the last entry in the track verge buffer - 1:
\
\                         * segmentListRight - 1 for the right verge
\
\                         * segmentListPointer - 1 for the left verge
\
\ ******************************************************************************

.HookFlattenHills

 TYA                    \ Set bit 5 of blockOffset to bit 5 of Y, so blockOffset
 AND #%00100000         \ is non-zero if Y >= 32 (i.e. Y is pointing to the
 STA blockOffset        \ verge buffer for the outer verge edges)

 LDA #0                 \ Set A = 0, so the track line starts at the bottom of
                        \ the screen

                        \ We now work our way backwards through the verge buffer
                        \ from index Y - 1, starting with the closest segments,
                        \ checking the pitch angles and maintaining a maximum
                        \ value in topTrackLine

.hill1

 STA topTrackLine       \ Set topTrackLine = A

.hill2

 DEY                    \ Decrement Y to point to the next entry in the verge
                        \ buffer, so we are moving away from the player

 LDA yVergeRight,Y      \ Set A to the pitch angle of the current entry in the
                        \ verge buffer

 CMP horizonLine        \ If A >= horizonLine, then the verge is on or higher
 BCS hill3              \ than the horizon line, so jump to hill3 to exit the
                        \ hook routine and rejoin the original game code, as
                        \ everything beyond this segment in the verge buffer
                        \ will be hidden

 CMP topTrackLine       \ If A >= topTrackLine, jump back to hill1 to set
 BCS hill1              \ topTrackLine to A and move on to the next segment,
                        \ so topTrackLine maintains the maximum track line as
                        \ we work through the verge buffer

                        \ If we get here then A < horizonLine (so the verge is
                        \ below the horizon) and A < topTrackLine (so the verge
                        \ is lower than the highest segment already processed)
                        \
                        \ In other words, this segment is lower than the ones
                        \ before it, so it is hidden by a hill

 LDA topTrackLine       \ Set the pitch angle of entry Y to topTrackLine (this
 ADC #0                 \ ADC instruction has no effect, as we know the C flag
 STA yVergeRight,Y      \ is clear, so I'm not sure what it's doing here - a
                        \ bit of debug code, perhaps?)

 LDA blockOffset        \ If blockOffset is non-zero, loop back to hill2 to move
 BNE hill2              \ on to the next segment

                        \ If we get here then blockOffset = 0, which will only
                        \ be the case if we are working through the inner verge
                        \ edges (rather than the outer edges), and we haven't
                        \ done the following already
                        \
                        \ In other words, the following is only done once, for
                        \ the closest segment whose pitch angle dips below the
                        \ segment in front of it (i.e. the closest crest of a
                        \ hill)

 LDA topTrackLine       \ Modify the DrawObject routine at dobj3 instruction #6
 STA &1FEA              \ so that objects get cut off at track line number
                        \ topTrackLine instead of horizonLine when they are
                        \ hidden behind a hill

 INY                    \ Increment Y so the call to gtrm2+6 calculates the
                        \ track width for the previous (i.e. closer) segment in
                        \ the verge buffer

 JSR gtrm2+6            \ Call the following routine, which has already been
                        \ modified by this point to calculate the following for
                        \ track segment Y (i.e. the segment in front of the
                        \ current one):
                        \
                        \   horizonTrackWidth
                        \          = 0.8 * |xVergeRightHi - xVergeLeftHi|
                        \
                        \ So this sets horizonTrackWidth to 80% of the track
                        \ width of the crest of the hill

 DEY                    \ Decrement Y back to the correct value for the current
                        \ entry in the verge buffer

 SEC                    \ Rotate a 1 into bit 7 of blockOffset so it is now
 ROR blockOffset        \ non-zero, so we only set horizonTrackWidth once as we
                        \ work through the verge buffer

 BMI hill2              \ Jump back to hill2 (this BMI is effectively a JMP as
                        \ we just set bit 7 of blockOffset)

.hill3

 LDY vergeBufferEnd     \ Set the values of Y and U so they are the same as they
 DEY                    \ would be at this point in the original code, without
 STY U                  \ the above code being run

 JMP CheckVergeOnScreen \ Implement the call that we overwrote with the call to
                        \ the hook routine, so we have effectively inserted the
                        \ above code into the main game (the JMP ensures we
                        \ return from the subroutine using a tail call)

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: ModifyGameCode (Part 1 of 3)
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Modify the game code to support the extra track data
\
\ ------------------------------------------------------------------------------
\
\ The code modifications are done in three parts.
\
\ This part modifies a set of two-byte addresses in the main game code.
\
\ The (modifyAddressHi modifyAddressLo) table contains the locations in the main
\ game code that we want to modify.
\
\ The (newContentHi newContentLo) table contains the new two-byte addresses that
\ we want to poke into the main game code at the modify locations.
\
\ This part also does a couple of single-byte modifications.
\
\ This is where the xTrackSegmentO table is built.
\
\ ******************************************************************************

.ModifyGameCode

 LDX #18                \ We are about to modify 19 two-byte addresses in the
                        \ main game code, so set a counter in X

.mods1

 LDA modifyAddressHi,X  \ Set (U T) = the X-th entry in the (modifyAddressHi
 STA U                  \ modifyAddressLo) table, which contains the location
 LDA modifyAddressLo,X  \ of the code to modify in the main game code
 STA T

 LDY #0                 \ We now modify two bytes, so set an index in Y

 LDA newContentLo,X     \ We want to modify the two-byte address at location
                        \ (U T), setting it to the new address in the
                        \ (newContentHi newContentLo) table, so set A to the
                        \ low byte of the X-th entry from the table, i.e. to
                        \ the low byte of the new address

 STA (T),Y              \ Modify the byte at (U T) to the low byte of the new
                        \ address in A

 INY                    \ Increment Y to point to the next byte

 LDA newContentHi,X     \ Set A to the high byte of the X-th entry from the
                        \ table, i.e. to the high byte of the new address

 STA (T),Y              \ Modify the byte at (U T) + 1 to the high byte of the
                        \ new address in A

 DEX                    \ Decrement the loop counter to move on to the next
                        \ address to modify

 BPL mods1              \ Loop back until we have modified all 19 addresses

 LDA #&4C               \ ?&261A = &4C
 STA &261A

 STA &248B              \ ?&248B = &4C

 JMP mods2              \ Jump to part 2

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: dataSize
\       Type: Variable
\   Category: Extra track data
\    Summary: The number of data points within each section data block
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.dataSize

 EQUB 26                \ Data block  0
 EQUB 21                \ Data block  1
 EQUB 11                \ Data block  2
 EQUB 10                \ Data block  3
 EQUB 4                 \ Data block  4
 EQUB 15                \ Data block  5
 EQUB 21                \ Data block  6
 EQUB 2                 \ Data block  7
 EQUB 12                \ Data block  8
 EQUB 12                \ Data block  9
 EQUB 2                 \ Data block 10
 EQUB 20                \ Data block 11
 EQUB 27                \ Data block 12
 EQUB 7                 \ Data block 13
 EQUB 12                \ Data block 14
 EQUB 3                 \ Data block 15
 EQUB 10                \ Data block 16
 EQUB 10                \ Data block 17
 EQUB 29                \ Data block 18
 EQUB 7                 \ Data block 19
 EQUB 3                 \ Data block 20
 EQUB 11                \ Data block 21
 EQUB 14                \ Data block 22
 EQUB 6                 \ Data block 23
 EQUB 21                \ Data block 24
 EQUB 11                \ Data block 25
 EQUB 13                \ Data block 26
 EQUB 6                 \ Data block 27
 EQUB 46                \ Data block 28
 EQUB 16                \ Data block 29
 EQUB 16                \ Data block 30
 EQUB 12                \ Data block 31
 EQUB 12                \ Data block 32
 EQUB 8                 \ Data block 33
 EQUB 12                \ Data block 34
 EQUB 16                \ Data block 35
 EQUB 4                 \ Data block 36
 EQUB 10                \ Data block 37
 EQUB 8                 \ Data block 38
 EQUB 5                 \ Data block 39
 EQUB 12                \ Data block 40
 EQUB 26                \ Data block 41
 EQUB 8                 \ Data block 42
 EQUB 5                 \ Data block 43
 EQUB 5                 \ Data block 44
 EQUB 5                 \ Data block 45
 EQUB 12                \ Data block 46
 EQUB 15                \ Data block 47
 EQUB 21                \ Data block 48
 EQUB 35                \ Data block 49
 EQUB 22                \ Data block 50
 EQUB 3                 \ Data block 51
 EQUB 14                \ Data block 52
 EQUB 8                 \ Data block 53
 EQUB 19                \ Data block 54
 EQUB 8                 \ Data block 55
 EQUB 17                \ Data block 56
 EQUB 34                \ Data block 57

\ ******************************************************************************
\
\       Name: zTrackSignVector
\       Type: Variable
\   Category: Extra track data
\    Summary: The z-coordinate of the track sign vector for each sign, to be
\             scaled and added to the inner track section vector for the sign
\
\ ******************************************************************************

.zTrackSignVector

 EQUB -46               \ Sign  0 = (-16 << 6,  26 << 4, -46 << 6) + section  0
 EQUB   4               \ Sign  1 = (-42 << 6,  76 << 4,   4 << 6) + section  2
 EQUB  28               \ Sign  2 = (-40 << 6, -39 << 4,  28 << 6) + section  3
 EQUB -20               \ Sign  3 = ( 12 << 6, -26 << 4, -20 << 6) + section  5
 EQUB  10               \ Sign  4 = (  9 << 6,  13 << 4,  10 << 6) + section  7
 EQUB -21               \ Sign  5 = ( -2 << 6,   8 << 4, -21 << 6) + section  9
 EQUB  -9               \ Sign  6 = (-10 << 6, -20 << 4,  -9 << 6) + section 12
 EQUB  45               \ Sign  7 = ( 50 << 6,   6 << 4,  45 << 6) + section 14
 EQUB  27               \ Sign  8 = ( 28 << 6, -32 << 4,  27 << 6) + section 14
 EQUB  43               \ Sign  9 = (-33 << 6,  16 << 4,  43 << 6) + section 14
 EQUB  -8               \ Sign 10 = (-12 << 6,  18 << 4,  -8 << 6) + section 18
 EQUB  16               \ Sign 11 = (-14 << 6,   5 << 4,  16 << 6) + section 19
 EQUB -14               \ Sign 12 = ( -8 << 6,  30 << 4, -14 << 6) + section 20
 EQUB  41               \ Sign 13 = ( 51 << 6,   1 << 4,  41 << 6) + section 21
 EQUB -20               \ Sign 14 = ( 13 << 6,  -6 << 4, -20 << 6) + section 22
 EQUB   0               \ Sign 15 = ( -4 << 6,   8 << 4,   0 << 6) + section 23

\ ******************************************************************************
\
\       Name: HookCollapseTrack
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Collapse the track for entries in the verge buffer that are just
\             in front of the horizon section
\
\ ------------------------------------------------------------------------------
\
\ Squeeze the left verge of the track into the right verge, but only for a few
\ entries just in front of the horizon section, i.e. for the track section list
\ and the first three entries in the track segment list.
\
\ Arguments:
\
\   A                   The updated value of horizonLine
\
\   Y                   The horizon section index in the verge buffer from
\                       horizonListIndex
\
\ ******************************************************************************

.HookCollapseTrack

 STA &1FEA              \ Modify the DrawObject routine at dobj3 instruction #6
                        \ so that objects get cut off at the track line number
                        \ in A instead of horizonLine when they are hidden
                        \ behind a hill

 STA yVergeLeft,Y       \ Set the pitch angle for the left side of the horizon
                        \ line in the track verge buffer to the updated value of
                        \ horizonLine (this is the instruction that we overwrote
                        \ with the call to the hook routine, so this makes sure
                        \ we still do this)

                        \ We now work through the verge buffer from index Y up
                        \ to index 8, and do the following for each entry:
                        \
                        \   * If xVergeRight < xVergeLeft, set
                        \     xVergeRight = xVergeLeft
                        \
                        \   * Set yVergeRight = yVergeLeft
                        \
                        \ This appears to squeeze the left verge of the track
                        \ into the right verge, but only for a few entries just
                        \ in front of the horizon section, i.e. for the track
                        \ section list and the first three entries in the track
                        \ segment list

.coll1

 LDA xVergeRightLo,Y    \ Set A = xVergeRight - xVergeLeft for the horizon
 SEC                    \
 SBC xVergeLeftLo,Y     \ starting with the low bytes

 LDA xVergeRightHi,Y    \ And then the high bytes
 SBC xVergeLeftHi,Y

 BPL coll2              \ If the result is positive, jump to coll2 to skip the
                        \ following

                        \ If we get here then the result is negative, so
                        \ xVergeRight < xVergeLeft

 LDA xVergeRightLo,Y    \ Set xVergeRight = xVergeLeft
 STA xVergeLeftLo,Y     
 LDA xVergeRightHi,Y
 STA xVergeLeftHi,Y

.coll2

 LDA yVergeRight,Y      \ Set yVergeRight = yVergeLeft
 STA yVergeLeft,Y

 INY                    \ Increment the verge buffer index

 CPY #9                 \ Loop back until we have processed up to index 8
 BCC coll1

 LDY horizonListIndex   \ Restore the value of Y that we had on entering the
                        \ hook routine

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: HookSection4Steer
\       Type: Subroutine
\   Category: Extra track data
\    Summary: If this is track section 4, increase the effect of the joystick's
\             x-axis steering by a factor of 1.76
\
\ ------------------------------------------------------------------------------
\
\ If this is track section 4, set:
\
\   (A T) = 1.76 * x-axis ^ 2
\
\ otherwise set:
\
\   (A T) = x-axis ^ 2
\
\ The latter is the same as the existing game code, so this hook only affects
\ track section 4.
\
\ Arguments:
\
\   U                   The joystick x-axis high byte
\
\ ******************************************************************************

.HookSection4Steer

 LDY currentPlayer      \ Set A to the track section number * 8 for the current
 LDA objTrackSection,Y  \ player

 LDY #181               \ Set Y = 181

 CMP #32                \ If the track section <> 32 (i.e. section 4), skip the
 BNE secs1              \ following instruction

 LDY #240               \ The player is in track section 4, so set Y = 240

.secs1

 TYA                    \ Set A = Y
                        \
                        \ So A is 181, or 240 if this is track section 4

 JSR Multiply8x8        \ Set (A T) = A * U
                        \           = A * x-axis

 STA U                  \ Set U = A
                        \       = high byte of A * x-axis

 JSR Multiply8x8        \ Set (A T) = A * U
                        \           = A * A
                        \           = (A * x-axis) ^ 2

 ASL T                  \ Set (A T) = (A T) * 2
 ROL A                  \           = 2 * (A * x-axis) ^ 2

                        \ So if A = 240 (for track section 4), we have:
                        \
                        \   (A T) = 2 * (240/256 * x-axis) ^ 2
                        \         = 2 * (0.9375 * x-axis) ^ 2
                        \         = 1.76 * x-axis ^ 2
                        \
                        \ otherwise we have:
                        \
                        \   (A T) = 2 * (181/256 * x-axis) ^ 2
                        \         = 2 * (0.7070 * x-axis) ^ 2
                        \         = 1.00 * x-axis ^ 2

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: Multiply8x8Signed
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Multiply two 8-bit numbers, one of which is signed
\
\ ------------------------------------------------------------------------------
\
\ If LDA V is the last LDA instruction before the call, and A is signed, set:
\
\   A = |A| * U * abs(A)
\     = A * U / 256
\
\ So this multiplies A and U, retaining the sign in A.
\
\ ******************************************************************************

.Multiply8x8Signed

 PHP                    \ Store the N flag on the stack, as set by the LDA just
                        \ before the call, so this equals abs(A)

 JMP MultiplyHeight+11  \ Jump into the MultiplyHeight routine to do this:
                        \
                        \   JSR Absolute8Bit      \ Set A = |A|
                        \
                        \   JSR Multiply8x8       \ Set (A T) = A * U
                        \                         \           = |A| * U
                        \                         \
                        \                         \ So A = |A| * U / 256
                        \
                        \   PLP                   \ Retrieve sign in N, which we
                        \                         \ set to abs(A) above
                        \
                        \   JSR Absolute8Bit      \ Set A = |A| * abs(A)
                        \                         \       = A * U / 256
                        \
                        \   RTS                   \ Return from the subroutine
                        \
                        \ So this sets A = A * U while retaining the sign in A

\ ******************************************************************************
\
\       Name: segmentCoord1
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.segmentCoord1

 EQUB 0                 \ Coordinate  0
 EQUB 1                 \ Coordinate  1
 EQUB 3                 \ Coordinate  2
 EQUB 4                 \ Coordinate  3
 EQUB 6                 \ Coordinate  4
 EQUB 7                 \ Coordinate  5
 EQUB 9                 \ Coordinate  6
 EQUB 10                \ Coordinate  7
 EQUB 12                \ Coordinate  8
 EQUB 13                \ Coordinate  9
 EQUB 15                \ Coordinate 10
 EQUB 16                \ Coordinate 11
 EQUB 18                \ Coordinate 12
 EQUB 19                \ Coordinate 13
 EQUB 21                \ Coordinate 14
 EQUB 22                \ Coordinate 15
 EQUB 23                \ Coordinate 16
 EQUB 25                \ Coordinate 17
 EQUB 26                \ Coordinate 18
 EQUB 28                \ Coordinate 19
 EQUB 29                \ Coordinate 20
 EQUB 31                \ Coordinate 21
 EQUB 32                \ Coordinate 22
 EQUB 33                \ Coordinate 23
 EQUB 35                \ Coordinate 24
 EQUB 36                \ Coordinate 25
 EQUB 38                \ Coordinate 26
 EQUB 39                \ Coordinate 27
 EQUB 40                \ Coordinate 28
 EQUB 42                \ Coordinate 29
 EQUB 43                \ Coordinate 30
 EQUB 45                \ Coordinate 31
 EQUB 46                \ Coordinate 32
 EQUB 47                \ Coordinate 33
 EQUB 49                \ Coordinate 34
 EQUB 50                \ Coordinate 35
 EQUB 51                \ Coordinate 36
 EQUB 53                \ Coordinate 37
 EQUB 54                \ Coordinate 38
 EQUB 55                \ Coordinate 39
 EQUB 57                \ Coordinate 40
 EQUB 58                \ Coordinate 41
 EQUB 59                \ Coordinate 42
 EQUB 60                \ Coordinate 43
 EQUB 62                \ Coordinate 44
 EQUB 63                \ Coordinate 45
 EQUB 64                \ Coordinate 46
 EQUB 65                \ Coordinate 47
 EQUB 67                \ Coordinate 48
 EQUB 68                \ Coordinate 49
 EQUB 69                \ Coordinate 50
 EQUB 70                \ Coordinate 51
 EQUB 71                \ Coordinate 52
 EQUB 73                \ Coordinate 53
 EQUB 74                \ Coordinate 54
 EQUB 75                \ Coordinate 55
 EQUB 76                \ Coordinate 56
 EQUB 77                \ Coordinate 57
 EQUB 78                \ Coordinate 58
 EQUB 79                \ Coordinate 59
 EQUB 81                \ Coordinate 60
 EQUB 82                \ Coordinate 61
 EQUB 83                \ Coordinate 62
 EQUB 84                \ Coordinate 63
 EQUB 85                \ Coordinate 64

\ ******************************************************************************
\
\       Name: ModifyGameCode (Part 2 of 3)
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Modify the game code to support the extra track data
\
\ ------------------------------------------------------------------------------
\
\ The code modifications are done in three parts.
\
\ This part performs nine single-byte modifications.
\
\ This is where the zTrackSegmentO table is built.
\
\ ******************************************************************************

.mods2

 LDA #&20               \ ?&1248 = &20
 STA &1248

 STA &12FB              \ ?&12FB = &20

 STA &2538              \ ?&2538 = &20

 STA &45CB              \ ?&45CB = &20

 LDA #&EA               \ ?&2545 = &EA
 STA &2545

 LDA #22                \ ?&4F55 = 22
 STA &4F55

 STA &4F59              \ ?&4F59 = 22

 LDA #13                \ ?&24EA = 13
 STA &24EA

 LDA #&A2               \ ?&1FE9 = &A2
 STA &1FE9

 JMP mods3              \ Jump to part 3

\ ******************************************************************************
\
\       Name: ySectionData
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.ySectionData

 EQUB &FF, &E4, &CC, &32, &DE, &D0, &D0, &00
 EQUB &00, &00, &00, &41, &FF, &FF, &FF, &3B
 EQUB &FB, &FB, &FF, &03, &1B, &1B, &FD, &FD
 EQUB &26, &FC, &12, &E6, &FF, &00

\ ******************************************************************************
\
\       Name: sectionData1Lo
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sectionData1Lo

 EQUB &00               \ Section  0 = &0000 (0)
 EQUB &2F               \ Section  1 = &122F (4655)
 EQUB &8A               \ Section  2 = &508A (20618)
 EQUB &E0               \ Section  3 = &55E0 (21984)
 EQUB &E0               \ Section  4 = &55E0 (21984)
 EQUB &A4               \ Section  5 = &D2A4 (-11612)
 EQUB &A4               \ Section  6 = &D2A4 (-11612)
 EQUB &52               \ Section  7 = &9D52 (-25262)
 EQUB &52               \ Section  8 = &9D52 (-25262)
 EQUB &47               \ Section  9 = &8747 (-30905)
 EQUB &42               \ Section 10 = &7642 (30274)
 EQUB &0A               \ Section 11 = &1D0A (7434)
 EQUB &0A               \ Section 12 = &1D0A (7434)
 EQUB &92               \ Section 13 = &2592 (9618)
 EQUB &92               \ Section 14 = &2592 (9618)
 EQUB &92               \ Section 15 = &2592 (9618)
 EQUB &0A               \ Section 16 = &620A (25098)
 EQUB &0A               \ Section 17 = &620A (25098)
 EQUB &0E               \ Section 18 = &A20E (-24050)
 EQUB &0E               \ Section 19 = &A20E (-24050)
 EQUB &9E               \ Section 20 = &B59E (-19042)
 EQUB &9E               \ Section 21 = &B59E (-19042)
 EQUB &6C               \ Section 22 = &E26C (-7572)
 EQUB &6C               \ Section 23 = &E26C (-7572)
 EQUB &B3               \ Section 24 = &A1B3 (-24141)
 EQUB &B3               \ Section 25 = &A1B3 (-24141)
 EQUB &B3               \ Section 26 = &A1B3 (-24141)
 EQUB &28               \ Section 27 = &DF28 (-8408)
 EQUB &C8               \ Section 28 = &F3C8 (-3128)

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: sectionData1Hi
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sectionData1Hi

 EQUB &00               \ Section  0 = &0000 (0)
 EQUB &12               \ Section  1 = &122F (4655)
 EQUB &50               \ Section  2 = &508A (20618)
 EQUB &55               \ Section  3 = &55E0 (21984)
 EQUB &55               \ Section  4 = &55E0 (21984)
 EQUB &D2               \ Section  5 = &D2A4 (-11612)
 EQUB &D2               \ Section  6 = &D2A4 (-11612)
 EQUB &9D               \ Section  7 = &9D52 (-25262)
 EQUB &9D               \ Section  8 = &9D52 (-25262)
 EQUB &87               \ Section  9 = &8747 (-30905)
 EQUB &76               \ Section 10 = &7642 (30274)
 EQUB &1D               \ Section 11 = &1D0A (7434)
 EQUB &1D               \ Section 12 = &1D0A (7434)
 EQUB &25               \ Section 13 = &2592 (9618)
 EQUB &25               \ Section 14 = &2592 (9618)
 EQUB &25               \ Section 15 = &2592 (9618)
 EQUB &62               \ Section 16 = &620A (25098)
 EQUB &62               \ Section 17 = &620A (25098)
 EQUB &A2               \ Section 18 = &A20E (-24050)
 EQUB &A2               \ Section 19 = &A20E (-24050)
 EQUB &B5               \ Section 20 = &B59E (-19042)
 EQUB &B5               \ Section 21 = &B59E (-19042)
 EQUB &E2               \ Section 22 = &E26C (-7572)
 EQUB &E2               \ Section 23 = &E26C (-7572)
 EQUB &A1               \ Section 24 = &A1B3 (-24141)
 EQUB &A1               \ Section 25 = &A1B3 (-24141)
 EQUB &A1               \ Section 26 = &A1B3 (-24141)
 EQUB &DF               \ Section 27 = &DF28 (-8408)
 EQUB &F3               \ Section 28 = &F3C8 (-3128)

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: sectionIndex
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ Each section has a sectionIndex value that contains the following data:
\
\   * Bits 2 to 7 = the index number
\
\   * Bit 1 = if this is set, then in the horizon calculations, we always skip
\             the setting of horizonLine to 7
\
\   * Bit 0 = if this is set, then bit 7 of dataIndex is set, which means
\             we skip most of the sub_C55C4 routine
\
\ ******************************************************************************

.sectionIndex

 EQUB %00000010         \ 000000 1 0    0        Skip    Track section  0
 EQUB %00001110         \ 000011 1 0    3        Skip    Track section  1
 EQUB %00011010         \ 000110 1 0    6        Skip    Track section  2
 EQUB %00100010         \ 001000 1 0    8        Skip    Track section  3
 EQUB %00101010         \ 001010 1 0    10       Skip    Track section  4
 EQUB %00110010         \ 001100 1 0    12       Skip    Track section  5
 EQUB %00110110         \ 001101 1 0    13       Skip    Track section  6
 EQUB %00111111         \ 001111 1 1    15+128   Skip    Track section  7
 EQUB %00111110         \ 001111 1 0    15       Skip    Track section  8
 EQUB %01000110         \ 010001 1 0    17       Skip    Track section  9
 EQUB %01010010         \ 010100 1 0    20       Skip    Track section 10
 EQUB %01100010         \ 011000 1 0    24       Skip    Track section 11
 EQUB %01101010         \ 011010 1 0    26       Skip    Track section 12
 EQUB %01110110         \ 011101 1 0    29       Skip    Track section 13
 EQUB %01111110         \ 011111 1 0    31       Skip    Track section 14
 EQUB %10000100         \ 100001 0 0    33               Track section 15
 EQUB %10010001         \ 100100 0 1    36+128           Track section 16
 EQUB %10010010         \ 100100 1 0    36       Skip    Track section 17
 EQUB %10100010         \ 101000 1 0    40       Skip    Track section 18
 EQUB %10101010         \ 101010 1 0    42       Skip    Track section 19
 EQUB %10101111         \ 101011 1 1    43+128   Skip    Track section 20
 EQUB %10101110         \ 101011 1 0    43       Skip    Track section 21
 EQUB %10110101         \ 101101 0 1    45+128           Track section 22
 EQUB %10110100         \ 101101 0 0    45               Track section 23
 EQUB %10111100         \ 101111 0 0    47               Track section 24
 EQUB %11000100         \ 110001 0 0    49               Track section 25
 EQUB %11001110         \ 110011 1 0    51       Skip    Track section 26
 EQUB %11011010         \ 110110 1 0    54       Skip    Track section 27
 EQUB %11100010         \ 111000 1 0    56       Skip    Track section 28

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: trackRacingLine
\       Type: Variable
\   Category: Extra track data
\    Summary: The optimum racing line for non-player drivers on each track
\             section
\  Deep dive: The track data file format
\
\ ******************************************************************************

.trackRacingLine

 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section  0
 EQUB %00110011         \ 001100 1 1    -12                Track section  1
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section  2
 EQUB %00000000         \ 000000 0 0     +0 * baseSpeed    Track section  3
 EQUB %01001111         \ 010011 1 1    -19                Track section  4
 EQUB %00110001         \ 001100 0 1    -12 * baseSpeed    Track section  5
 EQUB %01101000         \ 011010 0 0    +26 * baseSpeed    Track section  6
 EQUB %00011001         \ 000110 0 1     -6 * baseSpeed    Track section  7
 EQUB %00110000         \ 001100 0 0    +12 * baseSpeed    Track section  8
 EQUB %00011001         \ 000110 0 1     -6 * baseSpeed    Track section  9
 EQUB %00101110         \ 001011 1 0    +11                Track section 10
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 11
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 12
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 13
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 14
 EQUB %00110011         \ 001100 1 1    -12                Track section 15
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 16
 EQUB %00111111         \ 001111 1 1    -15                Track section 17
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 18
 EQUB %01010101         \ 010101 0 1    -21 * baseSpeed    Track section 19
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 20
 EQUB %01011011         \ 010110 1 1    -22                Track section 21
 EQUB %00110101         \ 001101 0 1    -13 * baseSpeed    Track section 22
 EQUB %01000010         \ 010000 1 0    +16                Track section 23
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 24
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 25
 EQUB %01001011         \ 010010 1 1    -18                Track section 26
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 27
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 28
 EQUB %00011000         \ 000110 0 0     +6 * baseSpeed    Track section 29

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: segmentCoord2
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.segmentCoord2

 EQUB 120               \ Coordinate  0
 EQUB 120               \ Coordinate  1
 EQUB 120               \ Coordinate  2
 EQUB 120               \ Coordinate  3
 EQUB 120               \ Coordinate  4
 EQUB 120               \ Coordinate  5
 EQUB 120               \ Coordinate  6
 EQUB 120               \ Coordinate  7
 EQUB 119               \ Coordinate  8
 EQUB 119               \ Coordinate  9
 EQUB 119               \ Coordinate 10
 EQUB 119               \ Coordinate 11
 EQUB 119               \ Coordinate 12
 EQUB 118               \ Coordinate 13
 EQUB 118               \ Coordinate 14
 EQUB 118               \ Coordinate 15
 EQUB 118               \ Coordinate 16
 EQUB 117               \ Coordinate 17
 EQUB 117               \ Coordinate 18
 EQUB 117               \ Coordinate 19
 EQUB 116               \ Coordinate 20
 EQUB 116               \ Coordinate 21
 EQUB 116               \ Coordinate 22
 EQUB 115               \ Coordinate 23
 EQUB 115               \ Coordinate 24
 EQUB 114               \ Coordinate 25
 EQUB 114               \ Coordinate 26
 EQUB 113               \ Coordinate 27
 EQUB 113               \ Coordinate 28
 EQUB 112               \ Coordinate 29
 EQUB 112               \ Coordinate 30
 EQUB 111               \ Coordinate 31
 EQUB 111               \ Coordinate 32
 EQUB 110               \ Coordinate 33
 EQUB 110               \ Coordinate 34
 EQUB 109               \ Coordinate 35
 EQUB 108               \ Coordinate 36
 EQUB 108               \ Coordinate 37
 EQUB 107               \ Coordinate 38
 EQUB 107               \ Coordinate 39
 EQUB 106               \ Coordinate 40
 EQUB 105               \ Coordinate 41
 EQUB 104               \ Coordinate 42
 EQUB 104               \ Coordinate 43
 EQUB 103               \ Coordinate 44
 EQUB 102               \ Coordinate 45
 EQUB 101               \ Coordinate 46
 EQUB 101               \ Coordinate 47
 EQUB 100               \ Coordinate 48
 EQUB 99                \ Coordinate 49
 EQUB 98                \ Coordinate 50
 EQUB 97                \ Coordinate 51
 EQUB 96                \ Coordinate 52
 EQUB 96                \ Coordinate 53
 EQUB 95                \ Coordinate 54
 EQUB 94                \ Coordinate 55
 EQUB 93                \ Coordinate 56
 EQUB 92                \ Coordinate 57
 EQUB 91                \ Coordinate 58
 EQUB 90                \ Coordinate 59
 EQUB 89                \ Coordinate 60
 EQUB 88                \ Coordinate 61
 EQUB 87                \ Coordinate 62
 EQUB 86                \ Coordinate 63
 EQUB 85                \ Coordinate 64

\ ******************************************************************************
\
\       Name: Track section data (Part 2 of 2)
\       Type: Variable
\   Category: Extra track data
\    Summary: Data for the track sections
\  Deep dive: The track data file format
\
\ ******************************************************************************

                        \ Track section 0

 EQUB %01110000         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=00 Sh=0
 EQUB &20               \ xTrackSectionILo       xTrackSectionI = &D120 = -12000
 EQUB &00               \ yTrackSectionILo       yTrackSectionI = &1400 =   5120
 EQUB &A0               \ zTrackSectionILo       zTrackSectionI = &0FA0 =   4000
 EQUB &21               \ xTrackSectionOLo       xTrackSectionO = &D021 = -12255
 EQUB 0                 \ trackSectionFrom
 EQUB &A0               \ zTrackSectionOLo       zTrackSectionO = &0FA0 =   4000
 EQUB 58                \ trackSectionSize

                        \ Track section 1

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &DC               \ xTrackSectionILo       xTrackSectionI = &D4DC = -11044
 EQUB &87               \ yTrackSectionILo       yTrackSectionI = &1487 =   5255
 EQUB &5C               \ zTrackSectionILo       zTrackSectionI = &2A5C =  10844
 EQUB &F6               \ xTrackSectionOLo       xTrackSectionO = &D3F6 = -11274
 EQUB 18                \ trackSectionFrom
 EQUB &C8               \ zTrackSectionOLo       zTrackSectionO = &2AC8 =  10952
 EQUB 29                \ trackSectionSize

                        \ Track section 2

 EQUB %01000010         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=01 Sh=0
 EQUB &52               \ xTrackSectionILo       xTrackSectionI = &E052 =  -8110
 EQUB &2B               \ yTrackSectionILo       yTrackSectionI = &0F2B =   3883
 EQUB &E3               \ zTrackSectionILo       zTrackSectionI = &2DE3 =  11747
 EQUB &B5               \ xTrackSectionOLo       xTrackSectionO = &E0B5 =  -8011
 EQUB 7                 \ trackSectionFrom
 EQUB &CC               \ zTrackSectionOLo       zTrackSectionO = &2ECC =  11980
 EQUB 23                \ trackSectionSize

                        \ Track section 3

 EQUB %01110000         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=00 Sh=0
 EQUB &2B               \ xTrackSectionILo       xTrackSectionI = &EA2B =  -5589
 EQUB &DE               \ yTrackSectionILo       yTrackSectionI = &0EDE =   3806
 EQUB &96               \ zTrackSectionILo       zTrackSectionI = &2996 =  10646
 EQUB &AA               \ xTrackSectionOLo       xTrackSectionO = &EAAA =  -5462
 EQUB 30                \ trackSectionFrom
 EQUB &73               \ zTrackSectionOLo       zTrackSectionO = &2A73 =  10867
 EQUB 24                \ trackSectionSize

                        \ Track section 4

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &EB               \ xTrackSectionILo       xTrackSectionI = &F3EB =  -3093
 EQUB &6C               \ yTrackSectionILo       yTrackSectionI = &116C =   4460
 EQUB &F6               \ zTrackSectionILo       zTrackSectionI = &23F6 =   9206
 EQUB &6A               \ xTrackSectionOLo       xTrackSectionO = &F46A =  -2966
 EQUB 14                \ trackSectionFrom
 EQUB &D3               \ zTrackSectionOLo       zTrackSectionO = &24D3 =   9427
 EQUB 22                \ trackSectionSize

                        \ Track section 5

 EQUB %01101010         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=01 Vc=01 Sh=0
 EQUB &71               \ xTrackSectionILo       xTrackSectionI = &F171 =  -3727
 EQUB &53               \ yTrackSectionILo       yTrackSectionI = &0D53 =   3411
 EQUB &53               \ zTrackSectionILo       zTrackSectionI = &1E53 =   7763
 EQUB &00               \ xTrackSectionOLo       xTrackSectionO = &F100 =  -3840
 EQUB 36                \ trackSectionFrom
 EQUB &6D               \ zTrackSectionOLo       zTrackSectionO = &1D6D =   7533
 EQUB 27                \ trackSectionSize

                        \ Track section 6

 EQUB %01110011         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=01 Sh=1
 EQUB &0D               \ xTrackSectionILo       xTrackSectionI = &E60D =  -6643
 EQUB &43               \ yTrackSectionILo       yTrackSectionI = &0843 =   2115
 EQUB &EA               \ zTrackSectionILo       zTrackSectionI = &23EA =   9194
 EQUB &9C               \ xTrackSectionOLo       xTrackSectionO = &E59C =  -6756
 EQUB 23                \ trackSectionFrom
 EQUB &04               \ zTrackSectionOLo       zTrackSectionO = &2304 =   8964
 EQUB 19                \ trackSectionSize

                        \ Track section 7

 EQUB %00000100         \ trackSectionFlag       Sp=0 H=0 Mc=0 Mlr=00 Vc=10 Sh=0
 EQUB &2F               \ xTrackSectionILo       xTrackSectionI = &DE2F =  -8657
 EQUB &EB               \ yTrackSectionILo       yTrackSectionI = &05EB =   1515
 EQUB &20               \ zTrackSectionILo       zTrackSectionI = &2120 =   8480
 EQUB &F0               \ xTrackSectionOLo       xTrackSectionO = &DEF0 =  -8464
 EQUB 2                 \ trackSectionFrom
 EQUB &7A               \ zTrackSectionOLo       zTrackSectionO = &207A =   8314
 EQUB 13                \ trackSectionSize

                        \ Track section 8

 EQUB %01000001         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=00 Sh=1
 EQUB &39               \ xTrackSectionILo       xTrackSectionI = &DA39 =  -9671
 EQUB &EB               \ yTrackSectionILo       yTrackSectionI = &05EB =   1515
 EQUB &81               \ zTrackSectionILo       zTrackSectionI = &1C81 =   7297
 EQUB &FA               \ xTrackSectionOLo       xTrackSectionO = &DAFA =  -9478
 EQUB 3                 \ trackSectionFrom
 EQUB &DB               \ zTrackSectionOLo       zTrackSectionO = &1BDB =   7131
 EQUB 13                \ trackSectionSize

                        \ Track section 9

 EQUB %01101000         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=01 Vc=00 Sh=0
 EQUB &36               \ xTrackSectionILo       xTrackSectionI = &D836 = -10186
 EQUB &EB               \ yTrackSectionILo       yTrackSectionI = &05EB =   1515
 EQUB &CE               \ zTrackSectionILo       zTrackSectionI = &16CE =   5838
 EQUB &30               \ xTrackSectionOLo       xTrackSectionO = &D930 =  -9936
 EQUB 16                \ trackSectionFrom
 EQUB &A1               \ zTrackSectionOLo       zTrackSectionO = &16A1 =   5793
 EQUB 46                \ trackSectionSize

                        \ Track section 10

 EQUB %11110011         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=10 Vc=01 Sh=1
 EQUB &0A               \ xTrackSectionILo       xTrackSectionI = &D90A =  -9974
 EQUB &EB               \ yTrackSectionILo       yTrackSectionI = &05EB =   1515
 EQUB &52               \ zTrackSectionILo       zTrackSectionI = &0152 =    338
 EQUB &00               \ xTrackSectionOLo       xTrackSectionO = &DA00 =  -9728
 EQUB 22                \ trackSectionFrom
 EQUB &8F               \ zTrackSectionOLo       zTrackSectionO = &018F =    399
 EQUB 34                \ trackSectionSize

                        \ Track section 11

 EQUB %11000100         \ trackSectionFlag       Sp=1 H=1 Mc=0 Mlr=00 Vc=10 Sh=0
 EQUB &58               \ xTrackSectionILo       xTrackSectionI = &E558 =  -6824
 EQUB &DF               \ yTrackSectionILo       yTrackSectionI = &0ADF =   2783
 EQUB &7C               \ zTrackSectionILo       zTrackSectionI = &FC7C =   -900
 EQUB &96               \ xTrackSectionOLo       xTrackSectionO = &E496 =  -7018
 EQUB 16                \ trackSectionFrom
 EQUB &21               \ zTrackSectionOLo       zTrackSectionO = &FD21 =   -735
 EQUB 32                \ trackSectionSize

                        \ Track section 12

 EQUB %01000000         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=00 Sh=0
 EQUB &18               \ xTrackSectionILo       xTrackSectionI = &EF18 =  -4328
 EQUB &73               \ yTrackSectionILo       yTrackSectionI = &1173 =   4467
 EQUB &DC               \ zTrackSectionILo       zTrackSectionI = &07DC =   2012
 EQUB &56               \ xTrackSectionOLo       xTrackSectionO = &EE56 =  -4522
 EQUB 8                 \ trackSectionFrom
 EQUB &81               \ zTrackSectionOLo       zTrackSectionO = &0881 =   2177
 EQUB 65                \ trackSectionSize

                        \ Track section 13

 EQUB %01000000         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=00 Sh=0
 EQUB &61               \ xTrackSectionILo       xTrackSectionI = &0661 =   1633
 EQUB &32               \ yTrackSectionILo       yTrackSectionI = &1132 =   4402
 EQUB &7F               \ zTrackSectionILo       zTrackSectionI = &1B7F =   7039
 EQUB &C5               \ xTrackSectionOLo       xTrackSectionO = &05C5 =   1477
 EQUB 34                \ trackSectionFrom
 EQUB &4B               \ zTrackSectionOLo       zTrackSectionO = &1C4B =   7243
 EQUB 32                \ trackSectionSize

                        \ Track section 14

 EQUB %01110000         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=00 Sh=0
 EQUB &61               \ xTrackSectionILo       xTrackSectionI = &1261 =   4705
 EQUB &12               \ yTrackSectionILo       yTrackSectionI = &0E12 =   3602
 EQUB &9F               \ zTrackSectionILo       zTrackSectionI = &249F =   9375
 EQUB &C5               \ xTrackSectionOLo       xTrackSectionO = &11C5 =   4549
 EQUB 27                \ trackSectionFrom
 EQUB &6B               \ zTrackSectionOLo       zTrackSectionO = &256B =   9579
 EQUB 24                \ trackSectionSize

                        \ Track section 15

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &61               \ xTrackSectionILo       xTrackSectionI = &1B61 =   7009
 EQUB &C0               \ yTrackSectionILo       yTrackSectionI = &11C0 =   4544
 EQUB &77               \ zTrackSectionILo       zTrackSectionI = &2B77 =  11127
 EQUB &C5               \ xTrackSectionOLo       xTrackSectionO = &1AC5 =   6853
 EQUB 12                \ trackSectionFrom
 EQUB &43               \ zTrackSectionOLo       zTrackSectionO = &2C43 =  11331
 EQUB 36                \ trackSectionSize

                        \ Track section 16

 EQUB %00110010         \ trackSectionFlag       Sp=0 H=0 Mc=1 Mlr=10 Vc=01 Sh=0
 EQUB &A6               \ xTrackSectionILo       xTrackSectionI = &2AA6 =  10918
 EQUB &DC               \ yTrackSectionILo       yTrackSectionI = &15DC =   5596
 EQUB &F6               \ zTrackSectionILo       zTrackSectionI = &2AF6 =  10998
 EQUB &63               \ xTrackSectionOLo       xTrackSectionO = &2B63 =  11107
 EQUB 9                 \ trackSectionFrom
 EQUB &A2               \ zTrackSectionOLo       zTrackSectionO = &2BA2 =  11170
 EQUB 55                \ trackSectionSize

                        \ Track section 17

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &0D               \ xTrackSectionILo       xTrackSectionI = &3C0D =  15373
 EQUB &C9               \ yTrackSectionILo       yTrackSectionI = &14C9 =   5321
 EQUB &D7               \ zTrackSectionILo       zTrackSectionI = &17D7 =   6103
 EQUB &CA               \ xTrackSectionOLo       xTrackSectionO = &3CCA =  15562
 EQUB 11                \ trackSectionFrom
 EQUB &83               \ zTrackSectionOLo       zTrackSectionO = &1883 =   6275
 EQUB 27                \ trackSectionSize

                        \ Track section 18

 EQUB %01110010         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=01 Sh=0
 EQUB &6B               \ xTrackSectionILo       xTrackSectionI = &3A6B =  14955
 EQUB &A8               \ yTrackSectionILo       yTrackSectionI = &14A8 =   5288
 EQUB &7C               \ zTrackSectionILo       zTrackSectionI = &0C7C =   3196
 EQUB &17               \ xTrackSectionOLo       xTrackSectionO = &3B17 =  15127
 EQUB 39                \ trackSectionFrom
 EQUB &BE               \ zTrackSectionOLo       zTrackSectionO = &0BBE =   3006
 EQUB 38                \ trackSectionSize

                        \ Track section 19

 EQUB %01101101         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &35               \ xTrackSectionILo       xTrackSectionI = &2D35 =  11573
 EQUB &28               \ yTrackSectionILo       yTrackSectionI = &1128 =   4392
 EQUB &76               \ zTrackSectionILo       zTrackSectionI = &0076 =    118
 EQUB &E1               \ xTrackSectionOLo       xTrackSectionO = &2DE1 =  11745
 EQUB 38                \ trackSectionFrom
 EQUB &B8               \ zTrackSectionOLo       zTrackSectionO = &FFB8 = -72
 EQUB 8                 \ trackSectionSize

                        \ Track section 20

 EQUB %00110000         \ trackSectionFlag       Sp=0 H=0 Mc=1 Mlr=10 Vc=00 Sh=0
 EQUB &E7               \ xTrackSectionILo       xTrackSectionI = &29E7 =  10727
 EQUB &AC               \ yTrackSectionILo       yTrackSectionI = &11AC =   4524
 EQUB &C6               \ zTrackSectionILo       zTrackSectionI = &FEC6 =   -314
 EQUB &28               \ xTrackSectionOLo       xTrackSectionO = &2A28 =  10792
 EQUB 7                 \ trackSectionFrom
 EQUB &CF               \ zTrackSectionOLo       zTrackSectionO = &FDCF =   -561
 EQUB 28                \ trackSectionSize

                        \ Track section 21

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &37               \ xTrackSectionILo       xTrackSectionI = &1D37 =   7479
 EQUB &A0               \ yTrackSectionILo       yTrackSectionI = &14A0 =   5280
 EQUB &62               \ zTrackSectionILo       zTrackSectionI = &FB62 =  -1182
 EQUB &78               \ xTrackSectionOLo       xTrackSectionO = &1D78 =   7544
 EQUB 9                 \ trackSectionFrom
 EQUB &6B               \ zTrackSectionOLo       zTrackSectionO = &FA6B =  -1429
 EQUB 10                \ trackSectionSize

                        \ Track section 22

 EQUB %00101010         \ trackSectionFlag       Sp=0 H=0 Mc=1 Mlr=01 Vc=01 Sh=0
 EQUB &F2               \ xTrackSectionILo       xTrackSectionI = &18F2 =   6386
 EQUB &09               \ yTrackSectionILo       yTrackSectionI = &1509 =   5385
 EQUB &9E               \ zTrackSectionILo       zTrackSectionI = &FC9E =   -866
 EQUB &34               \ xTrackSectionOLo       xTrackSectionO = &1834 =   6196
 EQUB 20                \ trackSectionFrom
 EQUB &F1               \ zTrackSectionOLo       zTrackSectionO = &FBF1 =  -1039
 EQUB 38                \ trackSectionSize

                        \ Track section 23

 EQUB %11110011         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=10 Vc=01 Sh=1
 EQUB &EC               \ xTrackSectionILo       xTrackSectionI = &0CEC =   3308
 EQUB &97               \ yTrackSectionILo       yTrackSectionI = &1497 =   5271
 EQUB &D4               \ zTrackSectionILo       zTrackSectionI = &09D4 =   2516
 EQUB &2E               \ xTrackSectionOLo       xTrackSectionO = &0C2E =   3118
 EQUB 22                \ trackSectionFrom
 EQUB &27               \ zTrackSectionOLo       zTrackSectionO = &0927 =   2343
 EQUB 17                \ trackSectionSize

                        \ Track section 24

 EQUB %01000100         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=10 Sh=0
 EQUB &D0               \ xTrackSectionILo       xTrackSectionI = &05D0 =   1488
 EQUB &99               \ yTrackSectionILo       yTrackSectionI = &1599 =   5529
 EQUB &0B               \ zTrackSectionILo       zTrackSectionI = &0A0B =   2571
 EQUB &7E               \ xTrackSectionOLo       xTrackSectionO = &067E =   1662
 EQUB 0                 \ trackSectionFrom
 EQUB &50               \ zTrackSectionOLo       zTrackSectionO = &0950 =   2384
 EQUB 36                \ trackSectionSize

                        \ Track section 25

 EQUB %01110000         \ trackSectionFlag       Sp=0 H=1 Mc=1 Mlr=10 Vc=00 Sh=0
 EQUB &70               \ xTrackSectionILo       xTrackSectionI = &F970 =  -1680
 EQUB &23               \ yTrackSectionILo       yTrackSectionI = &1923 =   6435
 EQUB &83               \ zTrackSectionILo       zTrackSectionI = &FE83 =   -381
 EQUB &1E               \ xTrackSectionOLo       xTrackSectionO = &FA1E =  -1506
 EQUB 37                \ trackSectionFrom
 EQUB &C8               \ zTrackSectionOLo       zTrackSectionO = &FDC8 =   -568
 EQUB 57                \ trackSectionSize

                        \ Track section 26

 EQUB %11101101         \ trackSectionFlag       Sp=1 H=1 Mc=1 Mlr=01 Vc=10 Sh=1
 EQUB &D8               \ xTrackSectionILo       xTrackSectionI = &E5D8 =  -6696
 EQUB &3C               \ yTrackSectionILo       yTrackSectionI = &193C =   6460
 EQUB &41               \ zTrackSectionILo       zTrackSectionI = &EC41 =  -5055
 EQUB &86               \ xTrackSectionOLo       xTrackSectionO = &E686 =  -6522
 EQUB 15                \ trackSectionFrom
 EQUB &86               \ zTrackSectionOLo       zTrackSectionO = &EB86 =  -5242
 EQUB 25                \ trackSectionSize

                        \ Track section 27

 EQUB %11000010         \ trackSectionFlag       Sp=1 H=1 Mc=0 Mlr=00 Vc=01 Sh=0
 EQUB &15               \ xTrackSectionILo       xTrackSectionI = &DB15 =  -9451
 EQUB &E6               \ yTrackSectionILo       yTrackSectionI = &16E6 =   5862
 EQUB &CA               \ zTrackSectionILo       zTrackSectionI = &EDCA =  -4662
 EQUB &64               \ xTrackSectionOLo       xTrackSectionO = &DA64 =  -9628
 EQUB 1                 \ trackSectionFrom
 EQUB &11               \ zTrackSectionOLo       zTrackSectionO = &ED11 =  -4847
 EQUB 27                \ trackSectionSize

                        \ Track section 28

 EQUB %01000000         \ trackSectionFlag       Sp=0 H=1 Mc=0 Mlr=00 Vc=00 Sh=0
 EQUB &98               \ xTrackSectionILo       xTrackSectionI = &D398 = -11368
 EQUB &9A               \ yTrackSectionILo       yTrackSectionI = &179A =   6042
 EQUB &D9               \ zTrackSectionILo       zTrackSectionI = &F7D9 =  -2087
 EQUB &A5               \ xTrackSectionOLo       xTrackSectionO = &D2A5 = -11611
 EQUB 29                \ trackSectionFrom
 EQUB &8C               \ zTrackSectionOLo       zTrackSectionO = &F78C =  -2164
 EQUB 51                \ trackSectionSize

 EQUB &70               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: HookSlopeJump
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Jump the car when driving fast over sloping segments
\
\ ------------------------------------------------------------------------------
\
\ If the car is on the ground, replace the heightAboveTrack * 4 part of the
\ car's y-coordinate calculation with playerSpeedHi * yTrackSegmentI * 4, to
\ give:
\
\   * (yPlayerCoordTop yPlayerCoordHi) =   (ySegmentCoordIHi ySegmentCoordILo)
\                                        + carProgress * yTrackSegmentI
\                                        + playerSpeedHi * yTrackSegmentI * 4
\                                        + 172
\
\ So driving fast over sloping segments can make the car jump.
\
\ Arguments:
\
\   A                   Current value of heightAboveTrack
\
\ ******************************************************************************

.HookSlopeJump

 BNE slop1              \ If A is non-zero, skip the following (so the hook has
                        \ no effect when the car is off the ground)

                        \ If we get here then heightAboveTrack = 0, so the car
                        \ is on the ground 

 LDA playerSpeedHi      \ Set A = the high byte of the current speed

 JSR MultiplyHeight     \ Set:
                        \
                        \   A = A * yTrackSegmentI
                        \     = playerSpeedHi * yTrackSegmentI
                        \
                        \ The value given in yTrackSegmentI is the y-coordinate
                        \ of the segment vector, i.e. the vector from this
                        \ segment to the next, which is the same as the change
                        \ in height as we move through the segment
                        \
                        \ So this value is higher with greater speed and on
                        \ segments that have higher slopes

 BPL slop1              \ If A is positive, skip the following instruction

 DEC W                  \ Decrement W to &FF, so (W A) has the correct sign

.slop1

 ASL A                  \ Implement the shifts that we overwrote with the call
 ROL W                  \ to the hook routine, so we have effectively inserted
                        \ the above code into the main game

 RTS                    \ Return from the subroutine

 EQUB &00, &00          \ These bytes appear to be unused

\ ******************************************************************************
\
\       Name: trackSectionCount
\       Type: Variable
\   Category: Extra track data
\    Summary: The total number of track sections * 8
\  Deep dive: The track data file format
\
\ ******************************************************************************

 EQUB 29 * 8

\ ******************************************************************************
\
\       Name: trackVectorCount
\       Type: Variable
\   Category: Track data
\    Summary: The total number of segment vectors in the segment vector tables
\  Deep dive: The track data file format
\
\ ******************************************************************************

 EQUB 40

\ ******************************************************************************
\
\       Name: trackLength
\       Type: Variable
\   Category: Track data
\    Summary: The length of the full track in terms of segments
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ The highest segment number is this value minus 1, as segment numbers start
\ from zero.
\
\ ******************************************************************************

 EQUW 914               \ Segments are numbered from 0 to 913

\ ******************************************************************************
\
\       Name: trackStartLine
\       Type: Variable
\   Category: Track data
\    Summary: The segment number of the starting line
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ This is the segment number of the starting line, expressed as the number of
\ segments from the starting line to the start of section 0, counting forwards
\ around the track.
\
\ If the starting line is at segment n, this value is the track length minus n,
\ which is 914 - 914 at Silverstone.
\
\ ******************************************************************************

 EQUW 914 - 914         \ The starting line is at segment 0

\ ******************************************************************************
\
\       Name: trackLapTimeSec
\       Type: Variable
\   Category: Extra track data
\    Summary: Lap times for adjusting the race class (seconds)
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ If the slowest lap time is a human player, and it's slower than one of these
\ times, then we change the race class to the relevant difficulty.
\
\ ******************************************************************************

 EQUB 50                \ Set class to Novice if slowest lap time > 1:50

 EQUB 40                \ Set class to Amateur if slowest lap time > 1:40

 EQUB 0                 \ Otherwise set class to Professional

\ ******************************************************************************
\
\       Name: trackLapTimeMin
\       Type: Variable
\   Category: Extra track data
\    Summary: Lap times for adjusting the race class (minutes)
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ If the slowest lap time is a human player, and it's slower than one of these
\ times, then we change the race class to the relevant difficulty.
\
\ ******************************************************************************

 EQUB 1                 \ Set class to Novice if slowest lap time > 1:50

 EQUB 1                 \ Set class to Amateur if slowest lap time > 1:40

 EQUB 0                 \ Otherwise set class to Professional

\ ******************************************************************************
\
\       Name: trackGearRatio
\       Type: Variable
\   Category: Extra track data
\    Summary: The gear ratio for each gear
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ The rev count is calculated by multiplying the track gear ratio by the current
\ speed, so lower gears correspond to more revs at the same wheel speed when
\ compared to higher gears.
\
\ ******************************************************************************

 EQUB 103               \ Reverse

 EQUB 0                 \ Neutral

 EQUB 103               \ First gear

 EQUB 74                \ Second gear

 EQUB 60                \ Third gear

 EQUB 50                \ Fourth gear

 EQUB 44                \ Fifth gear

\ ******************************************************************************
\
\       Name: trackGearPower
\       Type: Variable
\   Category: Extra track data
\    Summary: The power for each gear
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ The engine torque is calculated by multiplying the rev count by the power for
\ the relevant gear, so lower gears create more torque at the same rev count
\ when compared to higher gears.
\
\ ******************************************************************************

 EQUB 161               \ Reverse

 EQUB 0                 \ Neutral

 EQUB 161               \ First gear

 EQUB 116               \ Second gear

 EQUB 93                \ Third gear

 EQUB 79                \ Fourth gear

 EQUB 68                \ Fifth gear

\ ******************************************************************************
\
\       Name: trackBaseSpeed
\       Type: Variable
\   Category: Extra track data
\    Summary: The base speed for each race class, used when generating the best
\             racing lines and non-player driver speeds
\  Deep dive: The track data file format
\
\ ******************************************************************************

 EQUB 134               \ Base speed for Novice

 EQUB 146               \ Base speed for Amateur

 EQUB 152               \ Base speed for Professional

\ ******************************************************************************
\
\       Name: trackStartPosition
\       Type: Variable
\   Category: Extra track data
\    Summary: The starting race position of the player during a practice or
\             qualifying lap
\  Deep dive: The track data file format
\
\ ******************************************************************************

 EQUB 5

\ ******************************************************************************
\
\       Name: trackCarSpacing
\       Type: Variable
\   Category: Extra track data
\    Summary: The spacing between the cars at the start of a qualifying lap, in
\             segments
\  Deep dive: The track data file format
\
\ ******************************************************************************

 EQUB 37

\ ******************************************************************************
\
\       Name: trackTimerAdjust
\       Type: Variable
\   Category: Extra track data
\    Summary: Adjustment factor for the speed of the timers to allow for
\             fine-tuning of time on a per-track basis
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ The value of the timerAdjust variable in the main game code is incremented on
\ every iteration of the main driving loop. When it reaches the value in
\ trackTimerAdjust, the timers adds 18/100 of a second rather than 9/100 of
\ a second. Decreasing this value therefore speeds up the timers, allowing their
\ speed to be adjusted on a per-track basis.
\
\ Setting this value to 255 disables the timer adjustment.
\
\ ******************************************************************************

 EQUB 70

\ ******************************************************************************
\
\       Name: trackRaceSlowdown
\       Type: Variable
\   Category: Extra track data
\    Summary: Slowdown factor for non-player drivers in the race
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ Reduce the speed of all cars in a race by this amount (this does not affect
\ the speed during qualifying). I suspect this is used for testing purposes.
\
\ ******************************************************************************

 EQUB 0

\ ******************************************************************************
\
\       Name: HookFirstSegment
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.HookFirstSegment

 JSR sub_C557F

 JMP SetSegmentVector   \ Calculate the segment vector for the current segment
                        \ and put it in the xSegmentVectorI, ySegmentVectorI,
                        \ zSegmentVectorI, xSegmentVectorO and zSegmentVectorO
                        \ tables, returning from the subroutine using a tail
                        \ call

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: CallTrackHook
\       Type: Subroutine
\   Category: Extra track data
\    Summary: The track file's hook code
\  Deep dive: The track data file format
\
\ ******************************************************************************

.CallTrackHook

 JMP ModifyGameCode     \ Modify the main game code

\ ******************************************************************************
\
\       Name: trackChecksum
\       Type: Variable
\   Category: Extra track data
\    Summary: The track file's checksum
\  Deep dive: The track data file format
\
\ ******************************************************************************

.trackChecksum

 EQUB &87               \ Counts the number of data bytes ending in %00

 EQUB &D4               \ Counts the number of data bytes ending in %01

 EQUB &78               \ Counts the number of data bytes ending in %10
 
 EQUB &52               \ Counts the number of data bytes ending in %11

\ ******************************************************************************
\
\       Name: trackGameName
\       Type: Variable
\   Category: Extra track data
\    Summary: The game name
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ This string is checked by the loader to see whether a track file has been
\ loaded (and if not, it loads one).
\
\ ******************************************************************************

.trackGameName

 EQUS "REVS"            \ Game name

\ ******************************************************************************
\
\       Name: trackName
\       Type: Variable
\   Category: Extra track data
\    Summary: The track name
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ This string is shown on the loading screen.
\
\ ******************************************************************************

.trackName

 EQUS "Brands Hatch"     \ Track name
 EQUB 13

 EQUB &DC, &20, &22, &20, &42, &52
 EQUB &41, &4E, &44, &53, &20, &48, &41, &54
 EQUB &43, &48, &22, &2C, &22, &20, &44, &4F
 EQUB &4E, &49, &4E, &47, &54, &4F, &4E, &20
 EQUB &50, &41, &52, &4B, &22, &2C, &22, &20
 EQUB &4F, &55, &4C, &54, &4F, &4E, &20, &50
 EQUB &41, &52, &4B, &20, &20, &20, &22, &2C
 EQUB &22, &20, &53, &4E, &45, &54, &54, &45
 EQUB &52, &54, &4F, &4E, &20, &20, &20, &20
 EQUB &22, &0D, &04, &06, &0A, &20, &DC, &22
 EQUB &22, &20, &20, &0D, &04, &10, &24, &20
 EQUB &F4, &20, &50, &72, &6F, &67, &72, &61
 EQUB &6D, &73, &20, &6F, &6E, &20, &74, &68
 EQUB &65, &20, &64, &69, &73, &63, &20, &6F
 EQUB &72, &20, &74, &61, &70, &65, &20, &0D
 EQUB &04, &1A, &11, &20, &DC, &42, &20, &2C
 EQUB &44, &20, &2C, &4F, &20, &2C, &53, &20
 EQUB &0D, &04, &24, &0E, &20, &DC, &22, &22
 EQUB &20, &20, &20, &20, &20, &20, &0D, &FF

\ ******************************************************************************
\
\ Save BrandsHatch.bin
\
\ ******************************************************************************

SAVE "3-assembled-output/BrandsHatch.bin", CODE%, P%
