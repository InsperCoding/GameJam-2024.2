extends Node

var start_button
var quit_button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_button = $VBoxContainer/Start
	quit_button = $VBoxContainer/Quit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Escritorio.tscn")


func _on_quit_button_down() -> void:
	get_tree().quit()
