extends CharacterBody2D
class_name Player

class_name Player

const SPEED = 300.0
var current_dir = "none"
var direcao = null
var inventario = []

func _ready() -> void:
	$AnimatedSprite2D.play("down_idle")
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	
func _on_spawn(position: Vector2, direction: String):
	global_position = position


func _physics_process(delta: float) -> void:
	if Global.player_anda:
		player_movement(delta)

func player_movement(delta):
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
