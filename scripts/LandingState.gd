extends State

class_name LandingState

#sets up state nodes
@export var ground_state : State
@export var air_state : State
@export var sliding_state : State

#gets hotboxes
@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")

#used for jumping
@export var jump_velocity : float = -250.0

#used for determining how large the landing window is
var timer : float = 0.4

#processed every frame
func state_process(delta):
	if(character.is_on_floor()):
		
		#jumps if jump is prepped
		if air_state.jump_prep == true or Input.is_action_just_pressed("jump"):
			timer = 1
			jump()
		
		#slides or exits landing state if timer runs out
		else:
			if(Input.is_action_just_pressed("slide")):
				hitbox.disabled = true
				slidebox.disabled = false
				timer = 1
				next_state = sliding_state
				playback.travel("sliding")
		
			if(timer <= 0 ):
				timer = 1
				get_parent().get_parent().speed_boost = 0
				playback.travel("move")
				next_state = ground_state
				get_parent().get_parent().speed_boost = 0
			else:
				timer -= 0.1
		
#jump function
func jump():
	get_parent().get_parent().speed_boost = 0
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
