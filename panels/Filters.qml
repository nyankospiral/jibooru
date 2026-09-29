import QtQuick
import QtQuick.Controls
import "../components/"

PanelBase {
	label: "Filters"


	TextField {
		id: tagInput
		anchors { top: parent.top; left: parent.left; right: parent.right }
		height: 20

		onAccepted: {
			filters.push(this.text)
			this.clear()
		}
	}

	ListView {
		id: tagDisplay
		anchors { top: tagInput.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
		model: filters 
		clip: true

		delegate: TagDelegate { isFilter: true } 
	}
	
}
