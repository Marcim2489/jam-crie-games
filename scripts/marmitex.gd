extends Area2D

func _ready() -> void:
	body_entered.connect(onBodyEntered)

func onBodyEntered(body : Node2D):
	if body is Player:
		body.hurtbox.curar(20)
		call_deferred("queue_free")
