extends Node2D

@export var MAX_SIZE: float = 4
@export var MIN_SIZE: float = 0.5

var scale_interval: float = 0.5
var scale_change: float

func resize(new_size: Vector2):
	var resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	resize_tween.tween_property($CollisionShape2D, "scale", new_size, 1)
	await resize_tween.finished


	

#func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#if event is InputEventMouseButton and event.is_pressed():
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#scale_change = scale_interval
		#elif event.button_index == MOUSE_BUTTON_RIGHT:
			#scale_change = -scale_interval
		#
		#var new_scale = scale + Vector2(scale_change, scale_change)
		#new_scale.x = max(new_scale.x, MIN_SIZE)
		#new_scale.y = max(new_scale.y, MIN_SIZE)
		#new_scale.x = min(new_scale.x, MAX_SIZE)
		#new_scale.y = min(new_scale.y, MAX_SIZE)
		#
		#for i in range(20):
			#scale + new_scale / 20
		#
		#var tween = get_tree().create_tween()
		#tween.set_parallel()
		#for i in get_children():
			#tween.tween_property(i, "scale", new_scale, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
