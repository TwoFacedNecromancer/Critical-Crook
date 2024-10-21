extends Area2D

signal death_signal

@onready var killbox_timer: Timer = $KillboxTimer



func _on_body_entered(body: CharacterBody2D) -> void:
	if body.isdead == false:
		killbox_timer.start()
	body.isdead = true

func _on_killbox_timer_timeout() -> void:
	get_tree().reload_current_scene()
