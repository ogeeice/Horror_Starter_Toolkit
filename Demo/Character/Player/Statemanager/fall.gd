extends State


func  update(_delta: float) -> void:
	pass

func  physics_update(delta: float) -> void:
	if player_node.is_on_floor():
		state_machine.change_state("idle")
	
	if player_node.velocity.y < 0:
		player_node.velocity.y -= player_node.fall_gravity * delta
	else:
		player_node.velocity += player_node.get_gravity() * delta
	pass
