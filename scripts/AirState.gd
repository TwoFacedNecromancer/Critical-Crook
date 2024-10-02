extends State

class_name AirState

@export var landing_state : State
@export var climbing_state : State
@export var ground_state : State
@export var jump_velocity : float = -300.0
var jump_prep : bool = false

var timer : float = 1.0
var timer2 : float = 1.0

func state_process(delta):
	
	if (Input.is_action_pressed("jump")):
		character.velocity.y -= 5
	
	if Input.is_action_just_pressed("jump") and timer >= 0:
		jump_prep = true
	
	if jump_prep == true:
		timer -= 0.2
		if timer <= 0:
			jump_prep = false
			timer = 1.0
	
	if(character.is_on_floor()):
		climbing_state.can_climb = true
		if(Input.is_action_pressed("slide")):
			playback.travel("move")
			next_state = ground_state
		else:
			next_state = landing_state
	if(character.is_on_wall() and Input.is_action_pressed("grab") and climbing_state.can_climb == true):
		next_state = climbing_state
