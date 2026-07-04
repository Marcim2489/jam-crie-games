extends Node2D
class_name Sala

var coordenada : Vector2i
var derrotada : bool = false
var salasViajadas : int = 0
var salasParaReativar : int = 5
#const ENEMY_CONTAINER_1 = preload("uid://pkyur02kr0cy")
#const ENEMY_CONTAINER_2 = preload("uid://bkw3t2b2blts1")
const CONTAINERS : Array = [
	preload("uid://pkyur02kr0cy"),
	preload("uid://bkw3t2b2blts1")]
signal ativada
signal concluida

func _ready() -> void:
	SalaManager.entrouNaSala.connect(aoMudarSala)

func aoMudarSala(coord : Vector2i):
	if coord != coordenada:
		for c in get_children():
			if c is EnemyContainer:
				c.call_deferred("queue_free")
		if derrotada == false:
			return
		salasViajadas+=1
		if salasViajadas >= salasParaReativar:
			derrotada = false
		return
	if derrotada:
		return
	spawnarInimigos()

func spawnarInimigos():
	#print("inimigos")
	ativada.emit()
	var container : EnemyContainer = CONTAINERS.pick_random().instantiate()
	add_child(container)
	container.global_position = global_position
	container.todosDerrotados.connect(aoDerrotar)
	#derrotada = true

func aoDerrotar():
	derrotada = true
	concluida.emit()
