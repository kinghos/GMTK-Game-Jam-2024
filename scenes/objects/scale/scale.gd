extends Area2D

var total_mass_applied: float = 0.0 : set = set_total_mass_applied
var body_masses: Dictionary = {}

func set_total_mass_applied(value: float) -> void:
	total_mass_applied = value
	$Label.text = "Scale's current mass: " + str(total_mass_applied)

func _on_body_entered(body: Node2D) -> void:
	update_body_state(body, "enter")

func _on_body_exited(body: Node2D) -> void:
	update_body_state(body, "exit")

# Called to add/remove bodies from the scale
func update_body_state(body: RigidBody2D, state: String) -> void:
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

func _on_mass_changed(new_mass: float, body: RigidBody2D) -> void:
	if body in body_masses:
		# Must only add the mass change (old mass subtracted from new)
		adjust_total_mass(new_mass - body_masses[body])
		body_masses[body] = new_mass

func adjust_total_mass(change: float) -> void:
	set_total_mass_applied(total_mass_applied + change)
