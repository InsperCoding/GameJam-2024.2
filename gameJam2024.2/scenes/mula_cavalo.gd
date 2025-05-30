extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@onready var sprite_montado = $Cavaleiro/AnimatedSprite2D # Supondo que Cavaleiro é um nó filho da mula

const SPEED = 300.0
var montado = false
var jogador = null

func _ready():
	sprite.play("idle")
	sprite_montado.visible = false

func _physics_process(delta):
	if montado and jogador:
		var input_vector = Vector2.ZERO
		if Input.is_action_pressed("right"):
			input_vector.x += 5
		if Input.is_action_pressed("left"):
			input_vector.x -= 5
		if Input.is_action_pressed("down"):
			input_vector.y += 5
		if Input.is_action_pressed("up"):
			input_vector.y -= 5

		velocity = input_vector.normalized() * SPEED
		move_and_slide()

		if velocity.x != 0:
			var flip = velocity.x < 0
			# Assumindo que sprite é da mula e sprite_montado é do cavaleiro na mula
			# Se a mula não deve virar quando montada, ajuste esta lógica.
			# Se o sprite da mula também deve virar:
			# $AnimatedSprite2D.flip_h = flip
			if sprite_montado.get_parent() == self: # Se sprite_montado é filho direto da mula
				sprite_montado.flip_h = flip
			elif sprite_montado.get_parent().get_parent() == self and sprite_montado.get_parent().name == "Cavaleiro": # Se está em Cavaleiro/AnimatedSprite2D
				# Para virar o nó "Cavaleiro" inteiro, o que viraria o AnimatedSprite2D junto
				# $Cavaleiro.scale.x = abs($Cavaleiro.scale.x) * (-1 if flip else 1)
				# Ou apenas o sprite, se a estrutura permitir:
				sprite_montado.flip_h = flip


		if velocity.length() > 0:
			if sprite_montado.animation != "run":
				sprite_montado.play("run")
		else:
			if sprite_montado.animation != "idle":
				sprite_montado.play("idle")

func montar(player_node):
	if not montado:
		print_debug("Mula: Iniciando processo de montar.")
		jogador = player_node
		if not is_instance_valid(jogador):
			print_debug("Mula ERRO: Nó do jogador inválido ao tentar montar.")
			return

		# Tenta pegar a câmera do jogador
		var camera_node = jogador.get_node_or_null("Camera2D") # Use get_node_or_null para evitar erro se não existir

		if camera_node is Camera2D: # Verifica se o nó existe e é do tipo Camera2D
			var camera = camera_node as Camera2D
			print_debug("Mula: Câmera encontrada no jogador: ", camera.name)
			
			var old_parent = camera.get_parent()
			if old_parent:
				print_debug("Mula: Pai antigo da câmera: ", old_parent.name)
				old_parent.remove_child(camera)
			
			add_child(camera) # Adiciona a câmera como filha da mula
			camera.make_current()
			# Ajusta a posição da câmera para a posição da mula/cavalo
			# Pode ser melhor centralizar ou usar um RemoteTransform2D para posições mais complexas
			camera.global_position = self.global_position 
			print_debug("Mula: Câmera transferida para a mula e definida como atual.")

			montado = true
			jogador.mula = self # Informa ao jogador que ele está nesta mula
			jogador.visible = false
			# A posição do jogador é atualizada para a da mula para consistência ao desmontar
			jogador.global_position = self.global_position 
			
			sprite.visible = false # Esconde o sprite da mula "sozinha"
			sprite_montado.visible = true
			sprite_montado.play("idle")
			print_debug("Mula: Montagem completa.")
		else:
			if camera_node:
				print_debug("Mula ERRO: Nó 'Camera2D' encontrado no jogador, mas não é do tipo Camera2D. Tipo: ", camera_node.get_class())
			else:
				print_debug("Mula ERRO: Nó 'Camera2D' não encontrado como filho do jogador.")
			# Decide o que fazer se não houver câmera. Talvez o jogador tenha sua própria câmera principal
			# ou uma câmera global esteja ativa. Por enquanto, vamos permitir montar sem transferir câmera.
			# Se a câmera for essencial para a montaria, você pode adicionar um 'return' aqui.
			# montado = true # Se pode montar mesmo sem câmera
			# jogador.mula = self
			# jogador.visible = false
			# jogador.global_position = global_position
			# sprite.visible = false
			# sprite_montado.visible = true
			# sprite_montado.play("idle")


func desmontar():
	if montado and is_instance_valid(jogador):
		print_debug("Mula: Iniciando processo de desmontar.")
		
		var camera_node = self.get_node_or_null("Camera2D") # Tenta pegar a câmera da mula

		if camera_node is Camera2D: # Verifica se a mula tem a câmera e se é do tipo Camera2D
			var camera = camera_node as Camera2D
			print_debug("Mula: Câmera encontrada na mula: ", camera.name)
			
			var old_parent = camera.get_parent()
			if old_parent: # Deve ser a mula (self)
				print_debug("Mula: Pai antigo da câmera (deve ser a mula): ", old_parent.name)
				old_parent.remove_child(camera)
			
			jogador.add_child(camera) # Adiciona a câmera de volta ao jogador
			camera.make_current()
			# Ajusta a posição da câmera para a posição do jogador
			camera.global_position = jogador.global_position 
			print_debug("Mula: Câmera devolvida ao jogador e definida como atual.")
		else:
			if camera_node:
				print_debug("Mula ERRO: Nó 'Camera2D' encontrado na mula, mas não é do tipo Camera2D. Tipo: ", camera_node.get_class())
			else:
				print_debug("Mula AVISO: Nó 'Camera2D' não encontrado como filho da mula ao desmontar. O jogador usará sua própria câmera se tiver, ou a câmera padrão.")

		jogador.global_position = self.global_position + Vector2(50, 0) # Ex: 50 pixels à direita

		jogador.mula = null
		jogador.visible = true
		# A posição do jogador já deve estar correta (onde a mula estava)
		# Se quiser que o jogador apareça ao lado da mula, ajuste jogador.global_position aqui.
		# Ex: jogador.global_position = self.global_position + Vector2(50, 0) # Aparece 50 pixels à direita

		montado = false
		jogador = null # Limpa a referência ao jogador
		
		sprite.visible = true # Mostra o sprite da mula "sozinha"
		sprite_montado.visible = false
		sprite.play("idle") # Garante que o sprite da mula sozinha toque a animação correta
		print_debug("Mula: Desmontagem completa.")
	elif not is_instance_valid(jogador) and montado:
		print_debug("Mula ERRO: Tentando desmontar, mas a referência do jogador é inválida.")
		# Resetar estado da mula para evitar problemas
		montado = false
		jogador = null
		sprite.visible = true
		sprite_montado.visible = false
		# Remover a câmera se ela ficou presa na mula
		var cam = get_node_or_null("Camera2D")
		if cam: remove_child(cam)
