extends Node


@onready var checkpoint_restart: Timer = $"CheckpointRestartTimer"
@onready var transition_screen: TransitionScreen = $"TransitionScreen"
@onready var player: Player2D = $"../Player"
@export var hud: HudManager

var current_checkpoint = null
@onready var level_start_point: Vector2 = player.global_position


func _ready() -> void:
	# Connecting to checkpoints
	var checkpoints: Array[Node] = get_tree().get_nodes_in_group("Checkpoints")
	for checkpoint in checkpoints:
		checkpoint.checkpoint_updated.connect(_on_checkpoint_updated)

	player.lives_changed.connect(_on_player_lives_changed)
	player.health_changed.connect(_on_player_took_damage)
	hud.update()


func _on_checkpoint_updated(checkpoint) -> void:
	print("Checkpoint updated to position", checkpoint.position, "!")
	current_checkpoint = checkpoint
	
	
func _on_player_took_damage(_new_health: int) -> void:
	hud.update()


# Signal — called when the player's lives changes. Triggers transition screen and respawns the player
func _on_player_lives_changed(_new_lives: int) -> void:
	# TODO: You died — restart confirmation when the player loses all lives
	transition_screen.fade_out()

	
# Signal — called after the 1st part of the transition screen
# Time for Level Manager to respawn the player etc.
func _on_transition_out_finished() -> void:
	print("transition finished")
	if current_checkpoint == null:
		player.position = level_start_point
	else:
		player.position = current_checkpoint.global_position
	player.on_respawn()
	hud.update()
	checkpoint_restart.start()


func _on_checkpoint_restart() -> void:
	transition_screen.fade_in()


# Signal — called after the 2nd part of the transition screen
# Gives the player the ability to move again after the restart sequence is finished
func _on_transition_in_finished() -> void:
	player.on_revive()

