extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    Dialogic.start("Inicio")
    Dialogic.timeline_ended.connect(_on_timeline_finished)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass

func _on_timeline_finished():
    $"Transição/AnimationPlayer".play_backwards("Fade in")
    $Timer.start()

func _on_timer_timeout() -> void:
    get_tree().change_scene_to_file("res://scenes/Vila.tscn")
