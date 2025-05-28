extends Node

const scene_vila = preload("res://scenes/Vila.tscn")
const scene_oca1 = preload("res://scenes/Oca 1.tscn")
const scene_oca2 = preload("res://scenes/Oca 2.tscn")
const scene_iara = preload("res://scenes/Cena Iara.tscn")
const scene_curupira = preload("res://scenes/covilcurupira.tscn")
const scene_cuca = preload("res://scenes/covilcuca.tscn")
const scene_labirinto = preload("res://scenes/cena_labirinto.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Vila":
			scene_to_load = scene_vila
		"Oca 1":
			scene_to_load = scene_oca1
		"Oca 2":
			scene_to_load = scene_oca2
		"Cena Iara":
			scene_to_load = scene_iara
		"covilcurupira":
			scene_to_load = scene_curupira
		"covilcuca":
			scene_to_load = scene_cuca
		"cena_labirinto":
			scene_to_load = scene_labirinto
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
