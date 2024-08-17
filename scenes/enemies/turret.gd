extends BaseEnemy

signal kill(node, color)
@export var color: Color
func _ready():
	$AnimationPlayer.play("eyeball bob")

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Resizables"):
		kill.emit(self, color)
		queue_free()
