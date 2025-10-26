#############################################################################################################
Boot Directly to CSS v5.3 (Hold Shield for Training, Z for Target Smash) [PyotrLuzhin, SammiHusky, QuickLava]
# v5.2 - Added Hold Z to Boot to Target Smash!
#      - The port which triggers the code now properly controls the CSS upon arrival.
# v5.3 - Wiimote-based controllers properly get control of CSS when special inputs are activated.
#      - First comments pass.
#############################################################################################################
HOOK @ $806DD5F8
{
    li r11, 0                            # Initialize port ID iterator for coming loop.
    LOOP_START:
        lis r12, 0x805B                  # \ 
        ori r12, r12, 0xa684             # / Set up base pointer to input masks.
                                         
    GAMECUBE:                          
    li r10, 0x00                     # Set controller type offset to 0x00, for GCC.       
        mulli r4, r11, 0x40              # Multiply port ID by 0x40 to index to the desired input data.
        lwzx r0, r12, r4                 # Load current button mask.
        rlwinm. r5, r0, 0, 25, 26        # If R or L pressed...
        bne boot_training                # ... boot to Training.
        rlwinm. r5, r0, 0, 27, 27        # Otherwise, if Z pressed...
        bne boot_targets                 # ... boot to Target Smash.
                                         
    WIIMOTE_CHECK_SUBTYPE:                          
    li r10, 0x04                     # Set controller type offset to 0x04, for Wiimote based controllers.                      
        addi r12, r12, 0x100             # Push forwards to Wii Controller data?
        lwz r4, 0x3c(r12)                # Grab controller type.
        cmpwi r4, 3                      # If 3...
        beq WIICHUCK                     # skip down to Wiimote + Nunchuck section.
        mulli r4, r11, 0x40              # Otherwise, once again get offset to desired port's inputs...
        lwzx r0, r12, r4                 # ... and load its button mask.
        rlwinm. r0, r0, 0, 25, 26        # If R or L pressed...
        bne boot_training                # ... boot to Training.
        b LOOP_BACK                      # Otherwise, skip past the WiiChuck bit and prepare to loop again.
    WIICHUCK:                            
        mulli r4, r11, 0x40              # Get offset to desired port inputs...
        lwzx r0, r12, r4                 # ... load its button mask.
        rlwinm. r0, r0, 0, 27, 27        # If Z is pressed ...
        bne boot_training                # ... boot to Training.
    LOOP_BACK:                           
        addi r11, r11, 1                 # Add 1 to the current port number...
        cmpwi r11, 4                     # ... compare that against 4...
        blt LOOP_START                   # ... and if it's less than that there're still controllers to check, continue loop.
                                         
    boot_vs:                             # If we've checked every port and found no special mode input...
        addi r4, r21, 0x1B54             # ... then redirect r4 to "sqVsMelee" @ $80701B54 instead of "sqBoot".
        li r5, 0                         # Zero r5...
        b %END%                          # ... and exit.
                                         
    boot_training:                       #
        addi r4, r20, -0x3f0             # Redirect r4 to "sqTraining" @ $80701870 instead of "sqBoot".
        b set_active_controller          # Skip down to setting active controller.
        
    boot_targets:
        addi r4, r20, -0x418             # Redirect r4 to "sqTargetBreak" @ $80701848 instead of "sqBoot".
        
    set_active_controller:
        lwz r12, -0x4340(r13)            # Get pointer to g_GameGlobal...
        lwz r12, 0x1C(r12)               # ... then gmSetRule.
add r10, r11, r10                # Add controller type offset to the current port ID so Wiimote Controller IDs line up correctly...
        stw r10, 0x24(r12)               # ... then write that ID over the spot read by gmGetMenuDecisionPad so it'll control CSS!
il r5, 0                         # Zero r5 before exiting.
}
HOOK @ $8002D3A0
{
  mr r4, r27
  lis r5, 0x8042;    ori r5, r5, 0xA40
  cmpw r4, r5;        bne- %END%
  li r5, 0x3
  stb r5, 0x2A5(r28);    stb r5, 0x2B1(r28)
  li r30, 0x0
}
op b 0x10 @ $80078E14
op nop    @ $806DD5FC