extends State

class_name SlidingState

@export var ground_state : State
@export var air_state : State
@export var jump_velocity : float = -300.0


func state_process(delta):
	
	if(character.is_on_floor() and !Input.is_action_pressed("slide")):
		playback.travel("move")
		next_state = ground_state
	if(character.is_on_floor() and Input.is_action_pressed("jump")):
		jump()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
