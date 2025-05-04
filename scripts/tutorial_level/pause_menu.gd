extends Control


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		_toggle_pause()


func _toggle_pause():
	var tree = get_tree()
	tree.paused = not tree.paused
	visible = tree.paused
