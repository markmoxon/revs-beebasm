\ ******************************************************************************
\
\ REVS OULTON PARK TRACK SOURCE
\
\ Revs was written by Geoffrey J Crammond and is copyright Acornsoft 1985
\
\ The code on this site has been disassembled from the original game discs
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

\ ******************************************************************************
\
\ REVS OULTON PARK TRACK
\
\ Produces the binary file OultonPark.bin that contains the Oulton Park track.
\
\ ******************************************************************************

ORG CODE%

.trackData

 EQUB &12, &D1, &12, &D1, &D0, &2A, &D1, &78
 EQUB &21, &CE, &10, &E6, &CD, &1B, &E5, &0F
 EQUB &23, &D2, &10, &ED, &D1, &FF, &EE, &FF
 EQUB &33, &E2, &0F, &F3, &E2, &09, &F4, &FF
 EQUB &33, &ED, &0F, &F6, &EC, &24, &F7, &14
 EQUB &42, &EF, &0F, &F6, &EF, &12, &F7, &82
 EQUB &53, &FA, &0C, &F6, &FA, &31, &F7, &1A
 EQUB &54, &03, &0B, &04, &02, &FF, &04, &FF
 EQUB &63, &F8, &0F, &20, &F7, &1C, &20, &43
 EQUB &73, &F4, &0E, &2D, &F3, &17, &2D, &0A
 EQUB &83, &F8, &0D, &30, &F9, &FF, &31, &FF
 EQUB &83, &01, &0F, &20, &01, &FF, &20, &FF
 EQUB &92, &05, &0E, &17, &06, &FF, &18, &FF
 EQUB &A5, &12, &0D, &FF, &12, &0D, &FF, &8C
 EQUB &A4, &16, &0F, &F5, &17, &22, &F6, &12
 EQUB &A3, &16, &0F, &EE, &16, &1C, &EE, &FF
 EQUB &B3, &0A, &0E, &DD, &0B, &26, &DC, &0C
 EQUB &B3, &08, &10, &D7, &09, &FF, &D7, &FF
 EQUB &C3, &03, &11, &C3, &04, &1F, &C3, &89
 EQUB &D3, &04, &10, &B2, &05, &2A, &B2, &17
 EQUB &E3, &FA, &12, &AA, &FA, &FF, &A9, &FF
 EQUB &E3, &EF, &11, &AA, &EF, &FF, &A9, &FF
 EQUB &E1, &E0, &12, &A9, &E0, &25, &A8, &5B
 EQUB &F1, &CD, &12, &A8, &CC, &16, &A7, &0D
 EQUB &F3, &CA, &12, &AD, &C9, &06, &AD, &FF
 EQUB &03, &CF, &14, &BB, &CE, &2D, &BC, &0E
 EQUB &03, &D0, &14, &BF, &CF, &FF, &BF, &FF
 EQUB &06, &74, &2A, &60, &A5, &2A, &20, &78
 EQUB &34, &C9, &19, &B0, &07, &A5, &0D, &10
 EQUB &85, &75, &A9, &CD, &4C, &00, &0C, &85
 EQUB &75, &20, &00, &0C, &06, &74, &2A, &60
 EQUB &00, &3A, &00, &00, &00, &00, &00, &00

