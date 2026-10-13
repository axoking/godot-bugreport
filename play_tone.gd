extends Node

@onready var player = $AudioStreamPlayer
@onready var sample_hz = player.stream.mix_rate
var pulse_hz = 440.0
var playback
var phase = 0.0

func _ready() -> void:
	player.play()
	playback = player.get_stream_playback()
	
	# This fills the buffer with a sine wave for a few seconds
	fill_buffer()
	print("Buffer full!")
	
	# This should clear the buffer so the sine wave actually shouldn't last a few seconds
	playback.clear_buffer()
	print("Buffer empty!")

func fill_buffer():
	var increment = pulse_hz / sample_hz
	var frames_available = playback.get_frames_available()

	for i in range(frames_available):
		playback.push_frame(Vector2.ONE * sin(phase * TAU))
		phase = fmod(phase + increment, 1.0)
