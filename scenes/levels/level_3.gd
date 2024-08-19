extends Node2D

@onready var boulder_holder: StaticBody2D = $Objects/BoulderHolder
@onready var boulder: RigidBody2D = $Objects/Boulder
var removed = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if not removed:
		boulder_holder.queue_free()
		removed = true
	boulder.apply_central_impulse(Vector2(0.1, 0.1))
	$Objects/Warning.text = "RUN!"