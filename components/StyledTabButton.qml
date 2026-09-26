import QtQuick
import QtQuick.Controls

TabButton {
	id: button
	background: Rectangle {
		color: button.checked ? "#333" : "#444"
	}
	palette.buttonText: "white"
}
