extends State

class_name GroundState

#sets jump velocity
@export var jump_velocity : float = -250.0

#sets which nodes are air and sliding states
@export var air_state : State
@export var sliding_state : State
@export var death_state : State

#sets which animation is used for jump
@export var jump_animation : String = "jump_start"

#used to swap between sliding hitbox and normal hitbox 
@onready var slidebox = get_parent().get_parent().find_child("slidebox")
@onready var hitbox = get_parent().get_parent().find_child("hitbox")

#processed every frame
func state_process(delta):
	
	if get_parent().get_parent().isdead==true:
		next_state = death_state
		

	#sets how long you can slide for
	sliding_state.timer = 4.0
	
	#moves to air state if not on floor
	if(!character.is_on_floor()):
		playback.travel("jump_start")
		next_state = air_state

#jump
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
	#speed boost if jumping from a slide
	if(event.is_action_pressed("slide")):
		if(character.velocity.x != 0):
			slide()

#jump function
func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	
#slide function
func slide():
	slidebox.disabled = false
	hitbox.disabled = true
	next_state = sliding_state
	playback.travel("sliding")
