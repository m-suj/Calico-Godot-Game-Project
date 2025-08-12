extends CanvasLayer
class_name TransitionScreen


@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal fade_out_finished
signal fade_in_finished


func fade_in():
	visible = true
	animation_player.play("fade_in")

func fade_out():
	visible = true
	animation_player.play("fade_out")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		fade_out_finished.emit()
	elif anim_name == "fade_in":
		fade_in_finished.emit()
