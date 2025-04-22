extends Node2D


func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	Dialogic.start("com_a_cuca", "Primeiro encontro")
	print(Global.player_anda)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.varinha and Global.capa and Global.peruca:
		if Input.is_action_just_pressed("interact"):
			Dialogic.start("com_a_cuca", "Achou tudo")


func _on_timeline_ended():
	Dialogic.timeline_ended.disconnect(_on_timeline_ended)
	Global.capa = true
	Global.peruca = true
	Global.varinha = true
	print("Variáves alteradas")
