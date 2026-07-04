extends Node2D
class_name Minimap

@export var baseMap : TileMapLayer
@export var visibleMap : TileMapLayer
@export var playerIcon : Node2D
@export var bossIcon : Node2D
@export var rareIcon1 : Node2D
@export var rareIcon2 : Node2D
@export var rareIcon3 : Node2D
@export var initialIcon : Node2D
const RARE_ICON = preload("uid://12tt7au33e7j")

func _ready() -> void:
	SalaManager.entrouNaSala.connect(mostrarSala)

func posicionarIconesRaridade(salas : Array[Vector2i]):
	rareIcon1.position = salas[0] * 16
	rareIcon2.position = salas[1] * 16
	rareIcon3.position = salas[2] * 16

func posicionarIconeBoss(coord : Vector2i):
	bossIcon.position = coord * 16

func posicionarIconeInicial(coord : Vector2i):
	initialIcon.position = coord * 16

func colocarSala(sala : Vector2i, tipoDeSala : Vector2i):
	baseMap.set_cell(sala, 1, tipoDeSala)

func mostrarSala(sala : Vector2i):
	playerIcon.position = sala * 16
	visibleMap.set_cell(sala, 0, baseMap.get_cell_atlas_coords(sala))
