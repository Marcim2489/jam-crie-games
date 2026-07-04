extends Node

var salaAtual : Vector2i

signal entrouNaSala (sala : Vector2i)
signal mudouSala

var tamanhoTile : int = 16
var tilesHorizontal = 18
var tilesVertical = 12

var offsetVertical : int = 4
var offsetHorizontal : int = 7

var separacaoEntreSalas : int = 2

@export var transicao : ColorRect
var tempoDeTransicao : float = 0.2

func _ready() -> void:
	transicao.visible = false
	transicao.self_modulate.a = 0

func mudarSala(direcao : Vector2i, body : Node2D):
	get_tree().paused = true
	transicao.visible = true
	var tween : Tween = create_tween()
	tween.tween_property(transicao, "self_modulate:a", 1, tempoDeTransicao)
	await get_tree().create_timer(tempoDeTransicao).timeout
	tween.stop()
	salaAtual += direcao
	body.global_position = Vector2i(
		salaAtual.x*tamanhoTile*tilesHorizontal*separacaoEntreSalas
		 - direcao.x*tamanhoTile*offsetHorizontal,
		salaAtual.y*tamanhoTile*tilesVertical*separacaoEntreSalas
		 - direcao.y*tamanhoTile*offsetVertical
	)
	entrouNaSala.emit(salaAtual)
	mudouSala.emit()
	await get_tree().create_timer(0.1).timeout
	var tween2 : Tween = create_tween()
	tween2.tween_property(transicao, "self_modulate:a", 0, tempoDeTransicao)
	await get_tree().create_timer(tempoDeTransicao).timeout
	tween2.stop()
	transicao.visible = false
	get_tree().paused = false

func setarSala(sala : Vector2i, body : Node2D):
	salaAtual = sala
	body.global_position = Vector2i(
		salaAtual.x*tamanhoTile*tilesHorizontal*separacaoEntreSalas,
		salaAtual.y*tamanhoTile*tilesVertical*separacaoEntreSalas, 
	)
	entrouNaSala.emit(salaAtual)
	mudouSala.emit()
