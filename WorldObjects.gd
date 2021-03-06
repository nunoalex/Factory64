extends Node

var objects : Array = []

func init() -> void:
	for x in range(50*8):
		var col = []
		col.resize(50*8)
		objects.append(col)

func reset() -> void:
	for row in objects:
		for obj in row:
			obj.queue_free()
	objects = []
#	for obj in objects.values():
#		obj.queue_free()
#	objects = {}

func add(obj: MovableObject, position: Vector2) -> void:
	if objects[position.x][position.y] == null:
		objects[position.x][position.y] = obj
#	var id := get_id(position)
#	if objects.has(id):
#		pass
#	objects[id] = obj

#func get_id(position: Vector2) -> String:
#	return "%d,%d" % [position.x, position.y]

func has_at(position: Vector2) -> bool:
	return objects[position.x][position.y] != null
#	return objects.has(get_id(position))

func get_at(position: Vector2) -> MovableObject:
	return objects[position.x][position.y]
#	if has_at(position):
#		return objects[get_id(position)]
#	else:
#		return null

#func id_to_pos(id: String) -> Vector2:
#	var parts := id.split(",")
#	return Vector2(int(parts[0]), int(parts[1]))

func can_move(obj: MovableObject, new_pos: Vector2) -> bool:
#	var movement = new_pos - obj.global_position
#	var next_ids = [get_id(new_pos)]
#	if obj.type > Constants.ObjectType.GOLD_ORE:
#		next_ids.append(get_id(new_pos + movement))
#	for next_id in next_ids:
#		if objects.has(next_id):
#			return false
#
#	# can't move there if the tile isn't accepting it
#	var tile := WorldTiles.get_at(new_pos)
#	if tile == null:
#		return false
#	return tile.is_valid_obj_pos(new_pos)

	var movement := new_pos - obj.global_position
	var next_pos := new_pos + movement
	if objects[new_pos.x][new_pos.y]:
		return false
		
	if obj.type > Constants.ObjectType.GOLD_ORE and objects[next_pos.x][next_pos.y] != null:
		return false

	# can't move there if the tile isn't accepting it
	var tile := WorldTiles.get_at(new_pos)
	if tile == null:
		return false
	return tile.is_valid_obj_pos(new_pos)

# check if there are other moveable objects where we want to go
func try_move(obj: MovableObject, new_pos: Vector2) -> bool:
#	if can_move(obj, new_pos):
#		var id := get_id(obj.global_position)
#		var new_id := get_id(new_pos)
#		if objects.has(id) and objects.erase(id):
#			objects[new_id] = obj
#		return true
#	else:
#		return false
	if can_move(obj, new_pos):
		objects[obj.global_position.x][obj.global_position.y] = null
		objects[new_pos.x][new_pos.y] = obj
		return true
	else:
		return false

func destroy(obj: MovableObject) -> void:
	objects[obj.global_position.x][obj.global_position.y] = null
#	var id = get_id(obj.global_position)
#	if objects.has(id) and not objects.erase(id):
#		push_error("could not destroy an item while destroying it")

func rotate_tile_contents(position: Vector2, angle: float) -> void:
#	# find all the objects within this tile
#	var pivot := position + Vector2(4, 4)
#	var objects_to_rotate := []
#	for x in range(pivot.x - 4, pivot.x + 4):
#		for y in range(pivot.y - 4, pivot.y + 4):
#			var id := get_id(Vector2(x, y))
#			if objects.has(id):
#				objects_to_rotate.append(objects[id])
#				if not objects.erase(id):
#					push_error("could not destroy an object while rotating it")
#	for obj in objects_to_rotate:
#		# to do a perfect rotation we need to set the pivot to the center of the pixel
#		var rotation : Vector2 = (obj.global_position - pivot + Vector2(0.5, 0.5)).rotated(deg2rad(angle))
#		var new_pos := rotation + pivot
#		obj.global_position = new_pos - Vector2(0.5, 0.5)
#		objects[get_id(obj.global_position)] = obj
	
	# find all the objects within this tile
	var pivot := position + Vector2(4, 4)
	var objects_to_rotate := []
	for x in range(pivot.x - 4, pivot.x + 4):
		for y in range(pivot.y - 4, pivot.y + 4):
			if objects[x][y] != null:
				objects_to_rotate.append(objects[x][y])
				objects[x][y] = null
	for obj in objects_to_rotate:
		# to do a perfect rotation we need to set the pivot to the center of the pixel
		var rotation : Vector2 = (obj.global_position - pivot + Vector2(0.5, 0.5)).rotated(deg2rad(angle))
		var new_pos := rotation + pivot
		obj.global_position = new_pos - Vector2(0.5, 0.5)
		objects[obj.global_position.x][obj.global_position.y] = obj
