extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    
    Global.player_anda = false
    #Dialogic.start("Inicio")
    

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    if Dialogic.timeline_ended:
        Global.player_anda = true
    pass
