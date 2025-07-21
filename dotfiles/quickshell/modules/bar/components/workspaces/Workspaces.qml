pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick.Layouts
import QtQuick

Item {
    id: root

    required property int horizontalPadding

    readonly property var occupiedWorkspaces: Hyprland.workspaces.values.reduce((acc, curr) => {
        acc[curr.id] = curr.lastIpcObject.windows > 0;
        return acc;
    }, {})
    readonly property int currentWorkspaceIndex: Hyprland.activeWorkspaceId

    implicitHeight: layout.implicitHeight
    Layout.alignment: Qt.AlignCenter
    Layout.fillWidth: true

    ColumnLayout {
        id: layout
        spacing: 0

        anchors {
            left: parent.left
            right: parent.right
        }

        Repeater {
            model: Config.bar.workspaces.shown

            Workspace {
                occupiedWorkspaces: root.occupiedWorkspaces
            }
        }
    }

    ActiveIndicator {
        workspaceButtonHeight: layout.children[0]?.height ?? 0
        spacing: layout.spacing
        indicatorWidth: root.horizontalPadding
    }

    CustomMouseArea {
        anchors.fill: parent
        anchors.leftMargin: -root.horizontalPadding
        anchors.rightMargin: -root.horizontalPadding

        onPressed: event => {
            if (typeof(layout.childAt(event.x, event.y)?.index) !== "undefined") {
                const pressedWorkspace = layout.childAt(event.x, event.y)?.index + 1;
                if (root.currentWorkspaceIndex !== pressedWorkspace)
                    Hyprland.switchToWorkspace(pressedWorkspace)
            }
        }

        function onWheel(event: WheelEvent): void {
            if (event.angleDelta.y < 0 && root.currentWorkspaceIndex === Config.bar.workspaces.shown) {
                return;
            }

            Hyprland.shiftWorkspace(event.angleDelta.y < 0)
        }
    }
}
