extends AudioStreamPlayer

func _ready() -> void:
	finished.connect(acabou)

func acabou():
	call_deferred("queue_free")
