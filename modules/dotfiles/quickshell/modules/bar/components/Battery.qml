pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick.Layouts
import QtQuick

Loader {
    id: root

    readonly property real percentage: UPower.floatPercentage
    readonly property bool isCharging: !UPower.onBattery

    active: UPower.isReady
    asynchronous: true

    sourceComponent: ColumnLayout {
        spacing: 0

        BatteryIcon {}
        BatteryText {}
    }

    component BatteryIcon: MaterialIcon {
        readonly property list<string> rangeIcons: [
            "battery_0_bar",
            "battery_1_bar",
            "battery_2_bar",
            "battery_3_bar",
            "battery_4_bar",
            "battery_5_bar",
            "battery_full"
        ]
        readonly property string currentIcon: rangeIcons[Math.floor(root.percentage / 0.142)]

        text: root.isCharging ? "bolt" : currentIcon
        fill: 1

        Layout.alignment: Qt.AlignCenter
    }

    component BatteryText: StyledText {
        text: {
            return percentage == 1 ? "FL" : Math.floor(percentage * 100)
        }

        Layout.alignment: Qt.AlignCenter
        color: Colours.palette.m3onBackground
        font.family: Appearance.font.family.mono
        font.pointSize: Appearance.font.size.small
    }
}
