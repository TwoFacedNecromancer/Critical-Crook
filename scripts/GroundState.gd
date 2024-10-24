extends State

class_name GroundState

#sets jump velocity
@export var jump_velocity : float = -250.0

#sets which nodes are air and sliding states
@export var air_state : State
@export var sliding_state : State
@export var death_state : State

var can_jump : bool = true
var can_slide : bool = true

#sets which animation is used for jump
@export var jump_animation : String = "jump_start"

#used to swap between sliding hitbox and normal hitbox 
@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")

#processed every frame
func state_process(delta):
	
	if get_parent().get_parent().isdead==true:
		next_state = death_state
		return

	#sets how long you can slide for
	sliding_state.timer = 4.0
	
	#moves to air state if not on floor
	if(!character.is_on_floor()):
		playback.travel("jump_start")
		next_state = air_state
		
	if(Input.is_action_pressed("jump")):
		jump()
	else:
		can_jump = true
	#speed boost if jumping from a slide
	if(Input.is_action_pressed("slide") and get_parent().get_parent().isdead==false):
		if(character.velocity.x != 0):
			slide()
	else:
		can_slide = true

#jump function
func jump():
	if(can_jump == true):
		can_jump = false
		character.velocity.y = jump_velocity
		next_state = air_state
		playback.travel("jump_start")
	
#slide function
func slide():
	if(can_slide == true):
		can_slide = false
		slidebox.disabled = false
		hitbox.disabled = true
		next_state = sliding_state
		playback.travel("sliding")
