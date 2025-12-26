extends RayCast3D

@export var Track_list: Array[AudioStream]
@onready var Audio_streamer = AudioStreamPlayer3D.new()
@onready var Audio_timer = Timer.new()

@export_range(0, 1.0, 0.01) var FootstepDelay := 0.35
@export_range(0, 2.0, 0.1) var min_pitch := 0.7
@export_range(0, 2.0, 0.1) var max_pitch := 1.1
@export_range(-80.0, 80.0, 0.1) var Volume := 0.0

func _ready() -> void:
	randomize()
	FootstepDelay = get_parent().speed * 0.16
	
	add_child(Audio_streamer)
	add_child(Audio_timer)
	
	Audio_timer.wait_time = FootstepDelay
	Audio_timer.timeout.connect(_on_timer_timeout)

func Activate(a) -> void:
	if Track_list != null:
		if get_parent().velocity.length() != 0 and self.is_colliding():
			if Audio_timer.time_left <= 0:
				Audio_streamer.pitch_scale = randf_range(min_pitch,max_pitch)
				Audio_streamer.volume_db = Volume
				Audio_streamer.stream = a
				Audio_streamer.play()
				Audio_timer.start()
		else:
			Audio_streamer.stop()
			Audio_timer.stop()

func _on_timer_timeout() -> void:
	Audio_streamer.play()
