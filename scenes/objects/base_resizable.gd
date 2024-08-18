@tool
extends Node2D

signal mass_changed(new_mass: float)

@export_enum("Small", "Default", "Medium", "Large") var initial_scale: String = "Default" :
	set(value):
		initial_scale = value
		update_initial_state()

var resize_tween: Tween = null
var hovering: bool = false
var can_push_switch

var _mass: float = 1.0 : set = set_mass

const SCALE_PRESETS = {
	"Small": {"scale": Vector2(0.1, 0.1), "mass": 0.5, "friction": 0.4},
	"Default": {"scale": Vector2(0.2, 0.2), "mass": 1.0, "friction": 0.4},
	"Medium": {"scale": Vector2(0.5, 0.5), "mass": 2.0, "friction": 0.45},
	"Large": {"scale": Vector2(1.0, 1.0), "mass": 4.0, "friction": 1.0}
}

func set_mass(value: float) -> void:
	if _mass != value:
		_mass = value
		$".".mass = value
		mass_changed.emit(_mass, self)

func update_initial_state():
	var initial_preset = SCALE_PRESETS.get(initial_scale)
	$CollisionShape2D.scale = initial_preset["scale"]
	set_mass(initial_preset["mass"])

func _ready():
	add_to_group("Resizables") # make sure it's in Resizables
	update_initial_state()

func resize(current_scale: Vector2, direction: int):
	var scales = []
	var scale_keys = []

	for key in SCALE_PRESETS.keys():
		var scale_value = SCALE_PRESETS[key]["scale"]
		scales.append(scale_value)
		scale_keys.append(key)
	
	if (resize_tween and resize_tween.is_running()) or not hovering or not scales.has(current_scale):
		return

	var index = scales.find(current_scale)
	index += direction
	
	var new_values: Array
	if index >= 0 and index < scales.size():
		var new_scale = scales[index]
		var new_key = scale_keys[index]
		new_values = [new_scale, SCALE_PRESETS[new_key]["mass"], SCALE_PRESETS[new_key]["friction"]]
		
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
