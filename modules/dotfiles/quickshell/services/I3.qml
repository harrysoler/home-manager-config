pragma Singleton

import Quickshell
import Quickshell.I3
import QtQuick

Singleton {
    id: root

    readonly property var workspaces: I3.workspaces
    readonly property I3Workspace focusedWorkspace: I3.focusedWorkspace
    readonly property int activeWorkspaceId: focusedWorkspace?.number ?? 1

    function isWorkspaceOccupied(workspaceId: int): bool {
        var workspace = workspaces.values
            .find((workspace) => workspace.number == workspaceId + 1)

        if (!workspace) {
            return false
        }

        var ipcObject = workspace.lastIpcObject

        if (!ipcObject) {
            return false
        }

        if (ipcObject.nodes.length <= 0) {
            return false
        }

        return true
    }

    function switchToWorkspace(workspace: int): void {
        I3.dispatch(`workspace ${workspace}`)
    }

    function shiftWorkspace(shiftForward: bool): void {
        const shiftDirection = shiftForward ? "next" : "prev"
        I3.dispatch(`workspace ${shiftDirection}`)
    }
}
