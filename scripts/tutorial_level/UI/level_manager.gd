class_name LevelManager extends Node


@export var transition_screen: TransitionScreen
@export var player: Player2D
@export var hud: HudManager

var current_checkpoint = null
@onready var level_start_point: Vector2 = player.global_position

signal game_over()
signal player_respawn_start()
signal player_respawn_finish()


func _ready() -> void:
	# Place player on level start
	_move_player_to_checkpoint()
	
	# Connecting to checkpoints
	var checkpoints: Array[Node] = get_tree().get_nodes_in_group("Checkpoints")
	for checkpoint in checkpoints:
		checkpoint.checkpoint_updated.connect(_on_checkpoint_updated)
		
	# Connecting to player's stats for hud updates
	player.lives_changed.connect(_on_player_lives_changed)
	player.health_changed.connect(_on_player_took_damage)
	hud.update()

	
func _move_player_to_checkpoint() -> void:
	if current_checkpoint == null:
		player.position = level_start_point
	else:
		player.position = current_checkpoint.global_position


# Signal from checkpoints — called when the player has reached one of the checkpoints
func _on_checkpoint_updated(checkpoint) -> void:
	current_checkpoint = checkpoint
	

# Signal from player — player took damage, update health/lives count
func _on_player_took_damage(_new_health: int) -> void:
	hud.update()


# Signal from player — their 'lives' value changes. Triggers transition screen and respawns the player
func _on_player_lives_changed(_new_lives: int) -> void:
	if _new_lives <= 0:
		game_over.emit()
	else:
		player_respawn_start.emit()
		transition_screen.fade_out()

	
# Signal — called after the 1st part of the transition screen
# Time for Level Manager to respawn the player etc.
func _on_transition_out_finished() -> void:
	_move_player_to_checkpoint()
	player.on_respawn()
	hud.update()
	await get_tree().create_timer(0.6).timeout
	transition_screen.fade_in()
	player_respawn_finish.emit()


# Signal — called after the 2nd part of the transition screen
# Gives the player the ability to move again after the restart sequence is finished
func _on_transition_in_finished() -> void:
	player.on_revive()
	
