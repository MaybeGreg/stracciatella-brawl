Stage Select Screen Table Data

.BA<-TABLE_STAGES
.BA->$80495D00
.BA<-TABLE_1
.BA->$80495D04
.BA<-TABLE_2
.BA->$80495D08
.BA<-TABLE_3
.BA->$80495D0C
.BA<-TABLE_4
.BA->$80495D10
.BA<-TABLE_5
.BA->$80495D14
.GOTO->SkipStageTables

TABLE_1:
	byte[13] |
0x00, | # Battlefield
0x01, | # Final Destination
0x02, | # Delfino Plaza
0x0F, | # Pokémon Stadium 2
0x1A, | # Smashville
0x0C, | # Yoshi's Island (Brawl)
0x31, | # The Pit
0x2C, | # Snowman's Land
0x2D, | # Wario Land
0x2E, | # Firgate Husk
0x2F, | # Green Hill Zone P+
0x30, | # Metal Cavern
0x32  | # Odeo Town

TABLE_2:
	byte[14] |
0x09, | # Bridge of Eldin
0x0A, | # Norfair
0x0B, | # Frigate Orpheon
0x0D, | # Halberd
0x0E, | # Lylat Cruise
0x14, | # Castle Siege
0x15, | # WarioWare, Inc.
0x17, | # Skyworld
0x1D, | # Pictochat
0x20, | # Yoshi's Story
0x21, | # Jungle Japes
0x25, | # Corneria
0x23, | # Green Greens
0x28  | # Pokémon Stadium

TABLE_3:
	byte[21] |
0x03, | # Luigi's Mansion
0x04, | # Mushroomy Kingdom
0x05, | # Mario Circuit
0x07, | # Rumble Falls
0x08, | # Pirate Ship
0x10, | # Spear Pillar
0x11, | # Port Town Aero Dive
0x16, | # Distant Planet
0x19, | # New Pork City
0x12, | # Summit
0x06, | # 75m
0x18, | # Mario Bros.
0x13, | # Flat Zone 2
0x1E, | # Hanenbow
0x1B, | # Shadow Moses Island
0x1C, | # Green Hill Zone
0x1F, | # Temple
0x22, | # Onett
0x24, | # Rainbow Cruise
0x26, | # Big Blue
0x27, | # Brinstar

TABLE_4:	# Unused
TABLE_5:	# Unused

TABLE_STAGES:
# Table of icon<->stage slot associations
half[51] |	# Stage Count + 2
| # OLD SLOTS
0x0101, 0x0202, 0x0303, 0x0404, | # Battlefield, Final Destination, Delfino Plaza, Luigi's Mansion
0x0505, 0x0606, 0x0707, 0x0808, | # Mushroomy Kingdom, Mario Circuit, 75m, Rumble Falls
0x0909, 0x330A, 0x0B0B, 0x0C0C, | # Pirate Ship, Bridge of Eldin, Norfair, Frigate Orpheon
0x0D0D, 0x0E0E, 0x130F, 0x1410, | # Yoshi's Island (Brawl), Halberd, Lylat Cruise, Pokémon Stadium 3
0x1511, 0x1612, 0x1713, 0x1814, | # Spear Pillar, Port Town Aero Dive, Summit, Flat Zone 2
0x1915, 0x1C16, 0x1D17, 0x1E18, | # Castle Siege, WarioWare Inc., Distant Planet, Skyworld
0x1F19, 0x201A, 0x211B, 0x221C, | # Mario Bros., New Pork City, Smashville, Shadow Moses Island
0x231D, 0x241E, 0x251F, 0x2932, | # Green Hill Zone, Pictochat, Hanenbow, Temple
0x2A33, 0x2B34, 0x2C35, 0x2D36, | # Yoshi's Story (Melee), Jungle Japes, Onett, Green Greens
0x2F37, 0x3038, 0x3139, 0x323A, | # Rainbow Cruise, Corneria, Big Blue, Brinstar
0x2E3B, 0xFF64, 0xFF64, 0x373C, | # Pokemon Stadium 2, NOTHING, NOTHING, Training Room
| # NEW SLOTS
0x4023, 0x4124, 0x4225, 0x4326, | # Snowman's Land, Wario Land, Firgate Husk, Green Hill Zone P+
0x4427, 0x4528, 0x4629          | # Metal Cavern, The Pit, Odeo Town



SkipStageTables:
.RESET

byte 13 @ $806B929C # Page 1
byte 14 @ $806B92A4 # Page 2
byte 21 @ $80496002 # Page 3
byte 00 @ $80496003 # Page 4 (Unused)
byte 00 @ $80496004 # Page 5 (Unused)
byte 49 @ $800AF673 # Stage Count