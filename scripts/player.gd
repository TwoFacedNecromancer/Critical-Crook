extends CharacterBody2D

#movement variables
@export var speed : float = 120.0
@export var speed_boost : float = 0.0

#used for variable jump height
var timer : float = 1.6

#how much jump height varies
var jumpmod : float = 20

#used for animation and state machine stuff
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

#gets inputs as a vector for use in movement
var direction = Input.get_vector("left", "right", "up", "down")

#allows animations to work
func _ready():
	animation_tree.active = true

#processed every frame
func _physics_process(delta: float) -> void:
	
	#decreases timer while in the air
	if(state_machine.current_state.name == "Air" and timer >= 0):
		timer -= 0.2
	elif(not state_machine.current_state.name == "Air"):
		timer = 2.0
	
	#only updates movement vector if not sliding
	if(state_machine.current_state.name != "Sliding"):
		direction = Input.get_vector("left", "right", "up", "down")
	
	#constantly decreases speed boost over time
	if speed_boost >= 0:
		speed_boost -= 0.5
	elif speed_boost < 0:
		speed_boost = 0
	
	# add the gravity so long as you arent climbing
	if (not state_machine.current_state.name == "Climbing"):
		if not is_on_floor():
			#applies gravity differently if you are holding down
			if not direction.y > 0:
				if velocity.y < 300:
					velocity += get_gravity() * delta
				else:
					velocity.y = (300)
			elif direction.y > 0:
				if velocity.y < (500):
					velocity += get_gravity() * delta
				else:
					velocity.y = (500)
			
		#decreases gravity effect if you are holding jump
		if Input.is_action_pressed("jump") and !is_on_floor() and timer > 0:
			velocity.y -= jumpmod
			
	#applies horizontal movement
	if direction.x != 0 and state_machine.check_if_can_move() and state_machine.current_state.name != "Climbing":
		if (state_machine.current_state.name != "Ground"):
			velocity.x = direction.x * (speed + speed_boost)
		else:
			velocity.x = direction.x * (speed)
	else:
		if(state_machine.current_state.name != "Sliding"):
			velocity.x = move_toward(velocity.x, 0, speed)
			speed_boost = 0
			pass

	#moves character and updates animation frames and sprite direction
	move_and_slide()
	update_animation()
	update_facing_direction()
	
	#makes animations work
func update_animation():
	var direction = Input.get_vector("left", "right", "up", "down")
	animation_tree.set("parameters/move/blend_position", direction.x)

#changes direction of sprite
func update_facing_direction():
	if(state_machine.current_state.name != "Climbing" and state_machine.current_state.name != "Sliding"):
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
	
