extends State

class_name DeathState

#gets the level scene
@onready var level = get_parent().get_parent().get_parent()

#reloads level when you die
func reload():
	level.get_tree().reload_current_scene()

func _ready() -> void:
	level.connect("sendToPlayer", Callable(self,"reload"))

func state_process(delta):
	pass
