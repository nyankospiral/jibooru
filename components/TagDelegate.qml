import QtQuick
import QtQuick.Controls
import "../components/"
import jibooru_modules

ItemDelegate {
	property bool isFilter
	property color highlightColor: isFilter ? "#60ff6347" : "#6098fb98"

	height: 20
	width: parent.width
	text: modelData
	background: Rectangle {
		anchors.fill: parent
		color: Qt.tint(
			(index % 2 ? AppSettings.sysPal.mid : AppSettings.sysPal.dark), 
			(hovered ? highlightColor : "transparent")
		)
		Behavior on color {
			ColorAnimation {duration: 120}
		}
	}
	onClicked: { 
		if (isFilter){
			filters.splice(index, 1) 
		} else {
			filters.push(modelData)
		}
	}
}
