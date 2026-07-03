extends Node

var salaAtual : Vector2i

signal entrouNaSala (sala : Vector2i)

func mudarSala(direcao : Vector2i, body : Node2D):
	salaAtual += direcao
	body.global_position = Vector2i(
		salaAtual.x*16*18*2 - direcao.x*16*7,
		salaAtual.y*16*12*2 - direcao.y*16*4, 
	)
	entrouNaSala.emit(salaAtual)

func setarSala(sala : Vector2i, body : Node2D):
	salaAtual = sala
	body.global_position = Vector2i(
		salaAtual.x*16*18*2,
		salaAtual.y*16*12*2, 
	)
	entrouNaSala.emit(salaAtual)
