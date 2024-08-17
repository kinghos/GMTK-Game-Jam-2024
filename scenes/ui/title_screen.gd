extends Control


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/level_select.tscn")


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	get_tree().quit()
