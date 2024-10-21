extends Control

@export var backMenu: String


var paused = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


func pauseMenu():
	if paused:
		visible = false
		Engine.time_scale = 1
	else:
		visible = true
		Engine.time_scale = 0
	paused = !paused


func _on_back_to_menu_pressed() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file(backMenu) #goes back to the main menu


func _on_resume_button_pressed() -> void:
	pauseMenu()
