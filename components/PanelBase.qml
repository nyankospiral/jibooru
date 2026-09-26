import QtQuick

Rectangle {
	property string label
	property alias header: header
	color: fg
	Rectangle {
		id: header
		color: "#4f4f4f"
		anchors {top: parent.top; left: parent.left; right: parent.right}
		anchors.margins: 2
		height: 18

		Text {
			anchors.fill: parent
			color: "#fff"
			text: label 
		}
	}
}
