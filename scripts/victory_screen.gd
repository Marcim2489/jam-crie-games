extends Node2D

@export var textoColetados : Label
const VITORIA_2 = preload("uid://b3g2jw5b22bvr")

func _ready() -> void:
	MusicPlayer.playMusic(VITORIA_2)
	textoColetados.text = "Produtos coletados: "+str(SalaManager.produtosColetados)

func _on_restart_pressed() -> void:
	get_tree().root.add_child(SalaManager.SFX_BUTTON_PLAYER.instantiate())
	get_tree().change_scene_to_file("res://cenas/menu.tscn")
