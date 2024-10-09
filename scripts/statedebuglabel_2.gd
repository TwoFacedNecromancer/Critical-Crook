extends Label

@export var state_machine : CharacterStateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "overlap: " + str(get_parent().find_child("CharacterStateMachine").find_child("Sliding").overlap)
