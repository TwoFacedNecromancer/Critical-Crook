extends Control

@export var backMenu: String

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(backMenu) #goes back to the main menu
