extends Node2D

func _ready() -> void:
	MusicPlayer.playMusic(MusicPlayer.VIOLA_MINHA_VIOLA)

func _on_restart_pressed() -> void:
	
	get_tree().root.add_child(SalaManager.SFX_BUTTON_PLAYER.instantiate())
	get_tree().change_scene_to_file("res://cenas/main.tscn")
