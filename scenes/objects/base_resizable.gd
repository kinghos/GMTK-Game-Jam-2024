extends Node2D

signal mass_changed(new_mass: float)

var resize_tween: Tween = null
var hovering: bool = false
var can_push_switch

var _mass: float = 1.0 : set = set_mass

var scale_presets: Dictionary = {
	# scale: [mass, friction]
	Vector2(0.1, 0.1): [0.5, 0.4],
	Vector2(0.2, 0.2): [1, 0.4],
	Vector2(0.5, 0.5): [2, 0.45],
	Vector2(1.0, 1.0): [4, 1]
}

func set_mass(value: float) -> void:
	if _mass != value:
		_mass = value
		$".".mass = value
		mass_changed.emit(_mass, self)

func _ready():
	add_to_group("Resizables") # make sure it's in Resizables
	$CollisionShape2D.scale = Vector2(0.2, 0.2)
	set_mass($".".mass)

func resize(current_scale: Vector2, direction: int):
	if (resize_tween and resize_tween.is_running()) or not hovering or !scale_presets.has(current_scale):
		return
	
	var new_values: Array
	
	var scales = scale_presets.keys()
	var index = scales.find(current_scale)
	index += direction
	
	if index >= 0 and index < scales.size():
		var new_scale = scales[index]
		new_values = [new_scale, scale_presets[new_scale][0], scale_presets[new_scale][1]]
	else:
		new_values = [current_scale, scale_presets[current_scale][0], scale_presets[current_scale][1]]
	
	resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	resize_tween.tween_property($CollisionShape2D, "scale", new_values[0], 1)
	resize_tween.tween_property($".", "_mass", new_values[1], 1)
	$".".physics_material_override.set_friction(new_values[2])
	
	await resize_tween.finished
	resize_tween = null

func _on_mouse_enter(_shape_idx: int):
	hovering = true

func _on_mouse_exit(_shape_idx: int):
	hovering = false
