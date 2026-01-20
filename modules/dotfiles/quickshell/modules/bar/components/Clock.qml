pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick
import QtQuick.Layouts

ColumnLayout {
    spacing: 0

    ClockText {
        id: hours
        text: Time.format("hh")
    }

    ClockText {
        id: minutes
        text: Time.format("mm")
    }

    component ClockText: Text {
        Layout.alignment: Qt.AlignCenter
        color: Colours.palette.m3onBackground
        font.family: Appearance.font.family.mono
        font.pointSize: Appearance.font.size.small
    }
}
