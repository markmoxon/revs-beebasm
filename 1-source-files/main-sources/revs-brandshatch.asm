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
\ ------------------------------------------------------------------------------
\
\ trackSectionData etc.
\
\ ******************************************************************************

 EQUB &01, &D1, &14, &0F, &D0, &34, &0F, &7F
 EQUB &13, &D4, &14, &2A, &D3, &29, &2A, &1C
 EQUB &22, &E0, &0F, &2D, &E0, &FF, &2E, &FF
 EQUB &31, &EA, &0E, &29, &EA, &16, &2A, &49
 EQUB &31, &F3, &11, &23, &F4, &18, &24, &06
 EQUB &43, &F1, &0D, &1E, &F1, &15, &1D, &FF
 EQUB &44, &E6, &08, &23, &E5, &1F, &23, &12
 EQUB &53, &DE, &05, &21, &DE, &01, &20, &FF
 EQUB &54, &DA, &05, &1C, &DA, &27, &1B, &13
 EQUB &53, &D8, &05, &16, &D9, &2B, &16, &75
 EQUB &62, &D9, &05, &01, &DA, &28, &01, &14
 EQUB &61, &E5, &0A, &FC, &E4, &01, &FD, &7B
 EQUB &73, &EF, &11, &07, &EE, &FF, &08, &FF
 EQUB &82, &06, &11, &1B, &05, &FF, &1C, &FF
 EQUB &81, &12, &0E, &24, &11, &13, &25, &8E
 EQUB &90, &1B, &11, &2B, &1A, &2E, &2C, &17
 EQUB &92, &2A, &15, &2A, &2B, &32, &2B, &7F
 EQUB &A1, &3C, &14, &17, &3C, &25, &18, &12
 EQUB &A3, &3A, &14, &0C, &3B, &15, &0B, &FF
 EQUB &A2, &2D, &11, &00, &2D, &28, &FF, &14
 EQUB &A1, &29, &11, &FE, &2A, &15, &FD, &7B
 EQUB &B1, &1D, &14, &FB, &1D, &18, &FA, &0C
 EQUB &B3, &18, &15, &FC, &18, &21, &FB, &6C
 EQUB &C2, &0C, &14, &09, &0C, &1B, &09, &0D
 EQUB &C1, &05, &15, &0A, &06, &FF, &09, &FF
 EQUB &D3, &F9, &19, &FE, &FA, &2F, &FD, &7D
 EQUB &E2, &E5, &19, &EC, &E6, &2A, &EB, &18
 EQUB &E1, &DB, &16, &ED, &DA, &FF, &ED, &7D
 EQUB &F2, &D3, &17, &F7, &D2, &FF, &F7, &FF
 EQUB &00, &00, &00, &00, &00, &34, &00, &7F

\ ******************************************************************************
\
\       Name: Hook80Percent
\       Type: Subroutine
\   Category: Extra track data
\    Summary: Calculate (A T) = 0.8 * A
\
\ ------------------------------------------------------------------------------
\
\ Calculate (A T) = 205 / 256 * A
\                 = 0.8 * A
\
\ ******************************************************************************

.Hook80Percent

 STA U                  \ Set U = A

 LDA #205               \ Set A = 205

 JMP Multiply8x8        \ Set (A T) = A * U
                        \           = 205 * A

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: thisSectionDataIdx
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.thisSectionDataIdx

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
\       Name: L53FD
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.L53FD

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
\    Summary: 
\
\ ******************************************************************************

