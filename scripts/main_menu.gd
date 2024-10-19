extends Control

func _ready() -> void:
	#this makes the file so that the config can run
	var config = ConfigFile.new() # instance a new ConfigFile class
	var err = config.load("user://optionsdata.cfg")
	
	#if the file did not load, then ignore it
	if err != OK:
		return
	
	#this makes your screen setting activate on startup
	if config.get_value("Options","isFullscreen") == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/options_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
