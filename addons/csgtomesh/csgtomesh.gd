@tool
extends EditorPlugin

var csg_toolbar: Control
var scene_tree: EditorSelection

func _enter_tree() -> void:
#	print("Enter tree")
	csg_toolbar = preload("res://addons/csgtomesh/csg_toolbar.tscn").instantiate()
	add_control_to_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, csg_toolbar)
	scene_tree = get_editor_interface().get_selection()
	scene_tree.selection_changed.connect(_on_scene_tree_selection_changed)
	

func _exit_tree() -> void:
#	print("Exit tree")
	remove_control_from_container(EditorPlugin.CONTAINER_SPATIAL_EDITOR_MENU, csg_toolbar)
	csg_toolbar.free()

#func _handles(object) -> bool:
#
#	if object is CSGShape3D and object.is_root_shape():
#		csg_toolbar.visible = true
#		csg_toolbar.csg_root_node = object
#	else:
#		csg_toolbar.visible = false
#	return false

func _on_scene_tree_selection_changed() -> void:
	if scene_tree.get_selected_nodes().size() == 1:
		var object = scene_tree.get_selected_nodes()[0]
		if object is CSGShape3D and object.is_root_shape():
			print("%s selected!" % [scene_tree.get_selected_nodes()])
			csg_toolbar.visible = true
			csg_toolbar.csg_root_node = object
		else:
			csg_toolbar.visible = false
	else:
		print("selection not available")
		csg_toolbar.visible = false

