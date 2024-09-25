extends State

class_name SlidingState

@export var ground_state : State


func state_process(delta):
	
	if(character.is_on_floor() and !Input.is_action_pressed("slide")):
		playback.travel("move")
		next_state = ground_state
