extends Node2D
class_name EnemyContainer

signal todosDerrotados
var aDerrotar: int = 0
var derrotados : int = 0

func _ready() -> void:
	y_sort_enabled = true
	for inimigo in get_children():
		if inimigo is Entidade:
			aDerrotar +=1
			inimigo.morreu.connect(verificarInimigos)

func verificarInimigos():
	#for c in get_children():
		#if c is Entidade:
	derrotados += 1
	if derrotados >= aDerrotar:
		todosDerrotados.emit()
		call_deferred("queue_free")
