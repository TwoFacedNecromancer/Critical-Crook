extends State

class_name LandingState

@export var ground_state : State
@export var air_state : State

@export var jump_velocity : float = -300.0

func state_process(delta):
	
	if(character.is_on_floor()):
		playback.travel("jump_end")
		if air_state.jump_prep == true or Input.is_action_just_pressed("jump"):
			character.velocity.y = jump_velocity
			next_state = air_state
		else:
			next_state = ground_state
