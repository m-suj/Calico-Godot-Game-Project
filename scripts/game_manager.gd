extends Node


var fullscreen: bool = false


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		_toggle_fullscreen()


func _toggle_fullscreen() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		var screen_size: Vector2i = DisplayServer.screen_get_size()
		var window_size: Vector2i = Vector2i(1152, 648)
		DisplayServer.window_set_size(window_size)
		DisplayServer.window_set_position((screen_size - window_size) / 2)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	fullscreen = !fullscreen
