extends CharacterBody2D
class_name Entidade

@export var velocidadeMovimento : int = 100
@export var hurtbox : Hurtbox
@export var guardaProjetil : Node

signal morreu

func _ready() -> void:
	if(hurtbox != null):
		hurtbox.morreu.connect(morrer)

func morrer():
	morreu.emit()
	call_deferred("queue_free")
