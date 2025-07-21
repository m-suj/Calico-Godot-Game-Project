extends CanvasLayer
class_name TransitionScreen


@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished


func fade_in():
	visible = true
	animation_player.play("fade_in")

func fade_out():
	visible = true
	animation_player.play("fade_out")



func _on_animation_player_animation_finished(name: StringName) -> void:
	if name == "fade_out":
		transition_finished.emit()
