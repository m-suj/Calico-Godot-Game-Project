extends Control
class_name GameOverScreen


@export var level_manager: LevelManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	level_manager.game_over.connect(_on_game_over)
	
	
func _on_game_over() -> void:
	print("game over! From: Game Over Screen")
	visible = true

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	# TODO: dialog zapytania o wyjście do menu głównego
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
