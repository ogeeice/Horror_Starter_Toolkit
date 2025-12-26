extends Area3D

@export var light_source : Node3D ## variable to hold light source node path
@export var enabled : bool = true ## Determines if the player can interact with light
@export var active : bool  = true  ## Determines if the light switch is active on or not.
@onready var default_energy = light_source.light_energy

@export_group("light flickering", "flicker")
@export var flicker_enabled : bool = false ## Determines if the light source flickers

@export_range(0, 10.0, 0.1) var flicker_min_energy : float ## Determines the minimum light source flicker energy amount
@export_range(0, 15.0, 0.1) var flicker_max_energy : float ## Determines the maximum light source flicker energy amount

var flicker_tween

func _ready() -> void:
	randomize()
	self.add_to_group("interactive")
	default_energy = light_source.light_energy
	
	interact(true)

func _process(delta: float) -> void:
	pass

func interact(start:= false)-> void:
	if start == false:
		active = !active
		if enabled == true:
			flicker()
			light_source.visible = active
	else:
		flicker()
		light_source.visible = active

func flicker()-> void:
	if active == true:
		if flicker_enabled == true:
			flicker_tween = get_tree().create_tween().set_loops()
			
			flicker_tween.tween_property(light_source,"light_energy",randf_range(flicker_min_energy,flicker_max_energy),0.05).set_delay(randf_range(0.01, 0.1))
			flicker_tween.tween_property(light_source,"light_energy",randf_range(flicker_min_energy,flicker_max_energy),0.25).set_delay(randf_range(0.1, 0.25))
		else:
			if flicker_tween != null:
				if flicker_tween.is_running() == true:
					flicker_tween.stop()
				light_source.light_energy = default_energy

func _exit_tree() -> void:
	if flicker_tween != null:
		flicker_tween.kill()
