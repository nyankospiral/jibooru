import QtQuick
import QtQuick.Controls

Flickable {
	id: root
	contentHeight: masonryRow.childrenRect.height
	clip: true

	required property int imageSizeFactor
	required property int layoutSpacing
	required property var model

	property int columnCount: Math.floor(root.width / imageSizeFactor)

	Row { //holds the columns
		id: masonryRow
		anchors.fill: parent
		anchors.margins: layoutSpacing
		spacing: root.layoutSpacing

		Repeater { //dynamically create a reasonable amt of columns
			model: columnCount

			Column {
				id: col
				property int colIndex: index
				spacing: root.layoutSpacing
				width: ((masonryRow.width - (root.layoutSpacing * (root.columnCount - 1))) / root.columnCount)

				Repeater { //add content from model data to the view
				id: innerRepeater
				model: root.model
					Loader {
						active: index % root.columnCount === col.colIndex
						visible: active
						width: active ? col.width : 0
						// height: active ? childrenRect.height : 0
						sourceComponent: ImageDelegate {} 
					}
				}
			} //Column
		} //Repeater
	} //Row

	ScrollBar.vertical: ScrollBar { rightPadding: 3}

} //Flickable
