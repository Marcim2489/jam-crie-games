extends Node2D

@export var textoColetados : Label

func _ready() -> void:
	textoColetados.text = "Produtos coletados: "+str(SalaManager.produtosColetados)

func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/menu.tscn")
