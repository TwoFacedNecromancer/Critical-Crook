extends State

class_name ClimbingState

@export var air_state : State

@export var can_climb : bool = true

@export var jump_velocity : float = -300.0

func state_process(delta):
	character.velocity.y = 0
	
	if(not Input.is_action_pressed("grab") or not character.is_on_wall()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()

func jump():
	can_climb = false
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	
