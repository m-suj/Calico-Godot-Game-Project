extends Node
class_name LevelManager


@export var transition_screen: TransitionScreen
@export var player: Player2D
@export var hud: HudManager

var current_checkpoint = null
@onready var level_start_point: Vector2 = player.global_position

signal game_over()


func _ready() -> void:
	# Connecting to checkpoints
	var checkpoints: Array[Node] = get_tree().get_nodes_in_group("Checkpoints")
	for checkpoint in checkpoints:
		checkpoint.checkpoint_updated.connect(_on_checkpoint_updated)
		
	# Connecting to player's stats for hud updates
	player.lives_changed.connect(_on_player_lives_changed)
	player.health_changed.connect(_on_player_took_damage)
	hud.update()


# Signal from checkpoints — called when the player has reached one of the checkpoints
func _on_checkpoint_updated(checkpoint) -> void:
	current_checkpoint = checkpoint
	

# Signal from player — player took damage, update health/lives count
func _on_player_took_damage(_new_health: int) -> void:
	hud.update()


# Signal — called when the player's lives changes. Triggers transition screen and respawns the player
func _on_player_lives_changed(_new_lives: int) -> void:
	if _new_lives <= 0:
		print("game over!")
		game_over.emit()
	else:
		transition_screen.fade_out()

	
# Signal — called after the 1st part of the transition screen
# Time for Level Manager to respawn the player etc.
func _on_transition_out_finished() -> void:
	if current_checkpoint == null:
		player.position = level_start_point
	else:
		player.position = current_checkpoint.global_position
	player.on_respawn()
	hud.update()
	await get_tree().create_timer(0.6).timeout
	transition_screen.fade_in()


# Signal — called after the 2nd part of the transition screen
# Gives the player the ability to move again after the restart sequence is finished
func _on_transition_in_finished() -> void:
	player.on_revive()
	
