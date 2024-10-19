extends State

class_name AirState

#sets nodes for each state
@export var landing_state : State
@export var climbing_state : State
@export var ground_state : State
@export var death_state : State

#used for prepping a jump
var jump_prep : bool = false
var timer : float = 2.0

#processed every frame
func state_process(delta):
	
	if get_parent().get_parent().isdead==true:
		next_state = death_state
	
	#preps a jump
	if Input.is_action_just_pressed("jump") and timer >= 0:
		jump_prep = true
	
	#defines how long of a window you can prep a jump in
	if jump_prep == true:
		timer -= 0.2
		if timer <= 0:
			jump_prep = false
			timer = 1.0
	
	if(character.is_on_floor()):
		#resets jump prep timer and ability to climb on impact with floor
		timer = 2.0
		climbing_state.can_climb = true
		
		#if you press slide too early you lose your speed boost and skip the landing state
		if(Input.is_action_pressed("slide")):
			get_parent().get_parent().speed_boost = 0
			playback.travel("move")
			next_state = ground_state
		
		#goes to landing state
		else:
			playback.travel("jump_end")
			next_state = landing_state
			
			
	#lets player grab a wall
	if(character.is_on_wall() and Input.is_action_pressed("grab") and climbing_state.can_climb == true):
		next_state = climbing_state
		playback.travel("climbing")
