extends Label

var pausado : bool = false
var botao1Decido : bool = false
var botao2Decido : bool = false
var botao3Decido : bool = false

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if botao1Decido or botao2Decido or botao3Decido:
		return
	if event.is_action_pressed("resetar"):
		togglePause()

func togglePause():
	if get_tree().paused:
		if pausado:
			pausado = false
			visible = false
			get_tree().paused = false
	else:
		if pausado == false:
			pausado = true
			visible = true
			get_tree().paused = true

func _on_resume_pressed() -> void:
	togglePause()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenas/menu.tscn")


func _on_resume_button_down() -> void:
	botao1Decido = true

func _on_restart_button_down() -> void:
	botao2Decido = true

func _on_menu_button_down() -> void:
	botao3Decido = true

func _on_resume_button_up() -> void:
	botao1Decido = false

func _on_restart_button_up() -> void:
	botao2Decido = false

func _on_menu_button_up() -> void:
	botao3Decido = false
