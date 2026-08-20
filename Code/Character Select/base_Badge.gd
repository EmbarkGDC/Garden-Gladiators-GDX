class_name base_badge
extends Sprite2D

var controllerID : int
var characterID : Util.PlayerCharacter
var currentPort : portrait

func getCharacter() -> void:
	currentPort = get_parent()
	currentPort.isChosen = true
	characterID = currentPort.CharacterID

func remove() -> void:
	currentPort.isChosen = false
	currentPort = null
