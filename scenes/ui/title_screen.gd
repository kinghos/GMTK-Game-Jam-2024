extends Control

const MAIN_MENU = preload("res://assets/audio/Main Menu.mp3")

func _ready() -> void:
	Music._play_music_level(MAIN_MENU)

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/opening_cutscene.tscn")


func _on_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
