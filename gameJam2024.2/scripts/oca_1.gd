extends RigidBody2D


# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_porta_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if Input.is_action_just_pressed("interact"):
			Dialogic.start("Inicio")
