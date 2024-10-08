extends State

class_name SlidingState

@export var ground_state : State
@export var air_state : State
@export var jump_velocity : float = -200.0

@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")

var timer : float = 4.0


func state_process(delta):
	
	timer -= 0.1
	if((character.is_on_floor() and !Input.is_action_pressed("slide")) or timer <= 0):
		hitbox.disabled = false
		slidebox.disabled = true
		playback.travel("move")
		next_state = ground_state
		get_parent().get_parent().speed_boost = 0
		
	if(not character.is_on_floor()):
		hitbox.disabled = false
		slidebox.disabled = true
		playback.travel("jump_start")
		next_state = air_state
		
	if(character.is_on_floor() and Input.is_action_pressed("jump")):
		hitbox.disabled = false
		slidebox.disabled = true
		character.speed_boost += 50.0
		jump()

func jump():
	timer = 4.0
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
