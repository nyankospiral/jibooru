import QtQuick

Item {
	id: imageContainer

	readonly property bool isSelection: main.selection === model.index  
	readonly property bool isOnScreen: {
		var scrollPos = root.contentY
		var globalPos = mapToItem(root, 0, 0);
		return (globalPos.y + height > 0) && (globalPos.y < root.height); 
	}

	height: this.width * (model.pixelHeight / model.pixelWidth)

	Image {
		id: image
		anchors.fill: parent
		source: imageContainer.isOnScreen ? model.fileUrl : ""
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

	//TODO: properly change indicator (and other things) as selection updates from tag/filter/model changes
	Rectangle {
		anchors.fill: parent
		visible: isSelection 
		color: "transparent"
		border.color: "mediumpurple"
		border.width: 2
	}

	MouseArea {
		anchors.fill: parent
		onClicked: { 
			if (isSelection){
				imageViewer.setSource(model.fileUrl); 
				rootImageContainerStack.currentIndex = 1; 
			}
			main.selection = model.index
		}
	}
}
