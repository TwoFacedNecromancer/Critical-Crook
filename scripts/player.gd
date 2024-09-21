extends CharacterBody2D

#test comment

const SPEED = 120.0
const JUMP_VELOCITY = -100.0
var timer = 0.0
var direction = Input.get_vector("left", "right", "up", "down")
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var animation_tree: AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	
func _update_animation():
	animation_tree.set("parameters/move/blend_position", direction.x)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if not Input.is_action_pressed("down"):
			if velocity.y < 300:
				velocity += get_gravity() * delta
		elif Input.is_action_pressed("down"):
			if velocity.y < 500:
				velocity += get_gravity() * delta
	
	if not is_on_floor() and is_on_wall() and Input.is_action_pressed("grab"):
		if not Input.is_action_pressed("jump"):
			velocity.y = 0
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY*3
			
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
		timer = 1
	
	if timer > 0:
		timer -= 0.2

	if Input.is_action_pressed("jump") and !is_on_floor() and timer > 0:
		velocity.y = velocity.y-50
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if direction.x <0:
		animated_sprite_2d.flip_h = false
	elif direction.x >0:
		animated_sprite_2d.flip_h = true
	
func _update_facing_direction():
	if direction == 0:
		animated_sprite_2d.play("idle")
			
	else:
		animated_sprite_2d.play("run")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
