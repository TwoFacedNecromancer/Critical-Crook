extends Area2D

signal death_signal

@onready var killbox_timer: Timer = $KillboxTimer


func _on_body_entered(body: Node2D) -> void:
	killbox_timer.start()

func _on_killbox_timer_timeout() -> void:
	emit_signal("death_signal")
