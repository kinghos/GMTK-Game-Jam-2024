extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Entered")
	if body is RigidBody2D:
		print(body.mass)
		$Label.text = str(body.mass)
