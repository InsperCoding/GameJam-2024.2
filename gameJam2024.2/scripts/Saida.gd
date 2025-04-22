extends Node

var player_in_range = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/Vila.tscn")

func _on_area_2d_area_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_area_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false
