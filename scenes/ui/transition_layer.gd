@tool
extends CanvasLayer

func _ready() -> void:
	if Engine.is_editor_hint():
		visible = false
	else:
		visible = true

func _process(_delta: float) -> void:
	pass
