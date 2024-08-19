extends StaticBody2D

var hovering = false
var resize_tween: Tween = null
var sizes = []
func _on_mouse_entered() -> void:
	hovering = true


func _on_mouse_exited() -> void:
	hovering = false

func resize(current_scale: Vector2, direction: int):
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	resize_tween.tween_property($CollisionShape2D, "scale", sizes[0], 1)
	resize_tween.tween_property($".", "_mass", sizes[1], 1)
	$".".physics_material_override.set_friction(sizes[2])
	
