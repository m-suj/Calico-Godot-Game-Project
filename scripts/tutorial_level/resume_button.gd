extends Button

@onready var pause_menu: Control = $"../.."


func _on_pressed():
	get_tree().paused = false
	pause_menu.visible = false
