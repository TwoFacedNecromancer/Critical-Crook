extends Area2D

signal death_signal

func _on_body_entered(body: Node2D) -> void:
	emit_signal("death_signal")
