extends Node2D

var death: PackedScene = preload("res://scenes/utilities/death.tscn")

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("Enemies"):
		i.connect("kill", kill_entity)

func kill_entity(node, color):
	var death_anim = death.instantiate()
	add_child(death_anim)
	death_anim.global_position = node.global_position
	var anim: AnimationPlayer = death_anim.get_node("AnimationPlayer")
	anim.get_animation("death").track_set_key_value(3, 1, color)
	anim.play("death")
