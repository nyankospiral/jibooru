import QtQuick

Item {
	Image {
		id: image
		anchors.fill: parent
		source: ""
		fillMode: Image.PreserveAspectFit
	}

	Rectangle {
		anchors {top: parent.top; left: parent.left}
		anchors.margins: 10
		width: 20; height: width
		radius: 180
		color: "red"
		MouseArea {
			anchors.fill: parent
			onClicked: {rootImageContainerStack.currentIndex = 0; image.source = "";}
		}
	}
	function setSource(url: url) {
		image.source = url
	}
}
