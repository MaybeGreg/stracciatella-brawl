###########################################
CSS Selections Preserved in VS Mode [Magus]
###########################################
op b 0x3C @ $806DCA90

#############################
CSS Record Display Fix [ds22]
#############################
HOOK @ $8068DBCC
{
  cmpwi r29, 0x28
  beq- %END%
  cmpwi r29, 0x29
}
op beq- 0x3C @ $8068DBD0

#################################################################################
Pick Any Color You Want Fix.Ver (RSBE.Ver) [original by Igglyboo , Fixed by JOJI]
#################################################################################
* 0469A2B4 380000FF
* 0469A3C4 380000FF
* 04696FD4 380000FF
* 04684E84 380000FF

#############################
!No C-stick menu tilting [Eon]
#############################
* 040A67B8 48000034
* 040A682C 48000034

###################################################################################################
BrawlEX Hold Shield Rewrite v4 Clone Fix 242 Variant [codes, ChaseMcDizzle, HyperL!nk, PyotrLuzhin, ds22, Desi, RedipsTheCooler] Added SFX by MarioDox [based on PMDT]
###################################################################################################
#Changes from previous version:
#	1. Table no longer occupies memory outside the GCT
#	2. Go to SSS no longer users a counter
#	3. Added CSS Type Code menu check to avoid bugs when returning + audio cue when performed
op nop @ $806847B8
op nop @ $806847BC
op b 0x8 @ $806847C0

HOOK @ $80685BE4        #Return to CSS (Restore the original CharacterID)
{
  lis r14, 0x804E		#\
  ori r14, r14, 0x0A23	#|	Check for Code Menu CSS Type option
  lbz r14, 0x0(r14)	#|
  cmpwi r14, 2		#/	Disable function if it's "L-Load Only"
  beq- Hook
  li r12, 0x0           #Start Counter
  bl 0x4                #Set current code location in Link Register 
  mflr r4               #Move Link Register to R4
  addi r4, r4, 0x8C     #Set r4 to Shield Rewrite Data Address
IDCheckLoop:
  lbz r3, 0(r4)         #Load Shield Rewrite Data
  cmpwi r12, 0xF2       #If out of range, End the code
  beq- Hook
  cmpw r3, r5           #Compare Shield Rewrite ID to Counter ID
  beq- RestoreID        #If the Shield Rewrite Data matches the CharacterID, the Counter in r12 is used to restore
  addi r12, r12, 0x1    #Add 1 to Counter
  addi r4, r4, 0x1      #Add 1 to Shield Rewrite Data Address
  b IDCheckLoop

RestoreID:
  mr r5, r12

Hook:
    li r14, 0x0		#Reset value used for code menu check to 0, to avoid jank
  stw r5, 60(r1)        #Implied to be original function
}

HOOK @ $8068482C        #Go to SSS (This occurs only while holding L)
{
  cmpwi r29, 0xF2       #Safety Check
  bge- %END%
  bl 0x4                #Set current code location in Link Register 
  mr r3, r29		#Save base SlotID
  mflr r4
  addi r4, r4, 0x3c     #Set r4 to Shield Rewrite Data Address
  lbzx r29, r29, r4     #Load Rewrite Data based on CharacterID
  cmpw r3, r29		#Check if it's any different from base
  beq- %END%
  lis r3, 0x805A			# \
  li r4, 0x26 			# | Play SFX 24 (Menu 15)
  lis r12, 0x806A			# |
  ori r12, r12, 0x83F4		# |
  mtctr r12				# |
  bctrl				# /
}
##########################################
#Shield Rewrite Data
#To use, replace the CSSSlot ID with the character you want to be shield loaded. 
#For example, Bowser (0xC) was replaced with Giga Bowser(0x30). 
#In the commented section, this is indicated by placing GKoopa in parenthesis behind bowser.
#Note that replacing an ID with one lower than it can cause issues with the L-Load CSP Code.
#http://opensa.dantarion.com/wiki/CSS_Slots
##########################################
.GOTO->Table_Skip
	byte[242] |
