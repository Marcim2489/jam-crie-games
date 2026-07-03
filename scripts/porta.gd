extends Area2D
class_name Porta

enum Direcoes {CIMA, BAIXO, DIREITA, ESQUERDA}

@export var direcao : Direcoes

func _enter_tree() -> void:
	body_entered.connect(onBodyEntered)

func onBodyEntered(body : Node2D):
	if body is Player:
		match direcao:
			Direcoes.CIMA:
				SalaManager.mudarSala(Vector2i.UP, body)
			Direcoes.BAIXO:
				SalaManager.mudarSala(Vector2i.DOWN, body)
			Direcoes.DIREITA:
				SalaManager.mudarSala(Vector2i.RIGHT, body)
			Direcoes.ESQUERDA:
				SalaManager.mudarSala(Vector2i.LEFT, body)
