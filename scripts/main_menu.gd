extends Control


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
