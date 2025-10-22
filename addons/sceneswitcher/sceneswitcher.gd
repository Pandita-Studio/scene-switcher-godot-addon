class_name SceneSwitcherHandler
extends Node

signal finished

const PROPERTY_NAME_TRANSITION_DELAY = "plugins/scene_swicther/transition_delay"
const PROPERTY_NAME_FADE_DURATION = "plugins/scene_swicther/fade_duration"

@onready var black_rect: SceneSwitcherBlackRect = preload("res://addons/sceneswitcher/nodes/blackrect/black_rect.tscn").instantiate()
@onready var transition_delay: float = ProjectSettings.get_setting(PROPERTY_NAME_TRANSITION_DELAY, 2.0)


func _ready() -> void:
	if not Engine.is_editor_hint():
		get_tree().root.call_deferred("add_child", black_rect)
	
	await get_tree().create_timer(transition_delay).timeout
	
	black_rect.fade_out()
	await Signal(black_rect, "finished")
	
	finished.emit()


func switch_to(p_scene_path: String):
	assert(FileAccess.file_exists(p_scene_path), "Scene path doesn't exists (%s)" % [p_scene_path])
	
	black_rect.fade_in()
	await Signal(black_rect, "finished")
	
	var error: Error = get_tree().change_scene_to_file(p_scene_path)
	assert(error == OK, "Error changing to scene %s" % [p_scene_path])
	
	await get_tree().create_timer(transition_delay).timeout
	
	black_rect.fade_out()
	await Signal(black_rect, "finished")
	
	finished.emit()
