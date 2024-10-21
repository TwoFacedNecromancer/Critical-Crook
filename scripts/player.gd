extends CharacterBody2D

#test comment hello

@export var speed : float = 120.0

@export var speed_boost : float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine
@onready var pause_menu: Control = $"Camera2D/Pause Menu"

var timer : float = 1.6

var direction = Input.get_vector("left", "right", "up", "down")

func _ready():
	animation_tree.active = true

var isdead = false

func _physics_process(delta: float) -> void:
	if isdead == true or pause_menu.paused == true:
		return
	if(state_machine.current_state.name == "Air" and timer >= 0):
		timer -= 0.2 * delta
	elif(not state_machine.current_state.name == "Air"):
		timer = 2.0
	if(state_machine.current_state.name != "Sliding"):
		direction = Input.get_vector("left", "right", "up", "down")
	
	if speed_boost >= 0:
		speed_boost -= 0.5
	elif speed_boost < 0:
		speed_boost = 0
	
	# Add the gravity.
	if (not state_machine.current_state.name == "Climbing"):
		if not is_on_floor():
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
					
		if Input.is_action_pressed("jump") and !is_on_floor() and timer > 0:
			velocity.y = velocity.y-350 * delta
			
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
		
	

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	var direction = Input.get_vector("left", "right", "up", "down")
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if(state_machine.current_state.name != "Climbing" and state_machine.current_state.name != "Sliding"):
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
	