\ &5400

 EQUB &49, &8A, &CA, &27, &FC, &1B, &8C, &39
 EQUB &94, &D1, &C9, &C1, &D6, &D7, &E1, &47
 EQUB &F3, &2C, &43, &24, &12, &12, &13, &14
 EQUB &12, &26, &24, &25, &15, &4C, &4C, &4C
 EQUB &44, &4C, &4C, &19, &24, &46, &25, &2F
 EQUB &FE, &00, &FF, &00, &01, &04, &04, &00
 EQUB &01, &00, &00, &FE, &FD, &FE, &FC, &00
 EQUB &00, &00, &00, &05, &07, &00, &00, &00
 EQUB &00, &00, &00, &02, &01, &00, &00, &00
 EQUB &FE, &00, &00, &FF, &FF, &FF, &00, &00
 EQUB &04, &01, &02, &02, &00, &FF, &00, &00
 EQUB &00, &01, &05, &05, &00, &00, &FE, &00
 EQUB &FE, &00, &D1, &04, &10, &18, &25, &38
 EQUB &4B, &48, &50, &74, &78, &80, &9C, &98
 EQUB &BC, &C8, &AD, &FA, &53, &0A, &AD, &FB
 EQUB &53, &2A, &48, &2A, &2A, &2A, &29, &07
 EQUB &85, &75, &4A, &68, &29, &3F, &90, &04
 EQUB &49, &3F, &69, &00, &AA, &BC, &BF, &57
 EQUB &BD, &BF, &58, &AA, &A5, &75, &18, &69
 EQUB &01, &29, &02, &D0, &06, &84, &76, &86
 EQUB &77, &F0, &04, &86, &76, &84, &77, &A5
 EQUB &75, &C9, &04, &90, &06, &A9, &00, &E5
 EQUB &76, &85, &76, &A5, &75, &C9, &06, &B0
 EQUB &0A, &C9, &02, &90, &06, &A9, &00, &E5
 EQUB &77, &85, &77, &A4, &02, &A9, &80, &85
 EQUB &75, &A5, &76, &99, &00, &54, &20, &EB
 EQUB &54, &99, &00, &58, &A5, &77, &99, &00
 EQUB &56, &20, &EB, &54, &49, &FF, &18, &69
 EQUB &01, &99, &00, &57, &AD, &FC, &53, &99
 EQUB &00, &55, &60, &08, &4C, &1B, &46, &A5
 EQUB &01, &29, &40, &F0, &03, &20, &82, &55
 EQUB &A5, &24, &18, &69, &03, &60, &03, &60

\ &5500

 EQUB &72, &1B, &72, &72, &EF, &AF, &BC, &72
 EQUB &A1, &62, &62, &62, &A0, &62, &62, &C8
 EQUB &BD, &E1, &E8, &E8, &56, &5A, &55, &55
 EQUB &54, &56, &56, &57, &57, &55, &56, &57
 EQUB &58, &54, &54, &56, &55, &59, &53, &59
 EQUB &39, &00, &87, &00, &61, &0A, &0A, &1E
 EQUB &C7, &00, &00, &4B, &D5, &FA, &44, &17
 EQUB &17, &00, &00, &09, &9B, &00, &00, &00
 EQUB &00, &00, &00, &FD, &D6, &00, &B0, &00
 EQUB &CD, &00, &00, &A5, &D2, &1C, &00, &FE
 EQUB &CD, &4E, &0D, &0D, &00, &7D, &E4, &00
 EQUB &00, &8A, &74, &74, &42, &42, &3F, &00
 EQUB &39, &00, &03, &F9, &14, &04, &04, &F5
 EQUB &16, &FA, &2C, &DE, &FC, &F7, &02, &EB
 EQUB &4C, &F0, &A5, &01, &29, &40, &F0, &06
 EQUB &20, &E0, &13, &20, &C4, &55, &60, &20
 EQUB &E0, &13, &AC, &F8, &53, &AD, &FD, &53
 EQUB &38, &24, &25, &30, &13, &69, &00, &D9
 EQUB &28, &57, &90, &22, &A9, &00, &C8, &CC
 EQUB &F9, &53, &90, &1A, &A0, &00, &F0, &16
 EQUB &E9, &01, &B0, &12, &98, &29, &7F, &A8
 EQUB &C0, &01, &B0, &03, &AC, &F9, &53, &88
 EQUB &B9, &28, &57, &38, &E9, &01, &8D, &FD
 EQUB &53, &8C, &F8, &53, &60, &24, &43, &30
 EQUB &FB, &4C, &0B, &14, &86, &45, &AC, &F8
 EQUB &53, &30, &2F, &B9, &28, &55, &85, &74
 EQUB &B9, &28, &54, &24, &25, &20, &40, &0E
 EQUB &85, &75, &A5, &74, &18, &6D, &FA, &53
 EQUB &8D, &FA, &53, &A5, &75, &6D, &FB, &53
 EQUB &8D, &FB, &53, &B9, &28, &56, &24, &25
 EQUB &20, &50, &34, &18, &6D, &FC, &53, &8D
 EQUB &FC, &53, &20, &72, &54, &A6, &45, &60

