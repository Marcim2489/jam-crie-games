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

func mudarSala(direcao : Vector2i, body : Node2D):
	salaAtual += direcao
	body.global_position = Vector2i(
		salaAtual.x*tamanhoTile*tilesHorizontal*separacaoEntreSalas
		 - direcao.x*tamanhoTile*offsetHorizontal,
		salaAtual.y*tamanhoTile*tilesVertical*separacaoEntreSalas
		 - direcao.y*tamanhoTile*offsetVertical
	)
	entrouNaSala.emit(salaAtual)
	mudouSala.emit()

func setarSala(sala : Vector2i, body : Node2D):
	salaAtual = sala
	body.global_position = Vector2i(
		salaAtual.x*tamanhoTile*tilesHorizontal*separacaoEntreSalas,
		salaAtual.y*tamanhoTile*tilesVertical*separacaoEntreSalas, 
	)
	entrouNaSala.emit(salaAtual)
	mudouSala.emit()
