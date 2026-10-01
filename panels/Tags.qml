import QtQuick
import "../components/"

PanelBase {
	label: "Tags"
	ListView {
		anchors.fill: parent
		model: imageModel.entryAt(main.selection).keywords
		clip: true
		delegate: TagDelegate {} 
	}
}