.modifyAddressLo

 EQUB &49               \ !&1249
 EQUB &8A               \ !&128A
 EQUB &CA               \ !&13CA
 EQUB &27               \ !&1427
 EQUB &FC               \ !&12FC
 EQUB &1B               \ !&261B
 EQUB &8C               \ !&248C
 EQUB &39               \ !&2539
 EQUB &94               \ !&1594
 EQUB &D1               \ !&4CD1
 EQUB &C9               \ !&4CC9
 EQUB &C1               \ !&4CC1
 EQUB &D6               \ !&44D6
 EQUB &D7               \ !&4CD7
 EQUB &E1               \ !&4CE1
 EQUB &47               \ !&1947
 EQUB &F3               \ !&24F3
 EQUB &2C               \ !&462C
 EQUB &43               \ !&2543

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: modifyAddressHi
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.modifyAddressHi

 EQUB &12               \ !&1249
 EQUB &12               \ !&128A
 EQUB &13               \ !&13CA
 EQUB &14               \ !&1427
 EQUB &12               \ !&12FC
 EQUB &26               \ !&261B
 EQUB &24               \ !&248C
 EQUB &25               \ !&2539
 EQUB &15               \ !&1594
 EQUB &4C               \ !&4CD1
 EQUB &4C               \ !&4CC9
 EQUB &4C               \ !&4CC1
 EQUB &44               \ !&44D6
 EQUB &4C               \ !&4CD7
 EQUB &4C               \ !&4CE1
 EQUB &19               \ !&1947
 EQUB &24               \ !&24F3
 EQUB &46               \ !&462C
 EQUB &25               \ !&2543

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
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.trackSignData

 EQUB &0C, &10, &23, &20, &38, &4D
 EQUB &58, &60, &6C, &8C, &A4, &B5, &C0, &D4
 EQUB &E0, &01

\ ******************************************************************************
\
\       Name: sub_C5472
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sub_C5472

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
\ If bit 6 of the current section's flags is set, call sub_C5582 (this bit is
\ unused in the original track data file).
\
\ ******************************************************************************

.HookSectionFlag6b

 LDA thisSectionFlags   \ If bit 6 of the current section's flags is clear, jump
 AND #%01000000         \ to flab1 to implement the same code as in the original
 BEQ flab1

 JSR sub_C5582          \ Bit 6 of the current section's flags is set, so call
                        \ sub_C5582 before continuing with the same code as in
                        \ the original

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
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
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
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
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

 EQUB &F0, &D6, &D8, &0C, &09, &FE
 EQUB &F6, &32, &1C, &DF, &F4, &F2, &F8, &33
 EQUB &0D, &FC

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

 JSR UpdateVectorNumber

\ ******************************************************************************
\
\       Name: sub_C5582
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sub_C5582

 LDY thisSectionDataIdx

 LDA L53FD

 SEC

 BIT directionFacing
 BMI L55A0

 ADC #0

 CMP L5728,Y
 BCC L55B6

 LDA #0

 INY

 CPY L53F9
 BCC L55B6

 LDY #0

 BEQ L55B6

.L55A0

 SBC #1

 BCS L55B6

 TYA
 AND #%01111111
 TAY

 CPY #1
 BCS L55AF

 LDY L53F9

.L55AF

 DEY

 LDA L5728,Y
 SEC
 SBC #1

.L55B6

 STA L53FD

 STY thisSectionDataIdx

 RTS

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

 LDY thisSectionDataIdx \ Set Y = thisSectionDataIdx

 BMI L55FA              \ If bit 7 of Y is set, jump to L55FA to skip the
                        \ following

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

 JSR sub_C5472          \ ???

 LDX xStore             \ Retrieve the value of X we stores above, so we can
                        \ return it unchanged by the routine

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: ModifyGameCode (Part 3 of 3)
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.mods3

 LDA #4
 STA &3574

 LDA #11
 STA &35F4

 LDA #&E9
 STA &45CC

 LDA #&59
 STA &45CD

 LDA #&4B
 STA &2772

 RTS

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

 EQUB &1A, &4C, &D9, &E6, &0D, &08
 EQUB &EC, &06, &E0, &10, &12, &05, &1E, &01
 EQUB &FA, &08

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

 LDA sectionDataIndex,Y \ Set A to this section's entry from sectionDataIndex

 LSR A                  \ Set A = A >> 2, with bit 6 cleared, bit 7 set to the
 ROR A                  \ bit 0 of the sectionDataIndex entry, and the C flag
                        \ set to bit 1 of the sectionDataIndex entry

 STA thisSectionDataIdx \ Store A in thisSectionDataIdx, so it contains:
                        \
                        \  * sectionDataIndex / 4              if bit 0 is clear
                        \
                        \  * 128 + (sectionDataIndex / 4)      if bit 0 is set
                        \
                        \ where bit 0 is from the original sectionDataIndex
                        \ entry

 LDA #14                \ Set A = 7, with bit 7 set to the C flag (so if this
 ROR A                  \ section's sectionDataIndex entry has bit 1 set, then A
                        \ is 135, otherwise it is 7)

 STA &23B3              \ Modify the GetSectionAngles routine, at instruction
                        \ #4 after gsec11, to test prevHorizonIndex against the
                        \ value we just calculated in A rather than 7
                        \ 
                        \ So if this section's sectionDataIndex entry has bit 1
                        \ set, the test becomes prevHorizonIndex <= 135, which
                        \ is always true, so this modification makes us never
                        \ set the horizon line to 7 for sections that have bit 1
                        \ of sectionDataIndex set

 LDA #0                 \ Set L53FD = 0
 STA L53FD

 BIT directionFacing    \ If we are facing backwards along the track, jump to
 BMI L56AA              \ L56AA to skip the following

 JSR sub_C55C4          \ ???

