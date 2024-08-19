extends CanvasLayer

var frames = [
	preload("res://assets/graphics/cutscenes/opening_1.png"),
	preload("res://assets/graphics/cutscenes/opening_2.png"),
	preload("res://assets/graphics/cutscenes/opening_3.png"),
	preload("res://assets/graphics/cutscenes/opening_4.png"),
	preload("res://assets/graphics/cutscenes/opening_5.png")
]
var current_frame: int = 0
var tween: Tween
var transitioning: bool = false

func _ready() -> void:
	update_current_frame()

func update_current_frame():
	tween = get_tree().create_tween()
	tween.tween_property($Frame, "modulate", Color.WHITE, 1)
	$Frame.texture = frames[current_frame]
	
	if current_frame == 0:
		$BackArrow.visible = false
	else:
		$BackArrow.visible = true
	if current_frame == frames.size() - 1:
		$NextArrow.visible = false
	else:
		$NextArrow.visible = true
	
	await tween.finished
	transitioning = false

func fade_to_black() -> void:
	tween = get_tree().create_tween()
	tween.tween_property($Frame, "modulate", Color.BLACK, 1)

func _on_next_arrow_pressed() -> void:
	if not transitioning:
		transitioning = true
		
		if current_frame < frames.size() - 1:
			current_frame += 1
		
		fade_to_black()
		await tween.finished
		update_current_frame()

func _on_back_arrow_pressed() -> void:
	if not transitioning:
		transitioning = true
		
		if current_frame >= 1:
			current_frame -= 1
		
		fade_to_black()
		await tween.finished
		update_current_frame()
