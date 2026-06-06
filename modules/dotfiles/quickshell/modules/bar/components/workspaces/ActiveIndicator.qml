pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick

StyledRect {
    required property real workspaceButtonHeight
    required property real spacing
    required property int indicatorWidth

    readonly property int currentWorkspaceIndex: I3.activeWorkspaceId - 1
    property real offset: (currentWorkspaceIndex * workspaceButtonHeight) + (currentWorkspaceIndex * spacing)

    x: -indicatorWidth
    y: offset
    implicitWidth: indicatorWidth
    implicitHeight: workspaceButtonHeight

    color: Colours.palette.m3primary

    Behavior on offset {
        NumberAnimation {
            duration: Appearance.anim.durations.small
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Appearance.anim.curves.emphasized
        }
    }
}
