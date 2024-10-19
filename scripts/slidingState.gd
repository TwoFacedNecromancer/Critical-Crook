extends State

class_name SlidingState

#gets state nodes
@export var ground_state : State
@export var air_state : State
@export var death_state : State

#used for jumping
@export var jump_velocity : float = -250.0

#gets hitboxes
@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")
@onready var detector = get_parent().get_parent().find_child("detector")

#used to define how long you can slide for
var timer : float = 4.0

#used to check if character is in a tunnel
var overlap : bool

#processed each frame
func state_process(delta):
	
	#ticks timer
	timer -= 0.1
	
	
	if get_parent().get_parent().isdead==true:
		next_state = death_state


	#ends slide
	if((character.is_on_floor() and !Input.is_action_pressed("slide")) or timer <= 0):
		if(overlap == false):
			hitbox.disabled = false
			slidebox.disabled = true
			playback.travel("move")
			next_state = ground_state
			get_parent().get_parent().speed_boost = 0

	#moves to air state if not on floor
	if(not character.is_on_floor()):
		hitbox.disabled = false
		slidebox.disabled = true
		playback.travel("jump_start")
		next_state = air_state
	
	#jumps
	if(character.is_on_floor() and Input.is_action_pressed("jump")):
		if(overlap == false):
			hitbox.disabled = false
			slidebox.disabled = true
			character.speed_boost += 50.0
			jump()

#jump function
func jump():
	timer = 4.0
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")


#updates the overlap variable
func _on_detector_body_entered(body: Node2D) -> void:
	overlap = true

func _on_detector_body_exited(body: Node2D) -> void:
	overlap = false
