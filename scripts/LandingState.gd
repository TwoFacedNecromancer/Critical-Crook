extends State

class_name LandingState

@export var ground_state : State


func state_process(delta):
	
	if(character.is_on_floor()):
		playback.travel("jump_end")
		next_state = ground_state
