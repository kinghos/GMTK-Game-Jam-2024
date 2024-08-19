extends CanvasLayer

var frames = ["Frame1", "Frame2", "Frame3", "Frame4", "Frame5"]
var current_frame: int = 3

func _ready() -> void:
	update_current_frame()

func update_current_frame():
	get_node(frames[current_frame]).visible = true
	for i in range(current_frame+1, frames.size()):
		get_node(frames[i]).visible = false

func _on_texture_button_pressed() -> void:
	current_frame += 1
	update_current_frame()