\ &5600

 EQUB &A9, &04, &8D, &74, &35, &A9, &0B, &8D
 EQUB &F4, &35, &A9, &E7, &8D, &CC, &45, &A9
 EQUB &59, &8D, &CD, &45, &A9, &4B, &8D, &72
 EQUB &27, &60, &A9, &8D, &10, &13, &A9, &10
 EQUB &8D, &11, &13, &60, &00, &00, &00, &00
 EQUB &00, &00, &FF, &FF, &00, &07, &FC, &00
 EQUB &FE, &FD, &00, &01, &01, &01, &01, &00
 EQUB &FD, &00, &00, &00, &01, &01, &FF, &FE
 EQUB &02, &02, &FF, &FF, &F9, &00, &04, &05
 EQUB &FD, &FC, &00, &00, &00, &FF, &00, &00
 EQUB &00, &01, &07, &F5, &00, &03, &FD, &00
 EQUB &FF, &01, &09, &F6, &06, &FC, &FE, &00
 EQUB &02, &01, &E6, &08, &06, &07, &07, &18
 EQUB &08, &01, &18, &F2, &F4, &24, &16, &09
 EQUB &04, &F8, &84, &1B, &B9, &05, &59, &85
 EQUB &02, &98, &4A, &4A, &4A, &A8, &B9, &46
 EQUB &58, &8D, &FA, &53, &B9, &64, &58, &8D
 EQUB &FB, &53, &B9, &28, &58, &8D, &FC, &53
 EQUB &B9, &82, &58, &4A, &6A, &8D, &F8, &53
 EQUB &A9, &0E, &6A, &8D, &B3, &23, &A9, &00
 EQUB &8D, &FD, &53, &24, &25, &30, &03, &20
 EQUB &C4, &55, &A4, &1B, &A5, &02, &60, &48
 EQUB &A5, &42, &C9, &0C, &68, &B0, &04, &85
 EQUB &1F, &84, &51, &60, &90, &07, &A5, &42
 EQUB &C9, &0A, &90, &01, &60, &4C, &90, &24
 EQUB &98, &29, &20, &85, &82, &A9, &00, &85
 EQUB &7F, &88, &B9, &20, &5F, &C5, &1F, &B0
 EQUB &1E, &C5, &7F, &B0, &F2, &A5, &7F, &69
 EQUB &00, &99, &20, &5F, &A5, &82, &D0, &E9
 EQUB &A5, &7F, &8D, &EA, &1F, &C8, &20, &3B
 EQUB &25, &88, &38, &66, &82, &30, &DA, &A4
 EQUB &4B, &88, &84, &75, &4C, &33, &19, &00

