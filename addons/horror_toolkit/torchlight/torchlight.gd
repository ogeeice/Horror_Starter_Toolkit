extends SpotLight3D

@export var Player_Camera : Camera3D
@export var Torch_Action_name : String
@onready var Remote_Follow = RemoteTransform3D.new()

@export_group("Torch Battery","Battery")
@export var Battery_Enabled : bool
@export_range(0, 100, 1) var Battery_Value : int
@export_range(0, 100, 1) var Battery_max_Value : int
@export_range(0, 100, 1) var Battery_Amount : int
@export_range(0, 100, 1) var Battery_max_Amount : int
@export_range(0, 5.0, 0.1) var Battery_drain_Speed : float
@onready var Battery_Timer = Timer.new()

@export_group("light flickering", "flicker")
@export var flicker_enabled : bool = false ## Determines if the light source flickers
@export_range(0, 10.0, 0.1) var flicker_start : float
@export_range(0, 10.0, 0.1) var flicker_min_energy : float ## Determines the minimum light source flicker energy amount
@export_range(0, 10.0, 0.1) var flicker_max_energy : float ## Determines the maximum light source flicker energy amount
@onready var default_energy = self.light_energy
var flicker_tween

func _ready() -> void:
	randomize()
	follow_camera()
	timer_create()
	self.visible = false
	self.add_to_group("torchlight")
	
	if Battery_Timer != null:
		Battery_Timer.timeout.connect(_on_timer_timeout)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed(Torch_Action_name):
		if Battery_Timer != null:
			if Battery_Enabled == true:
				if Battery_Timer.time_left > 0.0:
					Battery_Timer.stop()
					self.visible = false
					Battery_Timer.wait_time = 0.1
				else:
					Battery_Timer.start()
					Battery_Timer.wait_time = Battery_drain_Speed
			else:
				self.visible = !self.visible

func _process(_delta: float) -> void:
	value_clamp()

func follow_camera() -> void:
	Player_Camera.add_child(Remote_Follow)
	if Remote_Follow != null:
		Remote_Follow.remote_path = self.get_path()
		Remote_Follow.update_scale = false

func timer_create() -> void:
	self.add_child(Battery_Timer)
	if Battery_Timer != null:
		Battery_Timer.wait_time = 0.1

func value_clamp() -> void:
	Battery_Value = clampi(Battery_Value, 0.0, Battery_max_Value)
	Battery_Amount = clampi(Battery_Amount, 0.0, Battery_max_Amount)

func _on_timer_timeout() -> void:
	if Battery_Enabled == true:
		if Battery_Amount > 0.0:
			flickering()
			
			if Battery_Value > 0.0:
				Battery_Value -= 1.0
			else:
				Battery_Amount -= 1.0
				Battery_Value = Battery_max_Value
			self.visible = true
		else:
			self.visible = false

func flickering() -> void:
	if Battery_Value < flicker_start:
		flicker_tween = get_tree().create_tween().set_loops(0)
		flicker_tween.tween_property(self,"light_energy",randf_range(flicker_min_energy,flicker_max_energy),0.25).set_delay(randf_range(0.1, 0.5))
	else:
		if flicker_tween != null:
			if flicker_tween.is_running() == true:
				flicker_tween.stop()
			self.light_energy = default_energy
