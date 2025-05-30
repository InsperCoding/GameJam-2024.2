extends CharacterBody2D
class_name Player

const SPEED = 300.0
var current_dir = "none"
var direcao = null
var inventario = []
var mula = null

@export var interaction_distance = 160.0
@onready var camera = $Camera2D

func _ready() -> void:
	$AnimatedSprite2D.play("down_idle")
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	add_to_group("jogadores")

func _on_spawn(position: Vector2, direction: String):
	global_position = position

func _physics_process(delta: float) -> void:
	if Global.player_anda:
		player_movement(delta)

	# Interagir automaticamente com NPCs se estiver perto
	var npc = get_nearby_mula_mulher()
	if npc:
		npc.on_player_interact(global_position)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_diary"):
		$Diario.visible = !$Diario.visible
		
		for i in range(Global.num_palavras_novas):
			var label = $Diario.get_child(0).get_child(i+1)
			label.show()
			label.text = Global.palavras_ouvidas[i]
			var botao = $Diario.get_child(0).get_child(i+1).get_child(0)
			botao.selected = Global.traducoes_selecionadas[i]
	if event.is_action_pressed("interact"):  # se o jogador apertar E (ou a tecla que quiser)
		var mula = get_nearby_mula_sem_cabeca()
		if mula:
			mula.montar(self)
	
	# Desmontar
	if event.is_action_pressed("desmontar"):
		if is_inside_mula():
			mula.desmontar()

func player_movement(_delta):
	if Input.is_action_pressed("right"):
		current_dir = "right"
		direcao = Vector2(1, 0)
		player_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		direcao = Vector2(-1, 0)
		player_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		direcao = Vector2(0, -1)
		player_anim(1)
		velocity.x = 0
		velocity.y = -SPEED
	
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		direcao = Vector2(0, 1)
		player_anim(1)
		velocity.x = 0
		velocity.y = SPEED
	
	else:
		player_anim(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func player_anim(mov_constant):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		if mov_constant == 1:
			anim.play("right_walk")
		else:
			anim.play("right_idle")
	
	elif dir == "left":
		if mov_constant == 1:
			anim.play("left_walk")
		else:
			anim.play("left_idle")
	
	elif dir == "up":
		if mov_constant == 1:
			anim.play("up_walk")
		else:
			anim.play("up_idle")
	
	elif dir == "down":
		if mov_constant == 1:
			anim.play("down_walk")
		else:
			anim.play("down_idle")

func _on_option_button_item_selected(index: int) -> void:
	Dialogic.VAR.homem1_1 = $"/Diario/OptionButton".get_item_text($"/Diario/OptionButton".get_selected_id())

# Função para achar NPC MulaMulher perto
func get_nearby_mula_mulher():
	var npcs = get_tree().get_nodes_in_group("npcs")
	for npc in npcs:
		if npc is MulaMulher and global_position.distance_to(npc.global_position) <= interaction_distance:
			return npc
	return null
	
func get_nearby_mula_sem_cabeca():
	var npcs = get_tree().get_nodes_in_group("mulas")
	for npc in npcs:
		if global_position.distance_to(npc.global_position) <= interaction_distance:
			return npc
	return null
	
func is_inside_mula() -> bool:
	return mula != null