.L56AA

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
\    Summary: 
\
\ ******************************************************************************

.ModifyGameCode

 LDX #18

.mods1

 LDA modifyAddressHi,X
 STA U

 LDA modifyAddressLo,X
 STA T

 LDY #0

 LDA newContentLo,X
 STA (T),Y

 INY

 LDA newContentHi,X
 STA (T),Y

 DEX

 BPL mods1

 LDA #&4C
 STA &261A
 STA &248B

 JMP mods2

 EQUB &00               \ This byte appears to be unused

\ ******************************************************************************
\
\       Name: L5728
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.L5728

 EQUB &1A, &15, &0B, &0A, &04, &0F, &15, &02
 EQUB &0C, &0C, &02, &14, &1B, &07, &0C, &03
 EQUB &0A, &0A, &1D, &07, &03, &0B, &0E, &06
 EQUB &15, &0B, &0D, &06, &2E, &10, &10, &0C
 EQUB &0C, &08, &0C, &10, &04, &0A, &08, &05
 EQUB &0C, &1A, &08, &05, &05, &05, &0C, &0F
 EQUB &15, &23, &16, &03, &0E, &08, &13, &08
 EQUB &11, &22

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

 EQUB &D2, &04, &1C, &EC, &0A, &EB
 EQUB &F7, &2D, &1B, &2B, &F8, &10, &F2, &29
 EQUB &EC, &00

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

 EQUB &00
 EQUB &01, &03, &04, &06, &07, &09, &0A, &0C
 EQUB &0D, &0F, &10, &12, &13, &15, &16, &17
 EQUB &19, &1A, &1C, &1D, &1F, &20, &21, &23
 EQUB &24, &26, &27, &28, &2A, &2B, &2D, &2E
 EQUB &2F, &31, &32, &33, &35, &36, &37, &39
 EQUB &3A, &3B, &3C, &3E, &3F, &40, &41, &43
 EQUB &44, &45, &46, &47, &49, &4A, &4B, &4C
 EQUB &4D, &4E, &4F, &51, &52, &53, &54, &55

\ ******************************************************************************
\
\       Name: ModifyGameCode (Part 2 of 3)
\       Type: Subroutine
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.mods2

 LDA #&20
 STA &1248
 STA &12FB
 STA &2538
 STA &45CB

 LDA #&EA
 STA &2545

 LDA #22
 STA &4F55
 STA &4F59

 LDA #13
 STA &24EA

 LDA #&A2
 STA &1FE9

 JMP mods3

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

 EQUB &00, &2F
 EQUB &8A, &E0, &E0, &A4, &A4, &52, &52, &47
 EQUB &42, &0A, &0A, &92, &92, &92, &0A, &0A
 EQUB &0E, &0E, &9E, &9E, &6C, &6C, &B3, &B3
 EQUB &B3, &28, &C8, &00

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

 EQUB &00, &12, &50, &55
 EQUB &55, &D2, &D2, &9D, &9D, &87, &76, &1D
 EQUB &1D, &25, &25, &25, &62, &62, &A2, &A2
 EQUB &B5, &B5, &E2, &E2, &A1, &A1, &A1, &DF
 EQUB &F3, &00

\ ******************************************************************************
\
\       Name: sectionDataIndex
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.sectionDataIndex

 EQUB &02, &0E, &1A, &22, &2A, &32
 EQUB &36, &3F, &3E, &46, &52, &62, &6A, &76
 EQUB &7E, &84, &91, &92, &A2, &AA, &AF, &AE
 EQUB &B5, &B4, &BC, &C4, &CE, &DA, &E2, &00

