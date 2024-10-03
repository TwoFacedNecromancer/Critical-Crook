extends State

class_name SlidingState

@export var ground_state : State
@export var air_state : State
@export var jump_velocity : float = -300.0

var timer : float = 4.0


func state_process(delta):
	
	timer -= 0.1
	if((character.is_on_floor() and !Input.is_action_pressed("slide")) or timer <= 0):
		playback.travel("move")
		next_state = ground_state
	if(character.is_on_floor() and Input.is_action_pressed("jump")):
		character.speed_boost += 100.0
		jump()

func jump():
	timer = 4.0
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
