extends Control

func _ready() -> void:
	var config = ConfigFile.new() # instance a new ConfigFile class
	var err = config.load("user://optionsdata.cfg")
	
	#if the file did not load, then ignore it
	if err != OK:
		return
		
	#makes the check button enabled/disabled correctly
	$CheckButton.button_pressed = config.get_value("Options","isFullscreen")
	

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") #goes back to the main menu


func _on_check_button_toggled(toggled_on: bool) -> void:
	var config = ConfigFile.new() # instance a new ConfigFile class
	config.set_value("Options","isFullscreen",toggled_on) # sets the values in the file
	config.save("user://optionsdata.cfg") # writes the configuration file to the disk
	
	#checks if the checkbox is enabled and then either fu;lscreens or windows the screen
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
