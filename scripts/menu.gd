extends Control

func _ready() -> void:
	MusicPlayer.playMusic(MusicPlayer.VIOLA_MINHA_VIOLA)

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/main.tscn")
