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
var palavras_ouvidas = []
var traducoes_selecionadas = []

# Variaveis relacionadas ao inventario
var inventario = []

func _process(_delta: float) -> void:
	sairdojogo()

func sairdojogo() -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
func coletar_item(item: String) -> void:
	var hotbar = get_tree().get_current_scene().get_child(-1)
	var espaco_no_inventario = hotbar.get_child(0).get_child(0).get_child(2*inventario.size())
	print(espaco_no_inventario)
	espaco_no_inventario.texture = load(item)
	inventario.append(item)
