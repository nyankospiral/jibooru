pragma Singleton
import QtQuick

QtObject {
	property bool useSysTheme: false
	
	property SystemPalette sysPal: SystemPalette{
		colorGroup: SystemPalette.Active
	}

	property QtObject appPal: QtObject {
		property color accent: "#8b53c2"
		property color text: "white"
		property color base: "#2f2f2f"
	}

	property QtObject colors: QtObject {
		id: colors
		property color accent: useSysTheme ? sysPal.accent : appPal.accent
		property color text: useSysTheme ? sysPal.text : appPal.text
		property color base: useSysTheme ? sysPal.base : appPal.base
	}
}
