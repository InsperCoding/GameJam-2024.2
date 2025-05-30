extends Node2D
class_name MulaMulher

@onready var sprite = $Sprite2D

const SPRITE_SIZE = Vector2(400, 600)  # Tamanho de cada sprite no spritesheet

var sprite_regions = {
	"down": Rect2(Vector2(0, 0), SPRITE_SIZE),
	"left": Rect2(Vector2(400, 0), SPRITE_SIZE),
	"up": Rect2(Vector2(800, 0), SPRITE_SIZE),
	"right": Rect2(Vector2(1200, 0), SPRITE_SIZE)
}

func _ready():
	sprite.region_enabled = true
	sprite.region_rect = sprite_regions["down"]

func on_player_interact(player_global_position: Vector2):
	var diff = player_global_position - global_position
	var direction = diff.normalized()

	if abs(diff.x) > abs(diff.y):
		if diff.x > 0:
			sprite.region_rect = sprite_regions["right"]
		else:
			sprite.region_rect = sprite_regions["left"]
	else:
		if diff.y > 0:
			sprite.region_rect = sprite_regions["down"]
		else:
			sprite.region_rect = sprite_regions["up"]
