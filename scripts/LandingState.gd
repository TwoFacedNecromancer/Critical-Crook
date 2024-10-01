extends State

class_name LandingState

@export var ground_state : State
@export var air_state : State
@export var sliding_state : State

@export var jump_velocity : float = -300.0

var timer : float = 1.0

func state_process(delta):
	
	if(character.is_on_floor()):
		
		if(timer <= 0 ):
			timer = 1
			if (Input.is_action_pressed("slide")):
				next_state = sliding_state
			else:
				playback.travel("jump_end")
				if air_state.jump_prep == true or Input.is_action_just_pressed("jump"):
					character.velocity.y = jump_velocity
					next_state = air_state
				else:
					next_state = ground_state
					
		else:
			timer -= 0.1