\ ******************************************************************************
\
\       Name: trackRacingLine
\       Type: Variable
\   Category: Extra track data
\    Summary: 
\
\ ------------------------------------------------------------------------------
\
\ 
\
\ ******************************************************************************

.trackRacingLine

 EQUB &18, &33, &18, &00, &4F, &31, &68, &19
 EQUB &30, &19, &2E, &18, &18, &18, &18, &33
 EQUB &18, &3F, &18, &55, &18, &5B, &35, &42
 EQUB &18, &18, &4B, &18, &18, &18, &00

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

 EQUB &78
 EQUB &78, &78, &78, &78, &78, &78, &78, &77
 EQUB &77, &77, &77, &77, &76, &76, &76, &76
 EQUB &75, &75, &75, &74, &74, &74, &73, &73
 EQUB &72, &72, &71, &71, &70, &70, &6F, &6F
 EQUB &6E, &6E, &6D, &6C, &6C, &6B, &6B, &6A
 EQUB &69, &68, &68, &67, &66, &65, &65, &64
 EQUB &63, &62, &61, &60, &60, &5F, &5E, &5D
 EQUB &5C, &5B, &5A, &59, &58, &57, &56, &55

\ ******************************************************************************
\
\       Name: Track section data (Part 2 of 2)
\       Type: Variable
\   Category: Extra track data
\    Summary: Data for the track sections
\  Deep dive: The track data file format
\
\ ------------------------------------------------------------------------------
\
\ trackSectionFlag etc.
\
\ ******************************************************************************

 EQUB &70, &20, &00, &A0, &21, &00, &A0, &3A
 EQUB &ED, &DC, &87, &5C, &F6, &12, &C8, &1D
 EQUB &42, &52, &2B, &E3, &B5, &07, &CC, &17
 EQUB &70, &2B, &DE, &96, &AA, &1E, &73, &18
 EQUB &ED, &EB, &6C, &F6, &6A, &0E, &D3, &16
 EQUB &6A, &71, &53, &53, &00, &24, &6D, &1B
 EQUB &73, &0D, &43, &EA, &9C, &17, &04, &13
 EQUB &04, &2F, &EB, &20, &F0, &02, &7A, &0D
 EQUB &41, &39, &EB, &81, &FA, &03, &DB, &0D
 EQUB &68, &36, &EB, &CE, &30, &10, &A1, &2E
 EQUB &F3, &0A, &EB, &52, &00, &16, &8F, &22
 EQUB &C4, &58, &DF, &7C, &96, &10, &21, &20
 EQUB &40, &18, &73, &DC, &56, &08, &81, &41
 EQUB &40, &61, &32, &7F, &C5, &22, &4B, &20
 EQUB &70, &61, &12, &9F, &C5, &1B, &6B, &18
 EQUB &ED, &61, &C0, &77, &C5, &0C, &43, &24
 EQUB &32, &A6, &DC, &F6, &63, &09, &A2, &37
 EQUB &ED, &0D, &C9, &D7, &CA, &0B, &83, &1B
 EQUB &72, &6B, &A8, &7C, &17, &27, &BE, &26
 EQUB &6D, &35, &28, &76, &E1, &26, &B8, &08
 EQUB &30, &E7, &AC, &C6, &28, &07, &CF, &1C
 EQUB &ED, &37, &A0, &62, &78, &09, &6B, &0A
 EQUB &2A, &F2, &09, &9E, &34, &14, &F1, &26
 EQUB &F3, &EC, &97, &D4, &2E, &16, &27, &11
 EQUB &44, &D0, &99, &0B, &7E, &00, &50, &24
 EQUB &70, &70, &23, &83, &1E, &25, &C8, &39

\ L59D0, normally trackRacingLine then trackSignData

 EQUB &ED, &D8, &3C, &41, &86, &0F, &86, &19
 EQUB &C2, &15, &E6, &CA, &64, &01, &11, &1B
 EQUB &40, &98, &9A, &D9, &A5, &1D, &8C, &33
 EQUB &70

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

 JMP sub_C5472

 EQUB 0

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
