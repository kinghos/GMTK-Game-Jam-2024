@tool
extends CanvasLayer


func _ready() -> void:
	if Engine.is_editor_hint():
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
