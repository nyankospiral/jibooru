import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel 2.11
import "../components/"

PanelBase {
	label: "Navigation"

	FolderListModel {
		id: folderModel
		showDirs: true
		showFiles: false
		rootFolder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
		folder: rootFolder + "/Pictures"
		showDotAndDotDot: true
	}

	TabBar {
		id: tabs
		anchors {left: parent.left; right: parent.right}
		contentHeight: 18

		StyledTabButton { text: "dir" }
		StyledTabButton { text: "saved" }
	}

	StackLayout {
		anchors {top: tabs.bottom; left: parent.left; right: parent.right; bottom: parent.bottom }
		currentIndex: tabs.currentIndex
		Rectangle {
			Layout.fillWidth: true
			Layout.fillHeight: true
			anchors.margins: 1
			color: "#444"
			border.width: 1
			border.color: "#555"
			TreeView {
				anchors.fill: parent
				model: folderModel
				clip: true
				contentWidth: parent.width
				delegate: Item {
					implicitWidth: parent.width
					implicitHeight: 20
					Rectangle {
						id: arrow
						width: height
						anchors {left: parent.left; top: parent.top; bottom: parent.bottom}
						anchors.margins: 7
						radius: 180
						color: "white"
					}
					Text {
						anchors {left: arrow.right; top: parent.top; bottom: parent.bottom}
						anchors.leftMargin: 5
						text: model.fileName
						color: "white"
					}
					MouseArea {
						anchors.fill: parent
						onClicked: {
							main.selection = undefined
							folderModel.folder = model.fileUrl
						   	imageModel.loadFolder(model.filePath)
						}
					}
				} 

			}
		}
		Rectangle {
			color: "#444"
			Layout.fillWidth: true
			Layout.fillHeight: true
			border.width: 1
			border.color: "white"
		}
	}

}
