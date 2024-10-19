extends State

class_name DeathState

var deathtoggle : bool = false

func _process(delta: float) -> void:
	if get_parent().get_parent().isdead==true:
		if(deathtoggle == false):
			playback.travel("death")
			deathtoggle = true
