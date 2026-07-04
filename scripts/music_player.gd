extends AudioStreamPlayer

const VIOLA_MINHA_VIOLA : AudioStream = preload("uid://bh3t8oyj7emer")

func playMusic(music : AudioStream):
	if music == stream:
		return
	stream = music
	play()
