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
	MERGE_DOWN,
	DELETE,
}

enum TreeMenu{
	RENAME,
	DUP,
	DELETE,
	MERGE_DOWN,
}

enum BGMenuID{
	ADD_REF,
	RESET_CANVAS,
	
}

enum BodyPartID{
	HEAD,
	BODY,
	ARM_R,
	ARM_L,
	LEG_R,
	LEG_L,
	
	HEAD2,
	BODY2,
	ARM_R2,
	ARM_L2,
	LEG_R2,
	LEG_L2,
}
