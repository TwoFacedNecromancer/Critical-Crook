extends State

class_name AirState

@export var landing_state : State

func state_process(delta):
	if(character.is_on_floor()):
		next_state = landing_state
