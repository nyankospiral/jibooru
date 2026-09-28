import QtQuick
import QtQuick.Controls
import "../components/"

PanelBase {
	label: "Tags"

	Column {
		anchors {top: header.bottom; left: parent.left; right: parent.right}
		Repeater{
			property var selection: imageModel.entryAt(main.selection).keywords

			model: selection 
			Text{
				anchors.leftMargin: 5
				color: "white"
				text: modelData
			}
		}
	}
}
