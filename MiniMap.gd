extends MarginContainer


#var player = preload("res://Player.tscn")
onready var player = $"/root/Player"
export var zoom = 1.5

onready var grid = $MarginContainer/Grid
onready var player_marker = $MarginContainer/Grid/PlayerMarker
onready var mob_marker = $MarginContainer/Grid/MobMarker
#onready var alert_marker = $MarginContainer/Grid/AlertMarker
onready var icons = {"mob": mob_marker}

var grid_scale
var markers = {}

func _ready():
	player_marker.position = grid.rect_size / 2
	grid_scale = grid.rect_size / (get_viewport_rect().size * zoom)
	var map_objects = get_tree().get_nodes_in_group("minimap_objects")
	for item in map_objects:
		var new_marker = icons[item.minimap_icon].duplicate()
		grid.add_child(new_marker)
		new_marker.show()
		markers[item] = new_marker

func _process(delta):
	if !player:
		return
	player_marker.rotation = get_node(player).rotation + PI/2
	for item in markers:
		var obj_pos = (item.position - get_node(player).position) * grid_scale + grid.rect_size / 2
		markers[item].position = obj_pos
		obj_pos.x = clamp(obj_pos.x, 0, grid.rect_size.x)
		obj_pos.y = clamp(obj_pos.y, 0, grid.rect_size.y)
		if grid.get_rect().has_point(obj_pos + grid.rect_position):
			markers[item].scale = Vector2(0.75, 0.75)
		else:
			markers[item].scale = Vector2(1, 1)
