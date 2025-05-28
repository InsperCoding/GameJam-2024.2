extends Node

var player_in_range = false
var ja_interagiu = false

func interacao() -> void:
	if !ja_interagiu:
		ja_interagiu = true
		# FALTA AQUI:
		# Habilitar label baseada no numero aprendido, colocando texto adequando
		Global.num_palavras_novas += 1
		
		for palavra in get_meta("novas_palavras"):
			print(palavra)
			Dialogic.VAR.set_variable(palavra, palavra)
			var label = $"../Diario".get_children()[0].get_children()[Global.num_palavras_novas]
			label.show()
			label.text = palavra
			
	#Dialogic.start("conversa_homem1")
	Dialogic.start(get_meta("dialogo"))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		interacao()

func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		
		if Input.is_action_just_pressed("interact"):
			interacao()
			
func _on_area_2d_area_exited(body: CharacterBody2D) -> void:
	player_in_range = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
