extends Node2D

var death: PackedScene = preload("res://scenes/utilities/death.tscn")

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("Enemies"):
		i.connect("kill", kill_entity)

func kill_entity(node: Node, color: Color):
	var death_anim = death.instantiate()
	add_child(death_anim)
	death_anim.global_position = node.global_position
	var anim: AnimationPlayer = death_anim.get_node("AnimationPlayer")
	anim.get_animation("death").track_set_key_value(3, 0, color)
	
	var particles: GPUParticles2D = death_anim.get_node("GPUParticles2D")
	particles.process_material.color = color
	
	color.a = 0
	anim.get_animation("death").track_set_key_value(3, 1, color)
	anim.play("death")
