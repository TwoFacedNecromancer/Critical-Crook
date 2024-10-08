extends State

class_name GroundState


@export var jump_velocity : float = -200.0
@export var air_state : State
@export var sliding_state : State
@export var jump_animation : String = "jump_start"

@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")


func state_process(delta):
	

	sliding_state.timer = 4.0
	if(character.is_on_floor()):
		pass
	else:
		playback.travel("jump_start")
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	
	if(event.is_action_pressed("slide")):
		if(character.velocity.x != 0):
			slide()

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	

func slide():
	slidebox.disabled = false
	hitbox.disabled = true
	next_state = sliding_state
	playback.travel("sliding")
