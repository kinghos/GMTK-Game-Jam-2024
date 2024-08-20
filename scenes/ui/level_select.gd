extends Control

const MAIN_MENU = preload("res://assets/audio/Main Menu.mp3")

func _ready() -> void:
	Music._play_music_level(MAIN_MENU)
	var container = $GridContainer
	for level in Globals.unlocked_levels:
		for child in container.get_children():
			if child.name == level:
				child.disabled = false

func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")

func _on_level_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")

func _on_level_4_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_4.tscn")

func _on_level_5_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_5.tscn")

func _on_level_6_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_6.tscn")

func _on_level_7_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_7.tscn")

func _on_level_8_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_8.tscn")

func _on_level_9_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_9.tscn")

func _on_level_10_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_10.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
