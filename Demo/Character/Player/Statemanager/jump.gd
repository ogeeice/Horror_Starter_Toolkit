extends State

func update(_delta: float) -> void:
	if !player_node.is_on_floor():
		state_machine.change_state("fall")
		
	player_node.velocity.y = player_node.jump_height
	pass

func  physics_update(_delta: float) -> void:
	pass
