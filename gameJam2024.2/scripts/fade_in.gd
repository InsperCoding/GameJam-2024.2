extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var animation = $AnimationPlayer

func _ready() -> void:
    animation.play("comeco")
