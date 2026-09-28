import QtQuick

Item {
	id: imageContainer
	readonly property bool isOnScreen: {
		var scrollPos = root.contentY
		var globalPos = mapToItem(root, 0, 0);
		return (globalPos.y + height > 0) && (globalPos.y < root.height); 
	}
	height: this.width * (model.pixelHeight / model.pixelWidth)

	Image {
		id: image
		anchors.fill: parent
		source: imageContainer.isOnScreen ? fileUrl : ""
		sourceSize.width: 300
		asynchronous: true
		fillMode: Image.PreserveAspectFit

		NumberAnimation on opacity {
			id: animator
			from: 0
			to: 1
			duration: 150
		}

		onSourceChanged: animator.start
	}

	MouseArea {
		anchors.fill: parent
		onClicked: { 
			imageViewer.setSource(model.fileUrl); 
			rootImageContainerStack.currentIndex = 1; 
			main.selection = model.index
		}
	}
}
