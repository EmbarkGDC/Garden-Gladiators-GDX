class_name base_badge
extends Sprite2D

var controllerID : int
var characterID : Util.PlayerCharacter
var currentPort : portrait
var badge_labels: Array[Node2D]

func _ready() -> void:
	badge_labels = [$BadgeLabelP1, $BadgeLabelP2, $BadgeLabelP3, $BadgeLabelP4]

func set_label(player: int):
	badge_labels[player].visible = true

func getCharacter() -> Util.PlayerCharacter:
	currentPort = get_parent()
	currentPort.isChosen = true
	characterID = currentPort.CharacterID
	return characterID

func remove() -> void:
	currentPort.isChosen = false
	currentPort = null
