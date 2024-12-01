extends Node2D

# Lista com os TileMaps
@export var tilemaps: Array = []

# Índice do TileMap atualmente visível
var current_tilemap_index: int = 0

func _ready():
    # Certifique-se de que apenas o primeiro TileMap está visível ao iniciar
    for i in range(tilemaps.size()):
        tilemaps[i].visible = (i == current_tilemap_index)

func _switch_tilemap():
    # Torna o TileMap atual invisível
    tilemaps[current_tilemap_index].visible = false
    
    # Avança para o próximo TileMap (ciclo)
    current_tilemap_index = (current_tilemap_index + 1) % tilemaps.size()
    
    # Torna o próximo TileMap visível
    tilemaps[current_tilemap_index].visible = true
