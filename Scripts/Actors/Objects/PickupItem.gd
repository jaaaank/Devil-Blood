extends Area2D
class_name PickupItem

@export var item: itemType

func _on_area_entered(area):
	if area.is_in_group("playerHurtbox"):
		PlayerAutoload.inventory.append(item)
		area.get_parent().get_node("UI/SelectionWheel").slots = PlayerAutoload.inventory
		print(PlayerAutoload.inventory)
		$SfxrStreamPlayer.play()
		$CollisionShape2D.disabled = true
		visible = false


func _on_sfxr_stream_player_finished():
	queue_free()
