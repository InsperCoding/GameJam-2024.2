extends Node

var player_anda = true
var maldicao = true
var pistas_do_player = []

# Variaveis que devem ser true para que o player possa interagir com a cuca
var viu_a_cuca = true
var peruca = false
var varinha = false
var capa = false

# Variaveis relacionadas ao diario
var num_palavras_novas = 0

func _process(_delta: float) -> void:
	sairdojogo()

func sairdojogo() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
