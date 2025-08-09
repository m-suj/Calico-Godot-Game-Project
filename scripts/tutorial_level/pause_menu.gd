extends Control


func _ready() -> void:
	visible = false


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		_toggle_pause()


func _toggle_pause():
	var tree: SceneTree = get_tree()
	tree.paused = not tree.paused
	visible = tree.paused


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_main_menu_button_pressed() -> void:
	# TODO: dialog zapytania o wyjście do menu głównego
	# TODO: zapisanie stanu gry
	var tree: SceneTree = get_tree()
	tree.paused = false
	tree.change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
