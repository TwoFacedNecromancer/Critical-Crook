extends Area2D

@export var nextScene : String

func _on_body_entered(body: CharacterBody2D) -> void:
	if(body.name == "player"):
		get_tree().change_scene_to_file(nextScene)
