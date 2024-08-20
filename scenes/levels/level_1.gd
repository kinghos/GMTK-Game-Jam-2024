extends BaseLevel

var done_already: bool = false

func _on_boulder_label_area_body_entered(body: Node2D) -> void:
	if not done_already:
		done_already = true
		$Labels/BoulderLabel.text = "Maybe you can crush the\nturret with this boulder?"