\ &5700

 EQUB &A2, &12, &BD, &14, &54, &85, &75, &BD
 EQUB &00, &54, &85, &74, &A0, &00, &BD, &00
 EQUB &55, &91, &74, &C8, &BD, &14, &55, &91
 EQUB &74, &CA, &10, &E6, &A9, &4C, &8D, &1A
 EQUB &26, &8D, &8B, &24, &4C, &00, &58, &00
 EQUB &02, &12, &03, &16, &08, &06, &05, &18
 EQUB &06, &04, &12, &0A, &15, &08, &02, &06
 EQUB &0A, &0E, &02, &03, &0E, &14, &14, &0A
 EQUB &0A, &10, &06, &0A, &06, &18, &07, &0D
 EQUB &0D, &06, &0D, &05, &14, &09, &15, &07
 EQUB &03, &0C, &08, &07, &0E, &09, &02, &16
 EQUB &0C, &06, &04, &08, &11, &10, &08, &11
 EQUB &02, &13, &31, &1A, &06, &07, &00, &22
 EQUB &B4, &0D, &B5, &4C, &E7, &F1, &3D, &E7
 EQUB &FE, &E9, &8D, &EA, &1F, &99, &48, &5F
 EQUB &B9, &40, &5E, &38, &F9, &68, &5E, &B9
 EQUB &90, &5E, &F9, &B8, &5E, &10, &0C, &B9
 EQUB &40, &5E, &99, &68, &5E, &B9, &90, &5E
 EQUB &99, &B8, &5E, &B9, &20, &5F, &99, &48
 EQUB &5F, &C8, &C0, &09, &90, &DA, &A4, &51
 EQUB &60, &A4, &6F, &B9, &E8, &06, &A0, &B5
 EQUB &C9, &48, &D0, &02, &A0, &F8, &C9, &B8
 EQUB &F0, &04, &C9, &B0, &D0, &02, &A0, &BE
 EQUB &98, &20, &00, &0C, &4C, &EF, &53, &00
 EQUB &01, &03, &04, &06, &07, &09, &0A, &0C
 EQUB &0D, &0F, &10, &12, &13, &15, &16, &17
 EQUB &19, &1A, &1C, &1D, &1F, &20, &21, &23
 EQUB &24, &26, &27, &28, &2A, &2B, &2D, &2E
 EQUB &2F, &31, &32, &33, &35, &36, &37, &39
 EQUB &3A, &3B, &3C, &3E, &3F, &40, &41, &43
 EQUB &44, &45, &46, &47, &49, &4A, &4B, &4C
 EQUB &4D, &4E, &4F, &51, &52, &53, &54, &55

\ &5800

 EQUB &A9, &20, &8D, &48, &12, &8D, &FB, &12
 EQUB &8D, &38, &25, &8D, &CB, &45, &A9, &EA
 EQUB &8D, &45, &25, &A9, &16, &8D, &55, &4F
 EQUB &8D, &59, &4F, &A9, &0D, &8D, &EA, &24
 EQUB &A9, &A2, &8D, &E9, &1F, &4C, &00, &56
 EQUB &00, &E7, &FD, &FD, &FD, &F1, &E5, &0E
 EQUB &0E, &F0, &FE, &FE, &FE, &FE, &18, &E4
 EQUB &41, &1A, &02, &F9, &F0, &0B, &0B, &FF
 EQUB &D3, &F9, &E9, &E6, &FF, &00, &00, &07
 EQUB &7D, &7D, &4D, &F7, &F7, &B6, &B6, &26
 EQUB &BB, &BB, &BB, &BB, &BB, &A1, &71, &DA
 EQUB &7B, &69, &3B, &A0, &A0, &A4, &14, &96
 EQUB &8E, &28, &C8, &00, &00, &FB, &32, &32
 EQUB &35, &3F, &3F, &F1, &F1, &F3, &6C, &6C
 EQUB &6C, &6C, &6C, &95, &9A, &8A, &85, &84
 EQUB &C1, &BC, &BC, &C7, &09, &11, &03, &DF
 EQUB &F3, &00, &02, &12, &1F, &1E, &22, &26
 EQUB &2E, &3F, &3E, &4A, &56, &5E, &67, &66
 EQUB &6E, &76, &82, &86, &96, &A2, &B2, &BB
 EQUB &BA, &CA, &D2, &DA, &DE, &DA, &E2, &00
 EQUB &18, &4B, &18, &19, &31, &31, &2E, &18
 EQUB &00, &4B, &18, &18, &18, &18, &3F, &55
 EQUB &44, &18, &18, &37, &18, &18, &18, &47
 EQUB &19, &34, &18, &18, &18, &18, &00, &78
 EQUB &78, &78, &78, &78, &78, &78, &78, &77
 EQUB &77, &77, &77, &77, &76, &76, &76, &76
 EQUB &75, &75, &75, &74, &74, &74, &73, &73
 EQUB &72, &72, &71, &71, &70, &70, &6F, &6F
 EQUB &6E, &6E, &6D, &6C, &6C, &6B, &6B, &6A
 EQUB &69, &68, &68, &67, &66, &65, &65, &64
 EQUB &63, &62, &61, &60, &60, &5F, &5E, &5D
 EQUB &5C, &5B, &5A, &59, &58, &57, &56, &55

