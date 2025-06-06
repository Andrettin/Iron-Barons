import QtQuick
import QtQuick.Controls

ButtonBase {
	id: button
	width: 96 * scale_factor
	height: 24 * scale_factor
	
	property bool allowed: true
	
	signal clicked()
	
    background: Rectangle {
        implicitWidth: 40
        implicitHeight: 40
        radius: button.radius
        color: highlighted ? "dimGray" : "black"
        border.color: allowed ? "gray" : "dimGray"
        border.width: 1 * scale_factor
    }
	
	onReleased: {
		if (!allowed) {
			return
		}
		
		button.clicked()
	}
}
