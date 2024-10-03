extends CharacterBody2D

#test comment

@export var speed : float = 120.0

@export var speed_boost : float = 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var state_machine: CharacterStateMachine = $CharacterStateMachine

var new_grav = get_gravity()
var grav_mod : float

func _ready():
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	
	if(Input.is_action_pressed("jump")):
		new_grav.y = get_gravity().y - 200
		grav_mod = 200
		pass
	else:
		new_grav.y = get_gravity().y + 300
		grav_mod =  0
		pass
	
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if speed_boost >= 0:
		speed_boost -= 0.5
	elif speed_boost < 0:
		speed_boost = 0
	
	# Add the gravity.
	if (state_machine.current_state.name == "Air"):
		if not is_on_floor():
			if not direction.y > 0:
				if velocity.y < (300 - grav_mod):
					velocity += new_grav * delta
					
				else:
					velocity.y = (300 - grav_mod)
			elif direction.y > 0:
				if velocity.y < (500 - grav_mod):
					velocity += new_grav * delta
					
				else:
					velocity.y = (500 - grav_mod)
	
			
	if direction.x != 0 and state_machine.check_if_can_move() and state_machine.current_state.name != "Climbing":
		if (state_machine.current_state.name != "Ground"):
			velocity.x = direction.x * (speed + speed_boost)
		else:
			velocity.x = direction.x * (speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		speed_boost = 0
			
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		#jump
		pass
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	move_and_slide()
	update_animation()
	update_facing_direction()
	
func update_animation():
	var direction = Input.get_vector("left", "right", "up", "down")
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if(!state_machine.current_state.name == "Climbing"):
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction.x < 0:
			sprite.flip_h = true
		elif direction.x > 0:
			sprite.flip_h = false
		
	

	
