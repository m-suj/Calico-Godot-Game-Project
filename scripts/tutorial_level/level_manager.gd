extends Node

@onready var level_restart: Timer = $"LevelRestartTimer"
@onready var transition_screen: TransitionScreen = $"TransitionScreen"
@onready var player: Player2D = $"../Player"

var current_checkpoint = null
@onready var level_start_point = player.global_position


func _ready() -> void:
	# Connecting to checkpoints
	var checkpoints = get_tree().get_nodes_in_group("Checkpoints")
	for checkpoint in checkpoints:
		checkpoint.checkpoint_updated.connect(_on_checkpoint_updated)
	
	# Connecting to killzones
	var killzones = $"../Environment/Killzones".get_children()
	for killzone in killzones:
		killzone.player_fell.connect(_on_player_fell)
	# Connecting to enemies
	var enemies = $"../Environment/Enemies".get_children()
	for enemy in enemies:
		enemy.get_node("Killzone").player_fell.connect(_on_player_fell)


func _on_checkpoint_updated(checkpoint) -> void:
	print("Checkpoint updated to position", checkpoint.position, "!")
	current_checkpoint = checkpoint


func _on_player_fell() -> void:
	transition_screen.fade_out()


func _on_transition_finished() -> void:
	if current_checkpoint == null:
		player.position = level_start_point
	else:
		player.position = current_checkpoint.global_position
	player.on_respawn()
	level_restart.start()
	# TODO: You died - restart confirmation


func _on_level_restart() -> void:
	transition_screen.fade_in()
