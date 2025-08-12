extends Control


@export var level_manager: LevelManager
var is_pausable: bool = true


func _ready() -> void:
	level_manager.game_over.connect(_disable_pausing)
	level_manager.player_respawn_start.connect(_disable_pausing)
	level_manager.player_respawn_finish.connect(_enable_pausing)
	visible = false
	

# Handle game pause
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		_toggle_pause()


# Pause/unpause the game
func _toggle_pause() -> void:
	if not is_pausable: 
		return
	var tree: SceneTree = get_tree()
	tree.paused = not tree.paused
	visible = tree.paused


# Signal button — Resume
func _on_resume_button_pressed() -> void:
	_toggle_pause()


# Signal button — Go to main menu
func _on_main_menu_button_pressed() -> void:
	# TODO: dialog zapytania o wyjście do menu głównego
	# TODO: zapisanie stanu gry
	var tree: SceneTree = get_tree()
	tree.paused = false
	tree.change_scene_to_file("res://scenes/main_menu/main_menu.tscn")

	
# Signal button — Quit game
func _on_quit_button_pressed() -> void:
	get_tree().quit()

	
# Signal Level Manager — Disable pause
func _disable_pausing() -> void:
	is_pausable = false
	
	
func _enable_pausing() -> void:
	is_pausable = true