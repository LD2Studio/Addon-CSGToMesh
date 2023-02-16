@tool
extends MenuButton

signal mesh_changed(mesh)

enum {
	CONVERT_TO_ARRAYMESH,
}

var csg_root_node: CSGShape3D
var mesh_array

func _ready() -> void:
	visible = false
	get_popup().add_item("Convert CSG mesh to ArrayMesh", CONVERT_TO_ARRAYMESH)
	get_popup().id_pressed.connect(_on_csg_toolbar_item_pressed)

func _on_csg_toolbar_item_pressed(id: int) -> void:
	print(csg_root_node)
	csg_root_node._update_shape()
	mesh_array = csg_root_node.get_meshes()
	print(mesh_array)
	$SaveMeshResourceDialog.current_file = csg_root_node.name + ".tres"
	$SaveMeshResourceDialog.popup_centered(Vector2i(300,300))

func _on_save_mesh_resource_dialog_file_selected(path: String) -> void:
	
	ResourceSaver.save(mesh_array[1], $SaveMeshResourceDialog.current_path)
	mesh_changed.emit($SaveMeshResourceDialog.current_path)
