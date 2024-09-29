extends State

class_name GroundState


@export var jump_velocity : float = -300.0
@export var air_state : State
@export var sliding_state : State
@export var jump_animation : String = "jump_start"

func state_process(delta):
	if air_state.jump_prep == true:
		jump()

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	
	if(event.is_action_pressed("slide")):
		slide()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	

func slide():
	next_state = sliding_state
	playback.travel("sliding")
