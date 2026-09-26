import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./panels" as Panels
import "./components"


ApplicationWindow{
	readonly property color bg: "#3f3f3f"
	readonly property color fg: "#4a4a4a"
	visible: true

	color: bg
	width: 300
	height: 300

	SplitView {
		anchors.fill: parent

		ColumnLayout {
			id: leftColumn

			SplitView.preferredWidth: 130
			SplitView.minimumWidth: 130
			SplitView.maximumWidth: 270
			SplitView.fillWidth: false

			Panels.Navigation {
				Layout.fillWidth: true
				Layout.preferredHeight: 300
			}

			PanelBase {
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}

		Rectangle {
			id: rootImageContainer
			SplitView.fillWidth: true
			color: bg
			StackLayout {
				id: rootImageContainerStack
				anchors.fill: parent

				MasonryLayout {} //index 0
				Panels.ImageViewer { id: imageViewer } //index 1

			}
		}

		ColumnLayout {
			id: rightColumn

			SplitView.preferredWidth: 200
			SplitView.minimumWidth: 200
			SplitView.maximumWidth: 400
			SplitView.fillWidth: false

			PanelBase {
				Layout.fillWidth: true
				Layout.fillHeight: true

			}
		}
	}
}
