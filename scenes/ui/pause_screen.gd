extends CanvasLayer

var paused = false


func pause_menu() -> void:
	paused = not paused
	hide()
	get_tree().paused = false


func _on_resume_button_pressed() -> void:
	pause_menu()


func _on_menu_button_pressed() -> void:
	pause_menu()
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
