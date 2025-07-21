import qs.widgets
import qs.services
import qs.config
import QtQuick.Layouts
import QtQuick

Item {
    id: root

    required property int index
    required property var occupiedWorkspaces

    readonly property int workspaceId: index + 1
    readonly property bool isOccupied: occupiedWorkspaces[workspaceId] ?? false
    readonly property bool isActive: Hyprland.activeWorkspaceId === workspaceId

    readonly property WorkspaceAssets workspaceAssets: WorkspaceAssets {}

    implicitHeight: indicator.implicitHeight
    implicitWidth: indicator.implicitWidth
    Layout.fillWidth: true

    StyledText {
        id: indicator

        anchors.fill: parent
        horizontalAlignment: StyledText.AlignHCenter

        topPadding: Appearance.spacing.small
        bottomPadding: Appearance.spacing.small

        text: workspaceAssets.getLabel()
        color: workspaceAssets.getColor()

        font.pointSize: Appearance.font.size.small
        font.family: Appearance.font.family.mono
    }

    component WorkspaceAssets: QtObject {
        readonly property color inactiveColor: Colours.palette.m3outlineVariant
        readonly property color activeColor: Colours.palette.m3onSurface

        // Make all labels single-digit
        function getLabel(): string {
            return root.workspaceId === 10 ? 0 : root.workspaceId
        }

        function getColor(): color {
            // return (root.isActive || root.isOccupied) ? activeColor : inactiveColor
            return root.isOccupied ? activeColor : inactiveColor
        }
    }
}
