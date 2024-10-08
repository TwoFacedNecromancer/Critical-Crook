extends State

class_name LandingState

@export var ground_state : State
@export var air_state : State
@export var sliding_state : State

@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")

@export var jump_velocity : float = -200.0

var timer : float = 0.4

func state_process(delta):
	
	if(character.is_on_floor()):
		
		if air_state.jump_prep == true or Input.is_action_just_pressed("jump"):
			timer = 1
			jump()
		else:
			if(Input.is_action_just_pressed("slide")):
				hitbox.disabled = true
				slidebox.disabled = false
				timer = 1
				next_state = sliding_state
				playback.travel("sliding")
		
			if(timer <= 0 ):
				timer = 1
				playback.travel("move")
				next_state = ground_state
				get_parent().get_parent().speed_boost = 0
			else:
				timer -= 0.1
		
					
func jump():
	get_parent().get_parent().speed_boost = 0
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
