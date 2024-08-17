extends Node2D

@export var MAX_SIZE: float = 4
@export var MIN_SIZE: float = 0.5

var scale_interval: float = 0.5
var scale_change: float

var resize_tween: Tween = null

func resize(new_size: Vector2):
	if resize_tween and resize_tween.is_running():
		return
		
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	resize_tween.tween_property($CollisionShape2D, "scale", new_size, 1)
	
	await resize_tween.finished
	resize_tween = null
