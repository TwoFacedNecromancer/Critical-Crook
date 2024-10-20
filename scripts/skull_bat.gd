extends Node2D

@export var movementType: bool = false

@onready var rayCastRight = $RayCastRight
@onready var rayCastLeft = $RayCastLeft
@onready var sprite = $"Skull Bat Sprite"

const speed = 60
var direction = -1
var timer = 360



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if movementType == true:
		position.x += speed * direction * delta
		if rayCastRight.is_colliding():
			if(rayCastRight.get_collider()):
				direction = -1
				sprite.flip_h=false
		elif rayCastLeft.is_colliding():
			if(rayCastLeft.get_collider()):
				direction = 1
				sprite.flip_h=true
