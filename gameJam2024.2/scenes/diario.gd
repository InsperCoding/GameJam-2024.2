extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_option_button_item_selected(index: int, button_index: int) -> void:
	#print(Dialogic.VAR.variables())
	#print(button_index)
	var painel = get_node("Panel/Label" + str(button_index))
	var botao = get_node("Panel/Label" + str(button_index) + "/OptionButton")
	#print(botao.get_item_text(botao.get_selected_id()))
	#print(painel.text)
	Dialogic.VAR.set_variable(painel.text, botao.get_item_text(botao.get_selected_id()))
