pragma ComponentBehavior: Bound

import qs.config
import qs.services
import QtQuick

Text {
    id: root

    renderType: Text.NativeRendering
    textFormat: Text.PlainText
    color: Colours.palette.m3onSurface
    font.family: Appearance.font.family.sans
    font.pointSize: Appearance.font.size.smaller
}
