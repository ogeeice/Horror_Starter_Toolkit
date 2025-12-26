@tool
extends EditorPlugin


func _enable_plugin() -> void:
	# Add autoloads here.
	pass


func _disable_plugin() -> void:
	# Remove autoloads here.
	pass


func _enter_tree() -> void:
	add_custom_type("Door","Area3D",preload("res://addons/horror_toolkit/door/door.gd") ,preload("res://addons/horror_toolkit/icons/door.svg"))
	add_custom_type("Dynamic Footsteps","RayCast3D",preload("res://addons/horror_toolkit/dynamic_footsteps/dynamic_footsteps.gd") ,preload("res://addons/horror_toolkit/icons/footsteps.svg"))
	add_custom_type("Fan Switch","Area3D",preload("res://addons/horror_toolkit/fan_switch/fan_switch.gd") ,preload("res://addons/horror_toolkit/icons/fan.svg"))
	add_custom_type("Item","Area3D",preload("res://addons/horror_toolkit/item/item.gd") ,preload("res://addons/horror_toolkit/icons/item.svg"))
	add_custom_type("Light Switch","Area3D",preload("res://addons/horror_toolkit/light_switch/light_switch.gd") ,preload("res://addons/horror_toolkit/icons/switch.svg"))
	add_custom_type("Random Sounds","Area3D",preload("res://addons/horror_toolkit/random_sound/random_sound.gd") ,preload("res://addons/horror_toolkit/icons/random_sounds.svg"))
	add_custom_type("Torchlight","SpotLight3D",preload("res://addons/horror_toolkit/torchlight/torchlight.gd") ,preload("res://addons/horror_toolkit/icons/torch.svg"))


func _exit_tree() -> void:
	remove_custom_type("Door")
	remove_custom_type("Dynamic Footsteps")
	remove_custom_type("Fan Switch")
	remove_custom_type("Item")
	remove_custom_type("Light Switch")
	remove_custom_type("Random Sounds")
	remove_custom_type("Torchlight")
