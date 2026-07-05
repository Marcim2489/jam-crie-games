extends Control


func _ready() -> void:
	MusicPlayer.playMusic(MusicPlayer.PIANO_MEU_PIANO, 2)

func _on_play_button_pressed() -> void:
	get_tree().root.add_child(SalaManager.SFX_BUTTON_PLAYER.instantiate())
	get_tree().change_scene_to_file("res://cenas/main.tscn")
