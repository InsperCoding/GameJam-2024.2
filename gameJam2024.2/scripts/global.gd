extends Node

var player_anda = true
var maldicao = true
var pistas_do_player = []
var pegou_peruca = false
var pegou_capa = false

func _process(delta: float) -> void:
	sairdojogo()

func sairdojogo() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