\ &5900

 EQUB &70, &20, &00, &20, &30, &00, &20, &2D
 EQUB &ED, &C3, &BB, &0C, &D5, &05, &EE, &13
 EQUB &02, &25, &09, &6B, &D5, &18, &4D, &25
 EQUB &40, &7A, &9A, &33, &2A, &19, &15, &18
 EQUB &40, &35, &52, &8A, &F5, &09, &72, &06
 EQUB &68, &FE, &16, &DD, &FC, &0F, &CD, &16
 EQUB &F3, &4E, &D6, &F3, &4C, &25, &E3, &29
 EQUB &04, &2D, &E0, &93, &4D, &26, &3F, &40
 EQUB &70, &AD, &60, &93, &CD, &27, &3F, &1E
 EQUB &ED, &1D, &BB, &DE, &39, &1D, &92, &13
 EQUB &42, &88, &F4, &C0, &5E, &08, &2E, &28
 EQUB &40, &20, &34, &08, &F6, &08, &76, &14
 EQUB &00, &6C, &44, &AC, &42, &1C, &1A, &3B
 EQUB &70, &19, &CE, &03, &EF, &1D, &71, &16
 EQUB &ED, &D3, &5D, &D1, &A9, &0B, &3F, &10
 EQUB &6A, &0B, &D7, &AD, &DB, &1B, &35, &2C
 EQUB &73, &FC, &AA, &55, &BC, &1F, &C7, &0D
 EQUB &68, &6B, &E6, &D9, &53, &04, &9B, &2C
 EQUB &70, &FC, &7A, &BB, &EA, &08, &9D, &25
 EQUB &ED, &91, &9B, &65, &7F, &06, &4D, &1E
 EQUB &42, &26, &1B, &75, &20, &25, &85, &17
 EQUB &00, &5E, &32, &78, &72, &15, &88, &1F
 EQUB &70, &D6, &87, &42, &EA, &17, &52, &2A
 EQUB &ED, &2A, &DB, &A9, &FE, &1A, &BD, &0C
 EQUB &6A, &A8, &E1, &0C, &BE, &27, &40, &21
 EQUB &73, &94, &EA, &AC, &BA, &21, &10, &08
 EQUB &40, &72, &6A, &4D, &82, &02, &61, &26
 EQUB &70, &A0, &F0, &07, &C9, &A8, &D0, &05
 EQUB &4E, &45, &25, &20, &50, &34, &60, &D0
 EQUB &09, &A5, &63, &20, &10, &46, &10, &02
 EQUB &C6, &77, &0A, &26, &77, &60, &77, &60
 EQUB &00, &00, &D8, &28, &33, &03, &0C, &00

\ &5A00

 EQUB &22, &18, &00, &01, &01, &00, &68, &00
 EQUB &68, &50, &40, &35, &2C, &A1, &00, &A1
 EQUB &7D, &63, &52, &45, &86, &92, &98, &03
 EQUB &21, &5D, &00, &20, &7F, &55, &4C, &72
 EQUB &54, &00

.CallTrackHook

 JMP &5700

.trackChecksum

 EQUB &76, &D7, &7A, &5E

 EQUS "REVS"            \ Game name

 EQUS "Oulton Park"     \ Track name
 EQUB 13

 EQUB &72, &6B, &0D, &22, &20, &42, &52
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
\ Save OultonPark.bin
\
\ ******************************************************************************

SAVE "3-assembled-output/OultonPark.bin", CODE%, P%