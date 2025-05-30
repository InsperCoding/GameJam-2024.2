extends Node
@onready var helicoptero_som_player: AudioStreamPlayer = $HelicopteroSom 


func _ready() -> void:
	Dialogic.start("Inicio")
	Dialogic.timeline_ended.connect(_on_timeline_finished)

func _process(delta: float) -> void:
	pass

func _on_timeline_finished():
	$"Transição/AnimationPlayer".play_backwards("Fade in")
	$Timer.start()

func _on_timer_timeout() -> void:
	var imagem_node: TextureRect = get_node("TransicaoHeli")
	
	imagem_node.visible = true
	helicoptero_som_player.play() 
	
	await get_tree().create_timer(3.0).timeout
	
	imagem_node.visible = false 
	helicoptero_som_player.stop()
	
	get_tree().change_scene_to_file("res://scenes/Vila.tscn")
