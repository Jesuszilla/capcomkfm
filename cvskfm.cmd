; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional)
;   buffer.time = time (optional)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas. Each of these
;   buttons or directions is referred to as a "symbol".
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   greater-than (>) - means there must be no other keys pressed or released
;                      between the previous and the current symbol.
;          egs. command = a, >~a   ;press a and release it without having hit
;                                  ;or released any other keys in between
;   You can combine the symbols:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;
;   Note: Successive direction symbols are always expanded in a manner similar
;         to this example:
;           command = F, F
;         is expanded when MUGEN reads it, to become equivalent to:
;           command = F, >~F, >F
;
;   It is recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This makes the command easier
;   to do.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. The default
;   value for this is set in the [Defaults] section below. A typical
;   value is 15.
;
; - buffer.time (optional)
;   Time that the command will be buffered for. If the command is done
;   successfully, then it will be valid for this time. The simplest
;   case is to set this to 1. That means that the command is valid
;   only in the same tick it is performed. With a higher value, such
;   as 3 or 4, you can get a "looser" feel to the command. The result
;   is that combos can become easier to do because you can perform
;   the command early. Attacks just as you regain control (eg. from
;   getting up) also become easier to do. The side effect of this is
;   that the command is continuously asserted, so it will seem as if
;   you had performed the move rapidly in succession during the valid
;   time. To understand this, try setting buffer.time to 30 and hit
;   a fast attack, such as KFM's light punch.
;   The default value for this is set in the [Defaults] section below.
;   This parameter does not affect hold-only commands (eg. /F). It
;   will be assumed to be 1 for those commands.
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10


;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15
; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1

[Command]
name = "back"
command = B
time = 1

[Command]
name = "upfwd"
command = UF
time = 1

[Command]
name = "upback"
command = UB
time = 1

[Command]
name = "downback"
command = DB
time = 1

[Command]
name = "downfwd"
command = DF
time = 1

[Command]
name = "parry"
command = F
time = 1

[Command]
name = "parry2"
command = D
time = 1

[Command]
name = "rich"  ; REQUIRED for command buffering
command = U
time = 1

[Command]
name = "up"
command = U
time = 3

[Command]
name = "down"
command = D
time = 3

[Command]
name = "down2" ; REQUIRED for command buffering
command = $D
time = 1

;-| Hold Button |--------------------------------------------------------------
[Command]
name = "hold_x"
command = /x
time = 1

[Command]
name = "hold_y"
command = /y
time = 1

[Command]
name = "hold_z"
command = /z
time = 1

[Command]
name = "hold_a"
command = /a
time = 1

[Command]
name = "hold_b"
command = /b
time = 1

[Command]
name = "hold_c"
command = /c
time = 1

[Command]
name = "hold_start"
command = /s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd" ;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holddown" ;Required (do not remove)
command = /$D
time = 1

[Command]
name = "holdback" ;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holdfwd_r" ; Raw hold forward (REQUIRED for command buffering)
command = /F
time = 1
[Command]
name = "holddown_r" ; Raw hold forward (REQUIRED for command buffering)
command = /D
time = 1
[Command]
name = "holdback_r" ; Raw hold forward (REQUIRED for command buffering)
command = /B
time = 1
[Command]
name = "holdup_r" ; Raw hold forward (REQUIRED for command buffering)
command = /U
time = 1

;-| Release Dir |-----------------------------------------------------------
[Command]
name = "release_fwd"
command = ~F
time = 1

[Command]
name = "release_down"
command = ~D
time = 1

[Command]
name = "release_back"
command = ~B
time = 1

[Command]
name = "release_up"
command = ~U
time = 1

;-| Release Button |---------------------------------------------------------
[Command]
name = "release_a"
command = ~a
time = 1

[Command]
name = "release_b"
command = ~b
time = 1

[Command]
name = "release_c"
command = ~c
time = 1

[Command]
name = "release_x"
command = ~x
time = 1

[Command]
name = "release_y"
command = ~y
time = 1

[Command]
name = "release_z"
command = ~z
time = 1

[Command]
name = "release_start"
command = ~s
time = 1

;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]

;===========================================================================
;---------------------------------------------------------------------------
;Smash Kung Fu Upper (uses one super bar)
;[State -1, Smash Kung Fu Upper]
;type = ChangeState
;value = 3050
;triggerall = command = "SmashKFUpper"
;triggerall = power >= 1000
;triggerall = statetype != A
;trigger1 = ctrl
;trigger2 = hitdefattr = SC, NA, SA, HA
;trigger2 = stateno != [3050,3100)
;trigger2 = movecontact
;trigger3 = stateno = 1310 || stateno = 1330 ;From blocking

