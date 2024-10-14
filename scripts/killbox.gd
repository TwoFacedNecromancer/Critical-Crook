extends Area2D

signal death_signal

@onready var killbox_timer: Timer = $KillboxTimer


func _on_body_entered(body: Node2D) -> void:
	print("then perish...")
	killbox_timer.start()

func _on_killbox_timer_timeout() -> void:
	get_tree().reload_current_scene()
