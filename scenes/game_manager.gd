extends Node


var ingame_menu_opened = false
var fullscreen = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("menu"):
		_toggle_ingame_menu()
	if Input.is_action_just_pressed("fullscreen"):
		_toggle_fullscreen()


func _toggle_ingame_menu() -> void:
	if ingame_menu_opened:
		print("menu closed!")
	else:
		print("menu opened!")
	ingame_menu_opened = !ingame_menu_opened

func _toggle_fullscreen() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	fullscreen = !fullscreen
