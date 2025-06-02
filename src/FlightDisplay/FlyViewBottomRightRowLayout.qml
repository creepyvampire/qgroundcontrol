/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *

 30-05-2025 - Arjun - Added TextField and Button for custom Mav commands. also added button event handler
 ****************************************************************************/

import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls
import QGroundControl.FlightDisplay
import QGroundControl.Vehicle

RowLayout {

//Custom Mavlink Commands Field
    QGCTextField {
        id: commandField
        placeholderText: qsTr("Enter Command Here")
        Layout.alignment: Qt.AlignBottom
        Layout.preferredWidth: 300
    }


    QGCButton {
        id: commandButton
        text: qsTr("Send Command")
        Layout.alignment: Qt.AlignBottom
        onClicked: {
            if (QGroundControl.multiVehicleManager.activeVehicle) {
                    QGroundControl.multiVehicleManager.activeVehicle.sendCustomCommand(commandField.text);
            }else {
                    console.warn("No vehicle connected.");
            }
        }
    }

    TelemetryValuesBar {
        Layout.alignment:       Qt.AlignBottom
        extraWidth:             instrumentPanel.extraValuesWidth
        settingsGroup:          factValueGrid.telemetryBarSettingsGroup
        specificVehicleForCard: null // Tracks active vehicle
    }

    FlyViewInstrumentPanel {
        id:         instrumentPanel
        visible:    QGroundControl.corePlugin.options.flyView.showInstrumentPanel && _showSingleVehicleUI
    }
}
