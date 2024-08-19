extends Area2D

signal pressed(pressed)
var pressure_plate # Property for locked_door
@export var mass_required: float
@export var failure_color: Color = "d11229"
@export var success_color: Color = "89b361"
@export var plate_color: Color

var total_mass_applied: float = 0.0 : set = update_total_mass_applied
var body_masses: Dictionary = {}

func _ready() -> void:
	$Plate.set_self_modulate(plate_color)

func update_total_mass_applied(value: float) -> void:
	total_mass_applied = value
	if total_mass_applied < mass_required:
		$Block/ColorMask.color = failure_color
		pressed.emit(false)
	else:
		$Block/ColorMask.color = success_color
		pressed.emit(true)

func _on_body_entered(body: Node2D) -> void:
	update_body_state(body, "enter")

func _on_body_exited(body: Node2D) -> void:
	update_body_state(body, "exit")

# Called to add/remove bodies from the scale
func update_body_state(body: PhysicsBody2D, state: String) -> void:
	if body is RigidBody2D:
		match state:
			"enter":
				if not body_masses.has(body):
					body_masses[body] = body.mass
					adjust_total_mass(body.mass)
					body.connect("mass_changed", Callable(self, "_on_mass_changed"))
			"exit":
				if body_masses.has(body):
					adjust_total_mass(-body_masses[body])
					body_masses.erase(body)
					body.disconnect("mass_changed", Callable(self, "_on_mass_changed"))
	
	if body.name == "Player":
		match state:
			"enter":
				adjust_total_mass(0.5)
			"exit":
				adjust_total_mass(-0.5)

func _on_mass_changed(new_mass: float, body: RigidBody2D) -> void:
	if body in body_masses:
		# Must only add the mass change (old mass subtracted from new)
		adjust_total_mass(new_mass - body_masses[body])
		body_masses[body] = new_mass

func adjust_total_mass(change: float) -> void:
	update_total_mass_applied(total_mass_applied + change)
