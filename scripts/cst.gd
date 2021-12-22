extends Node


# action ids
enum MainMenuID{
	FILE_NEW,
	FILE_OPEN,
	FILE_SAVE,
	FILE_CLOSE,
	FILE_IMPORT,
	FILE_EXPORT,
	
	UNDO,
	REDO,
	
	SEL_ALL,
	SEL_NONE,
	
	OPEN_PREFERENCE,
}

const GLOBAL_DIALOG_ROOT = "/root/GUIRoot/GlobalDialogs/"
const EXPORT_PNG_DIALOG = GLOBAL_DIALOG_ROOT + "ExportPNGDialog"
const IMPORT_PNG_DIALOG = GLOBAL_DIALOG_ROOT + "ImportPNGDialog"
const PREFERENCE_DIALOG = GLOBAL_DIALOG_ROOT + "PreferencesDialog"

enum TreeButton{
	VISIBEL,
	MV_UP,
	MV_DOWN,
	DUP,
}

enum BGMenuID{
	ADD_REF,
	RESET_CANVAS,
	
}
