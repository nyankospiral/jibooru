import QtQuick
import QtQuick.Controls
import "../components/"

Rectangle {
	property bool isFilter
	property color highlightColor: isFilter ? "#60ff6347" : "#6098fb98"

	height: 20
	width: parent.width
	color: Qt.tint((index % 2 ? fg : bg), (tagMouseArea.containsMouse ? highlightColor : "transparent"))

	Text{
		id: tagNameText
		anchors.fill: parent
		anchors.leftMargin: 5
		color: "white"
		text: modelData
	}

	MouseArea {
		id: tagMouseArea
		anchors.fill: parent
		hoverEnabled: true
		onClicked: { 
			if (isFilter){
				filters.splice(index, 1) 
			} else {
				filters.push(modelData)
			}
		}

	}

	Behavior on color {
		ColorAnimation {duration: 120}
	}
}
