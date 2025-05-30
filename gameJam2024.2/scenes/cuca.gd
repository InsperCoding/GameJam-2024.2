extends Node

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		Global.pegou_peruca = true
		Dialogic.start("com_a_cuca")


func _on_area_2d_area_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		Dialogic.start("com_a_cuca")


func _on_area_2d_area_exited(body: CharacterBody2D) -> void:
	player_in_range = false
	print("NPC.player_in_range = " + str(player_in_range))


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		Dialogic.start("com_a_cuca")
