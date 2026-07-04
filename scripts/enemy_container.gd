extends Node2D
class_name EnemyContainer

signal todosDerrotados

func _ready() -> void:
	for inimigo : Entidade in get_children():
		inimigo.morreu.connect(verificarInimigos)

func verificarInimigos():
	if get_children().size()-1 <= 0:
		todosDerrotados.emit()
		call_deferred("queue_free")