;---------------------------------------------------------------------------
;Triple Kung Fu Palm (uses one super bar)
;[State -1, Triple Kung Fu Palm]
;type = ChangeState
;value = 3000
;triggerall = command = "TripleKFPalm"
;triggerall = power >= 1000
;trigger1 = statetype = S
;trigger1 = ctrl
;trigger2 = statetype != A
;trigger2 = hitdefattr = SC, NA, SA, HA
;trigger2 = stateno != [3000,3050)
;trigger2 = movecontact
;trigger3 = stateno = 1310 || stateno = 1330 ;From blocking


;===========================================================================
;This is not a move, but it sets up var(1) to be 1 if conditions are right
;for a combo into a special move (used below).
;Since a lot of special moves rely on the same conditions, this reduces
;redundant logic.
[State -1, Combo condition Reset]
type = VarSet
trigger1 = 1
var(1) = 0

[State -1, Combo condition Check]
type = VarSet
triggerall = !IsHelper
trigger1 = statetype != A
trigger1 = ctrl
trigger2 = (stateno = [200,299]) || (stateno = [400,499])
trigger2 = stateno != 440 ;Except for sweep kick
trigger2 = movecontact
trigger3 = stateno = 1310 || stateno = 1330 ;From blocking
var(1) = 1

;---------------------------------------------------------------------------
; Strength Variable
[State -1, Strength]
type = VarSet
trigger1 = NumHelper(10371)
; Corresponds to the following:
; var(22) = cond(command="y" || command="release_y" || command = "b" || command = "release_b", 1, 0)
var(22) = cond(helper(10371), Var(1) || helper(10371), Var(8) || helper(10371), Var(4) || helper(10371), Var(11), 1, 0)

;---------------------------------------------------------------------------
; Kung Fu Knee
[State -1, Kung Fu Knee]
type = ChangeState
value = 1050+Var(22)*10
triggerall = NumHelper(10371)
; Corresponds to command = "FF"
triggerall = helper(10371), Var(55)
triggerall = helper(10371), Var(3) || helper(10371), Var(4) || helper(10371), Var(10) || helper(10371), Var(11)
trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Strong Kung Fu Palm
[State -1, Strong Kung Fu Palm]
type = ChangeState
value = 1000+Var(22)*10
triggerall = NumHelper(10371)
; Corresponds to command = "QCF"
triggerall = (helper(10371), Var(21)&(2**7 - 1)) > (2**6)
; Corresponds to command = "x" || command = "y" || command = "release_x" || command = "release_y"
triggerall = helper(10371), Var(0) || helper(10371), Var(1) || helper(10371), Var(7) || helper(10371), Var(8)
trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Fast Kung Fu Upper (1/3 super bar)
;[State -1, Fast Kung Fu Upper]
;type = ChangeState
;value = 1120
;triggerall = command = "upper_xy"
;triggerall = power >= 330
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Light Kung Fu Upper
;[State -1, Light Kung Fu Upper]
;type = ChangeState
;value = 1100
;triggerall = command = "upper_x"
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Strong Kung Fu Upper
;[State -1, Strong Kung Fu Upper]
;type = ChangeState
;value = 1110
;triggerall = command = "upper_y"
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Fast Kung Fu Blow (1/3 super bar)
;[State -1, Fast Kung Fu Blow]
;type = ChangeState
;value = 1220
;triggerall = command = "QCB_xy"
;triggerall = power >= 330
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Light Kung Fu Blow
;[State -1, Light Kung Fu Blow]
;type = ChangeState
;value = 1200
;triggerall = command = "QCB_x"
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Strong Kung Fu Blow
;[State -1, Strong Kung Fu Blow]
;type = ChangeState
;value = 1210
;triggerall = command = "QCB_y"
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;High Kung Fu Blocking (High)
;[State -1, High Kung Fu Blocking High]
;type = ChangeState
;value = 1300
;triggerall = command = "blocking"
;triggerall = command != "holddown"
;trigger1 = ctrl
;trigger1 = statetype != A
;trigger2 = stateno = 1310 || stateno = 1330
;trigger2 = time > 0

;---------------------------------------------------------------------------
;High Kung Fu Blocking (Low)
;[State -1, High Kung Fu Blocking Low]
;type = ChangeState
;value = 1320
;triggerall = command = "blocking"
;triggerall = command = "holddown"
;trigger1 = ctrl
;trigger1 = statetype != A
;trigger2 = stateno = 1310 || stateno = 1330
;trigger2 = time > 0

