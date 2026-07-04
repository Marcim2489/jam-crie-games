extends Node2D
class_name Minimap

@export var baseMap : TileMapLayer
@export var visibleMap : TileMapLayer
@export var playerIcon : Node2D

func _ready() -> void:
	SalaManager.entrouNaSala.connect(mostrarSala)

func colocarSala(sala : Vector2i, tipoDeSala : Vector2i):
	baseMap.set_cell(sala, 1, tipoDeSala)

func mostrarSala(sala : Vector2i):
	playerIcon.position = sala * 16
	visibleMap.set_cell(sala, 0, baseMap.get_cell_atlas_coords(sala))
