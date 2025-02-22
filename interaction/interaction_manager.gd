extends Node3D


@onready var player: Player = get_tree().root.get_node('Node/Player')
@onready var label: Label3D = $Label3D


const base_text = "[E] to "

var active_areas = []
var can_interact = true


func register_area(area: InteractionArea):
	print(player)
	active_areas.push_back(area)
	print(active_areas)


func unregister_area(area: InteractionArea):
	var i = active_areas.find(area)
	if i != -1:
		active_areas.remove_at(i)
	print(active_areas)


func _process(delta):
	if active_areas.size() > 0 and can_interact:
		active_areas.sort_custom(_sort_by_distance)
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.show()
	else:
		print('hiding label')
		label.hide()


func _sort_by_distance(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player


func _input(event):
	if event.is_action_pressed("interact") and can_interact:
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			
			await active_areas[0].interact.call()
			
			can_interact = true
