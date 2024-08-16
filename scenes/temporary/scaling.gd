extends Node2D

var scale_interval: float = 0.5
var scale_change: float

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_LEFT:
			scale_change = scale_interval
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			scale_change = -scale_interval
		
		var new_scale = scale + Vector2(scale_change, scale_change)
		new_scale.x = max(new_scale.x, scale_interval)
		new_scale.y = max(new_scale.y, scale_interval)
		
		var tween = get_tree().create_tween()
		tween.tween_property(self, "scale", new_scale, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