0xA1, 0xA6, 0x02, 0xA5,  | # Mario, Donkey Kong, Link, Samus
0x80, 0x05, 0x06, 0x07,  | # Zero Suit Samus, Yoshi, Kirby, Fox
0x08, 0x09, 0x0A, 0x0B,  | # Pikachu, Luigi, Captain Falcon, Ness
0x30, 0x0D, 0x0E, 0x0F,  | # Bowser, Peach, Zelda, Sheik
0x37, 0x11, 0x12, 0xA7,  | # Ice Climbers, Marth, Mr. Game & Watch, Falco
0xA4, 0x35, 0x9B, 0x17,  | # Ganondorf, Wario, Meta Knight, Pit
0x18, 0xA8, 0x1A, 0x1B,  | # Olimar, Lucas, Diddy Kong, Unknown
0x94, 0x1D, 0x1E, 0x1F,  | # Charizard, Squirtle, Ivysaur, King Dedede
0xA3, 0x21, 0x22, 0x9C,  | # Lucario, Ike, R.O.B., Jigglypuff
0x24, 0x88, 0x26, 0x8A,  | # Toon Link, Wolf, Snake, Sonic
0x28, 0x29, 0x2A, 0x2B,  | # Unknown, Unknown, Lyn, Unknown
0x2C, 0x95, 0x9F, 0x2F,  | # Unknown, Roy, Mewtwo, Knuckles
0x30, 0x31, 0x32, 0x33,  | # Giga Bowser, Mega Man X, Ridley, Waluigi
0x34, 0x35, 0x36, 0x37,  | # Isaac, Wario, Unknown, Unknown
0x38, 0x39, 0x3A, 0x3B,  | # Red Alloy, Blue Alloy, Yellow Alloy, Green Alloy
0x3C, 0x3D, 0x3E, 0x3F,  | # Unknown, Sami, Dr. Mario, Young Link
0xC4, 0x41, 0x42, 0x43,  | # Dark Samus, Pichu, Metal Sonic, Bomberman
0x44, 0x45, 0x46, 0x47,  | # Big Boss, Ken, Phantom Ganon, Blood Falcon
0x48, 0x49, 0x4A, 0x84,  | # Unknown, Unknown, Unknown, Lucina
0x4C, 0xBD, 0x4E, 0x4F,  | # Dr. Luigi, Shadow, Nu-13, Cloud
0x50, 0x51, 0x52, 0x53,  | # Dark Pit, Sukapon, Ryu, Ninten
0x99, 0x55, 0x56, 0x57,  | # Dry Bowser, Geno, Elizabeth, Navarre
0x58, 0xAD, 0x5A, 0x5B,  | # Alph, Chrom, Shulk, Yu Narukami
0x5C, 0x5D, 0x5E, 0x5F,  | # Squall, Toon Zelda, Daisy, Knuckle Joe
0x60, 0x61, 0x62, 0x63,  | # Louie, Corrin, Sceptile, Little Mac
0x64, 0x65, 0x66, 0x67,  | # PAC-MAN, Toad, Blaziken, Zero
0x68, 0x69, 0x6A, 0x6B,  | # Black Knight, Masked Man, Red Alloy, Blue Alloy
0x6C, 0x6D, 0x6E, 0x6F,  | # Yellow Alloy, Green Alloy, Robin, Sans
0x70, 0x71, 0x72, 0x73,  | # Isabelle, Palutena, Zeraora, Tails
0x74, 0x75, 0x76, 0x77,  | # Bandana Dee, Sub-Zero, Sandbag, Simon
0x78, 0x79, 0x7A, 0x7B,  | # Richter, Black Shadow, Metal Face, Terry
0x7C, 0x7D, 0x7E, 0x7F,  | # Fierce Deity, Joker, VectorMan, Wii Fit Trainer
0x80, 0x81, 0x82, 0x83,  | # Zero Suit Samus, Robin, Corrin, Unknown
0x84, 0x85, 0x86, 0x87,  | # Lucina, Deathborn, Hero, Unknown
0x88, 0x89, 0x8A, 0x8B,  | # Wolf, Mythra, Super Sonic, Sephiroth
0x8C, 0x8D, 0x8E, 0x8F,  | # Kumatora, Unknown, Pyra, Unknown
0x90, 0x91, 0x92, 0x93,  | # Unknown, Banjo-Kazooie, Incineroar, Unknown
0x94, 0x95, 0x96, 0x97,  | # Mega Charizard X, Roy, Unknown, Zack
0x98, 0x99, 0x9A, 0x9B,  | # Unknown, Giga Dry Bowser, Bayonetta, Meta Knight
0x9C, 0x9D, 0x9E, 0x9F,  | # Big Jigglypuff, Silver, Unknown, Mega Mewtwo Y
0xA0, 0xA1, 0xA2, 0xA3,  | # Unknown, Metal Mario, Sora, Mega Lucario
0xA4, 0xA5, 0xA6, 0xA7,  | # Ganondorf, Suitless Samus, Giant D.K., Falco
0xA8, 0xA9, 0xAA, 0xAB,  | # Lucas, Wii Fit Trainer, Unknown, King K. Rool
0xAC, 0xAD, 0xAE, 0xAF,  | # Alucard, Chrom, Unknown, Unknown
0xB0, 0xB1, 0xB2, 0xB3,  | # Rock, Unknown, Unknown, Unknown
0xB4, 0xB5, 0xB6, 0xB7,  | # Unknown, Unknown, Unknown, Shovel Knight
0xB8, 0xB9, 0xBA, 0xBB,  | # Unknown, Unknown, Unknown, Kazuya Mishima
0xBC, 0xBD, 0xBE, 0xBF,  | # Unknown, Super Shadow, Unknown, Master Chief
0xC0, 0xC1, 0xC2, 0xC3,  | # Primid, Unknown, Unknown, Unknown
0xC4, 0xC5, 0xC6, 0xC7,  | # Dark Samus, Unknown, Unknown, Sol Badguy
0xC8, 0xC9, 0xCA, 0xCB,  | # Unknown, Unknown, Unknown, Unknown
0xCC, 0xCD, 0xCE, 0xCF,  | # Dragon King, Unknown, Unknown, Unknown
0xD0, 0xD1, 0xD2, 0xD3,  | # Unknown, Unknown, Unknown, Unknown
0xD4, 0xD5, 0xD6, 0xD7,  | # Unknown, Unknown, Unknown, Unknown
0xD8, 0xD9, 0xDA, 0xDB,  | # Unknown, Unknown, Unknown, Unknown
0xDC, 0xDD, 0xDE, 0xDF,  | # Unknown, Unknown, Unknown, Unknown
0xE0, 0xE1, 0xE2, 0xE3,  | # Unknown, Unknown, Unknown, Unknown
0xE4, 0xE5, 0xE6, 0xE7,  | # Unknown, Unknown, Unknown, Unknown
0xE8, 0xE9, 0xEA, 0xEB,  | # Unknown, Unknown, Unknown, Unknown
0xEC, 0xED, 0xEE, 0xEF,  | # Unknown, Unknown, Unknown, Unknown
0xF0, 0xF1 # Unknown, Unknown

Table_Skip: