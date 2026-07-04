extends Area2D
class_name Porta

enum Direcoes {CIMA, BAIXO, DIREITA, ESQUERDA}

@export var direcao : Direcoes
@export var colisao : CollisionShape2D
@export var visualColisao : Node2D

func _enter_tree() -> void:
	body_entered.connect(onBodyEntered)

func _ready() -> void:
	var sala = get_parent()
	if sala is Sala:
		sala.ativada.connect(ativarColisao)
		sala.concluida.connect(desativarColisao)

func ativarColisao():
	colisao.set_deferred("disabled", false)
	visualColisao.visible = true

func desativarColisao():
	colisao.set_deferred("disabled", true)
	visualColisao.visible = false

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
