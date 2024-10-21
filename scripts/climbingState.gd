extends State

class_name ClimbingState

#defines what node is the air state
@export var air_state : State
@export var death_state : State

#used to prevent infinite climbing
@export var can_climb : bool = true

#used to jump
@export var jump_velocity : float = -250.0

#processed every frame
func state_process(delta):
	
	if get_parent().get_parent().isdead==true:
		next_state = death_state
		return
	
	#stops movement
	character.velocity.y = 0
	
	#moves into air state if not grabbing or on wall
	if(not Input.is_action_pressed("grab") or not character.is_on_wall()):
		next_state = air_state
		playback.travel("jump_start")

#jumps when you press jump key
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()

#jump function
func jump():
	can_climb = false
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel("jump_start")
	
