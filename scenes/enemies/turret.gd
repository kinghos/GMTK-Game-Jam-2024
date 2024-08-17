extends BaseEnemy

signal kill

func _ready():
	$AnimationPlayer.play("eyeball bob")

func _on_kill_area_body_entered(body: Node2D) -> void:
	print("something entered turret kill area")
	if body.is_in_group("Resizables"):
		queue_free()
		kill.emit()
