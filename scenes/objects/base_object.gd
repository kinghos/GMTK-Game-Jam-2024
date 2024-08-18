extends Node2D

signal mass_changed(new_mass: float)

var resize_tween: Tween = null
var hovering: bool = false
var can_push_switch

var _mass: float = 1.0 : set = set_mass

func set_mass(value: float) -> void:
	if _mass != value:
		_mass = value
		$".".mass = value
		mass_changed.emit(_mass, self)

func _ready():
	$CollisionShape2D.scale = Vector2(0.2, 0.2)
	set_mass($".".mass)
	
func resize(new_size: Vector2, new_mass: float, new_friction: float):
	if (resize_tween and resize_tween.is_running()) or not hovering:
		return
	
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	resize_tween.tween_property($CollisionShape2D, "scale", new_size, 1)
	resize_tween.tween_property($".", "_mass", new_mass, 1)
	$".".physics_material_override.set_friction(new_friction)
	
	await resize_tween.finished
	resize_tween = null

func _on_mouse_enter(_shape_idx: int):
	hovering = true

func _on_mouse_exit(_shape_idx: int):
	hovering = false
