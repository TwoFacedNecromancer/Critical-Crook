extends State

class_name DeathState

@onready var level = get_parent().get_parent().get_parent()

func reload():
	level.get_tree().reload_current_scene()

func _ready() -> void:
	level.connect("sendToPlayer", Callable(self,"thing"))

func state_process(delta):
	pass
