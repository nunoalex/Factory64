extends Camera2D

export(int) var speed = 10

var target_position = null
var drag_start = null

func _process(delta):
	if target_position != null:
		if global_position != target_position:
			if global_position.x < target_position.x:
				global_position.x += 1
			elif global_position.x > target_position.x:
				global_position.x -= 1
			if global_position.y < target_position.y:
				global_position.y += 1
			elif global_position.y > target_position.y:
				global_position.y -= 1
		else:
			target_position = null
	else:
		if Input.is_action_pressed("ui_left") and global_position.x > limit_left:
			global_position.x -= 1
		if Input.is_action_pressed("ui_right") and global_position.x < limit_right - 64:
			global_position.x += 1
		if Input.is_action_pressed("ui_up") and global_position.y > limit_top:
			global_position.y -= 1
		if Input.is_action_pressed("ui_down") and global_position.y < limit_bottom - 64:
			global_position.y += 1
		if Input.is_action_just_pressed("drag"):
			drag_start = global_position + get_viewport().get_mouse_position()
		if Input.is_action_just_released("drag"):
			drag_start = null
		if drag_start != null:
			var p = drag_start - get_viewport().get_mouse_position()
			global_position = Vector2(floor(p.x), floor(p.y))

func move_to(position):
	target_position = position - Vector2(28, 18)
