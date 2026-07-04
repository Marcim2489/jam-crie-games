extends Area2D
class_name Coletavel

@export var tipo : Player.Produtos

func _ready() -> void:
	body_entered.connect(onBodyEntered)

func onBodyEntered(body : Node2D):
	if body is Player:
		body.coletarProduto(tipo)
		call_deferred("queue_free")
