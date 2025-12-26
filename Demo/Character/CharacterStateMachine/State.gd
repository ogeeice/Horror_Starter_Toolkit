class_name State extends Node

var state_machine: StateMachine = self.get_parent()
@onready var player_node: CharacterBody3D = self.get_parent().get_parent()

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
