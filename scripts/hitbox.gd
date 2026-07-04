extends Node2D
class_name Hitbox

@export var dano : int = 10

signal atingiu

func emitirAtingiu():
	atingiu.emit()
