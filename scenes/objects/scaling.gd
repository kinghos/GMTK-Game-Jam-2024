extends Node2D

var hovering: bool = false

var resize_tween: Tween = null

func _ready():
	$CollisionShape2D.scale = Vector2(0.2, 0.2)

func resize(new_size: Vector2, new_mass: float):
	if (resize_tween and resize_tween.is_running()) or not hovering:
		return
		
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel(true)
	resize_tween.tween_property($CollisionShape2D, "scale", new_size, 1)
	resize_tween.tween_property($".", "mass", new_mass, 1)
	
	await resize_tween.finished
	resize_tween = null

func _on_mouse_enter(_shape_idx: int):
	hovering = true

func _on_mouse_exit(_shape_idx: int):
	hovering = false
