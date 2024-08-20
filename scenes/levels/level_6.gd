extends BaseLevel

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Objects/Boulder.apply_central_impulse(Vector2.ONE)
