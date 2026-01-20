pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

Singleton {
    id: root

    readonly property var workspaces: Hyprland.workspaces
    readonly property HyprlandWorkspace focusedWorkspace: Hyprland.focusedWorkspace
    readonly property HyprlandToplevel activeToplevel: Hyprland.activeToplevel
    readonly property int activeWorkspaceId: focusedWorkspace?.id ?? 1

    function switchToWorkspace(workspace: int): void {
        Hyprland.dispatch(`workspace ${workspace}`)
    }

    function shiftWorkspace(shiftForward: bool): void {
        const shiftDirection = shiftForward ? "+" : "-"
        Hyprland.dispatch(`workspace r${shiftDirection}1`)
    }

    Connections {
        target: Hyprland

        function onRawEvent(event: HyprlandEvent): voin {
            if (event.name.endsWith("v2"))
                return;

            if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(event.name)) {
                Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();
            } else if (["openwindow", "closewindow", "movewindow"].includes(event.name)) {
                Hyprland.refreshToplevels();
                Hyprland.refreshWorkspaces();
            } else if (event.name.includes("workspace")) {
                Hyprland.refreshWorkspaces();
            }
        }
    }
}
