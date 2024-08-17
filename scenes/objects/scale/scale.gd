extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		$Label.text = str(body.mass)
