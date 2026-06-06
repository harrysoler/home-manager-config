pragma ComponentBehavior: Bound

import qs.services
import qs.widgets
import qs.config
import QtQuick.Layouts
import QtQuick

Item {
    id: root

    required property var isWorkspaceOccupied
    required property var switchToWorkspace
    required property var shiftWorkspace

    required property int currentWorkspaceIndex
    required property int horizontalPadding

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
                isOccupied: isWorkspaceOccupied(index)
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
                    switchToWorkspace(pressedWorkspace)
            }
        }

        function onWheel(event: WheelEvent): void {
            if (event.angleDelta.y < 0 && root.currentWorkspaceIndex === Config.bar.workspaces.shown) {
                return;
            }

            shiftWorkspace(event.angleDelta.y < 0)
        }
    }
}
