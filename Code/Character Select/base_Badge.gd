class_name base_badge
extends Sprite2D

var controllerID : int
var characterID : Util.PlayerCharacter
var currentPort : portrait

func getCharacter() -> Util.PlayerCharacter:
	currentPort = get_parent()
	currentPort.isChosen = true
	characterID = currentPort.CharacterID
	return characterID

func remove() -> void:
	currentPort.isChosen = false
	currentPort = null