;---------------------------------------------------------------------------
;High Kung Fu Blocking (Air)
;[State -1, High Kung Fu Blocking Low]
;type = ChangeState
;value = 1340
;triggerall = command = "blocking"
;triggerall = command != "holdup"
;triggerall = command != "holddown"
;trigger1 = ctrl
;trigger1 = statetype = A
;trigger2 = stateno = 1350
;trigger2 = time > 0

;---------------------------------------------------------------------------
;Far Kung Fu Zankou
;[State -1, Far Kung Fu Zankou]
;type = ChangeState
;value = 1420
;triggerall = command = "QCF_ab"
;triggerall = power >= 330
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Light Kung Fu Zankou
;[State -1, Light Kung Fu Zankou]
;type = ChangeState
;value = 1400
;triggerall = command = "QCF_a"
;trigger1 = var(1) ;Use combo condition (above)

;---------------------------------------------------------------------------
;Strong Kung Fu Zankou
;[State -1, Strong Kung Fu Zankou]
;type = ChangeState
;value = 1410
;triggerall = command = "QCF_b"
;trigger1 = var(1) ;Use combo condition (above)

;===========================================================================
;---------------------------------------------------------------------------
;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = numHelper(10371)
trigger1 = helper(10371), Var(55) = [1,3]
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Run Back
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = numHelper(10371)
trigger1 = helper(10371), Var(56) = [1,3]
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Kung Fu Throw
[State -1, Kung Fu Throw]
type = ChangeState
value = 800
triggerall = command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = stateno != 100
trigger1 = command = "holdfwd"
trigger1 = p2bodydist X < 3
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H
trigger2 = command = "holdback"
trigger2 = p2bodydist X < 5
trigger2 = (p2statetype = S) || (p2statetype = C)
trigger2 = p2movetype != H

;---------------------------------------------------------------------------
;Taunt
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = numHelper(10371)
triggerall = helper(10371), var(6)
trigger1 = statetype != A
trigger1 = ctrl
;1trigger2 = var(1)

;===========================================================================
;---------------------------------------------------------------------------
;Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 240
triggerall = numHelper(10371)
triggerall = helper(10371), var(4)
triggerall = helper(10371), command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;---------------------------------------------------------------------------
;Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 210
triggerall = !IsHelper
triggerall = numHelper(10371)
triggerall = helper(10371), var(1)
triggerall = helper(10371), command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 5
trigger3 = (stateno = 230) && time > 6

;---------------------------------------------------------------------------
;Stand Light Kick
[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = numHelper(10371)
triggerall = helper(10371), var(3)
triggerall = helper(10371), command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = (stateno = 200) && time > 7
trigger3 = (stateno = 230) && time > 9

;---------------------------------------------------------------------------
;Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = numHelper(10371)
triggerall = helper(10371), var(0)
triggerall = helper(10371), command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl
trigger2 = stateno = 200
trigger2 = time > 6

;---------------------------------------------------------------------------
;Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = numHelper(10371)
triggerall = helper(10371), var(4)
triggerall = helper(10371), command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) || (stateno = 430)
trigger2 = (time > 9) || (movecontact && time > 5)

;---------------------------------------------------------------------------
;Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = numHelper(10371)
triggerall = helper(10371), var(1)
triggerall = helper(10371), command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) || (stateno = 430)
trigger2 = (time > 9) || (movecontact && time > 5)

;---------------------------------------------------------------------------
;Crouching Light Kick
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = numHelper(10371)
triggerall = helper(10371), var(3)
triggerall = helper(10371), command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl
trigger2 = (stateno = 400) || (stateno = 430)
trigger2 = (time > 9) || (movecontact && time > 5)

;---------------------------------------------------------------------------
;Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = numHelper(10371)
triggerall = helper(10371), var(0)
triggerall = helper(10371), command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
;Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 640
triggerall = numHelper(10371)
triggerall = helper(10371), var(4)
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600 || stateno = 630 ;jump_x or jump_a
trigger2 = movecontact
trigger3 = stateno = 1350 ;Air blocking

;---------------------------------------------------------------------------
;Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
triggerall = numHelper(10371)
triggerall = helper(10371), var(1)
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600 || stateno = 630 ;jump_x or jump_a
trigger2 = movecontact
trigger3 = stateno = 1350 ;Air blocking

;---------------------------------------------------------------------------
;Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 6302
triggerall = numHelper(10371)
triggerall = helper(10371), var(3)
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 1350 ;Air blocking

;---------------------------------------------------------------------------
;Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = numHelper(10371)
triggerall = helper(10371), var(0)
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno = 600
trigger2 = time >= 7
trigger3 = stateno = 1350 ;Air blocking