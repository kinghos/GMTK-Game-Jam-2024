extends Node2D

var resize_tween: Tween = null

func _ready():
	$CollisionShape2D.scale = Vector2(0.2, 0.2)

func resize(new_size: Vector2):
	if resize_tween and resize_tween.is_running():
		return
		
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	resize_tween.tween_property($CollisionShape2D, "scale", new_size, 1)
	
	await resize_tween.finished
	resize_tween = null
