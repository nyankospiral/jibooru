import QtQuick
import QtQuick.Controls
import jibooru_modules

Page {
	property string label
	header: Rectangle {
		height: 18
		color: AppSettings.colors.accent

		Text {
			anchors.fill: parent
			text: label 
			color: AppSettings.colors.text
			fontSizeMode: Text.VerticalFit
			padding: -2
		}
	} 
	padding: 0
}
