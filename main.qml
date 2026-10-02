import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./panels" as Panels
import "./components"
import jibooru_modules


ApplicationWindow{
	id: main
	property var selection
	property list<string> filters
	visible: true
	palette.window: AppSettings.colors.base

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

			Panels.Filters {
				Layout.fillWidth: true
				Layout.fillHeight: true
			}
		}

		Item {
			id: rootImageContainer
			SplitView.fillWidth: true
			StackLayout {
				id: rootImageContainerStack
				anchors.fill: parent

				Panels.ImageGrid {} //index 0
				Panels.ImageViewer { id: imageViewer } //index 1

			}
		}

		ColumnLayout {
			id: rightColumn

			SplitView.preferredWidth: 200
			SplitView.minimumWidth: 200
			SplitView.maximumWidth: 400
			SplitView.fillWidth: false

			Panels.Tags {
				Layout.fillWidth: true
				Layout.fillHeight: true

			}
		}
	}

	onFiltersChanged: {imageModel.setKeywordFilter(filters)}
}
