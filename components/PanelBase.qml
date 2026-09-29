import QtQuick

Item {
	property string label
	property alias header: header
	default property alias content: inner.data
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
	Rectangle {
		anchors{ top: header.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
		id: inner
		color: bg
	}

}
