extends Node3D

@onready var interact_label: Label3D = $InteractLabel
var current_interactions := []
var can_interact: bool = true
var player_ref: Player = null

func _input(_event: InputEvent) -> void:
	#if event.is_action_pressed("interact") and can_interact:
	if MultiplayerInput.is_action_just_pressed(player_ref.using_device, "interact") and can_interact:
		if current_interactions:
			# start interaction
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact.call(player_ref)
			
			can_interact = true

func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			interact_label.text = current_interactions[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

func _sort_by_nearest(area1: Area3D, area2: Area3D) -> bool:
	var area1_dist: float = global_position.distance_to(area1.global_position)
	var area2_dist: float = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

func _on_area_3d_area_entered(area: Area3D) -> void:
	current_interactions.push_back(area)


func _on_area_3d_area_exited(area: Area3D) -> void:
	current_interactions.erase(area)
