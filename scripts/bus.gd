extends Node2D

signal sendToPlayer

@onready var killboxArea2D = $Killbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	killboxArea2D.connect("death_signal", Callable(self, "sendPlayer"))

func sendPlayer():
	emit_signal("sendToPlayer")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
