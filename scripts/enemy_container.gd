extends Node2D
class_name EnemyContainer

signal todosDerrotados

func _ready() -> void:
	y_sort_enabled = true
	for inimigo in get_children():
		if inimigo is Entidade:
			inimigo.morreu.connect(verificarInimigos)

func verificarInimigos():
	var inimigos : Array[Entidade]
	for c in get_children():
		if c is Entidade:
			inimigos.append(c)
	if inimigos.size()-1 <= 0:
		todosDerrotados.emit()
		call_deferred("queue_free")
