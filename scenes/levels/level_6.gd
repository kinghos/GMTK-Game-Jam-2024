extends BaseLevel

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		for i in get_tree().get_nodes_in_group("Resizables"):
			if i is RigidBody2D:
				i.apply_central_impulse(Vector2.ONE)
