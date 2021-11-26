extends PanelContainer

export (NodePath) var _users_vb_path
onready var _users_vb = get_node(_users_vb_path)
var _user_scene = preload("res://components/UsersListUser.tscn")

var users = [
	{
		"avatar": preload("res://assets/avatar_icons/321233875776962560.webp"),
		"tag": "3ddelano#6033",
		"activity": "Playing Discord Clone App",
		"status": "DND",
		"bot": false
	},
	{
		"avatar": preload("res://assets/avatar_icons/332140864853901313.webp"),
		"tag": "Delano Tatsumi#8248",
		"activity": "Watching 3!help",
		"status": "ONLINE",
		"bot": true
	},
	{
		"avatar": preload("res://assets/avatar_icons/907892129630662667.webp"),
		"tag": "Delano's RPG#0137",
		"activity": "Playing Godot Engine",
		"status": "IDLE",
		"bot": true
	},
]


func _ready() -> void:
	Datastore.connect("users_list_visible", self, "_on_users_list_visible")
	_load_users()

func _on_users_list_visible(users_list_visible):
	visible = users_list_visible

func _load_users():
	for child in _users_vb.get_children():
		child.queue_free()

	for k in range(5):
		for i in range(users.size()):
			var user_data = users[i]

			var model = UserModel.new(Utils.uuid(), user_data.tag, user_data.avatar, user_data.bot, user_data.activity, user_data.status)

			var user = _user_scene.instance()
			_users_vb.add_child(user)
			user.from_model(model)