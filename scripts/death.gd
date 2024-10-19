extends State

class_name DeathState


func _process(delta: float) -> void:
	if get_parent().get_parent().isdead==true:
		playback.travel("death")
