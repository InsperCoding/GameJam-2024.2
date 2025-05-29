extends StaticBody2D

var player_in_range = false
var rng = RandomNumberGenerator.new()

var dialogues = [
	"jefferson1",
	"jefferson2",
	"jefferson3",
	"jefferson4",
	"jefferson5",
	"jefferson6",
]

func interacao() -> void:
	var dialogue = dialogues[rng.randi() % dialogues.size()]
	Dialogic.start(dialogue)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		interacao()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		
		if Input.is_action_just_pressed("interact"):
			interacao()


func _on_area_2d_area_exited(area: Area2D) -> void:
	player_in_range = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	player_in_range = false
