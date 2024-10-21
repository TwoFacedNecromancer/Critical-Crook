extends Node2D

const speed = 80
var direction = -1

@onready var rayCastRight = $RayCastRight
@onready var rayCastLeft = $RayCastLeft
@onready var sprite = $"Fireman Sprite"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * direction * delta
	if rayCastRight.is_colliding():
		if(rayCastRight.get_collider()):
			direction = -1
			sprite.flip_h=false
	elif rayCastLeft.is_colliding():
		if(rayCastLeft.get_collider()):
			direction = 1
			sprite.flip_h=true
