extends BaseEnemy

var death: PackedScene = preload("res://scenes/utilities/death.tscn")

func _ready():
	$AnimationPlayer.play("eyeball bob")

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Resizables"):
		kill_entity()

func kill_entity():
	var death_anim = death.instantiate()
	add_child(death_anim)
	death_anim.position = position
	var anim = death_anim.get_node("AnimationPlayer")
	anim.play("death")
