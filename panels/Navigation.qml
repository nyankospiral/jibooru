import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.folderlistmodel 2.11
import "../components/"
import jibooru_modules

PanelBase {
	label: "Navigation"

	FolderListModel {
		id: folderModel
		showDirs: true
		showFiles: false
		rootFolder: StandardPaths.writableLocation(StandardPaths.HomeLocation)
		folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
		showDotAndDotDot: true

		onFolderChanged: {
			imageModel.loadFolder(new URL(folder).pathname)
		}
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
		Pane {
			Layout.fillWidth: true
			Layout.fillHeight: true
			anchors.margins: 1
			padding: 0
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
						color: AppSettings.colors.accent
					}
					Text {
						anchors {left: arrow.right; top: parent.top; bottom: parent.bottom}
						anchors.leftMargin: 5
						text: model.fileName
						color: AppSettings.colors.text
					}
					MouseArea {
						anchors.fill: parent
						onClicked: {
							main.selection = undefined
							folderModel.folder = fileUrl
						}
					}
				} 

			}
		}
		Pane {
			Layout.fillWidth: true
			Layout.fillHeight: true
		}
	}

}
