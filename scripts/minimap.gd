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
var salaBoss : Vector2i
var salaInicio : Vector2i
var salaRara1 : Vector2i
var salaRara2 : Vector2i
var salaRara3 : Vector2i

func _ready() -> void:
	SalaManager.entrouNaSala.connect(mostrarSala)
	bossIcon.visible = false
	initialIcon.visible = false
	rareIcon1.visible = false
	rareIcon2.visible = false
	rareIcon3.visible = false

func posicionarIconesRaridade(salas : Array[Vector2i]):
	salaRara1 = salas[0]
	rareIcon1.position = salaRara1 * 16
	salaRara2 = salas[1]
	rareIcon2.position = salaRara2 * 16
	salaRara3 = salas[2]
	rareIcon3.position = salaRara3 * 16

func posicionarIconeBoss(coord : Vector2i):
	salaBoss = coord
	bossIcon.position = salaBoss * 16

func posicionarIconeInicial(coord : Vector2i):
	salaInicio = coord
	initialIcon.position = salaInicio * 16

func colocarSala(sala : Vector2i, tipoDeSala : Vector2i):
	baseMap.set_cell(sala, 1, tipoDeSala)

func mostrarSala(sala : Vector2i):
	playerIcon.position = sala * 16
	if sala == salaBoss:
		bossIcon.visible = true
	if sala == salaInicio:
		initialIcon.visible = true
	if sala == salaRara1:
		rareIcon1.visible = true
	if sala == salaRara2:
		rareIcon2.visible = true
	if sala == salaRara3:
		rareIcon3.visible = true
	visibleMap.set_cell(sala, 0, baseMap.get_cell_atlas_coords(sala))
