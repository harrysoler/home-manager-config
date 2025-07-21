pragma ComponentBehavior: Bound

import "components"
import "components/workspaces"
import qs.config
import qs.services
import qs.widgets
import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    WlrLayershell.namespace: "quickshell:bar"

    anchors {
        left: true
        top: true
        bottom: true
    }

    readonly property real maxColumnsImplicitWidth: Math.max(top.implicitWidth, bottom.implicitWidth)
    readonly property int spacing: Appearance.spacing.normal

    readonly property int verticalPadding: Appearance.padding.normal
    readonly property int horizontalPadding: Config.border.thickness

    exclusiveZone: root.implicitWidth
    implicitWidth: maxColumnsImplicitWidth + horizontalPadding * 2

    aboveWindows: false

    color: Colours.withAlpha(Colours.palette.m3background, false)

    TopColumn {
        id: top

        Clock {}
        Workspaces {
            horizontalPadding: root.horizontalPadding
        }
    }

    BottomColumn {
        id: bottom
    }

    component TopColumn: ColumnLayout {
        spacing: root.spacing

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: root.verticalPadding
        }
    }

    component BottomColumn: ColumnLayout {
        spacing: root.spacing

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: root.verticalPadding
        }
    }
}
