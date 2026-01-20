pragma ComponentBehavior: Bound

import qs.modules.bar
import qs.services
import qs.widgets
import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        Exclusions {
            screen: scope.modelData
            bar: bar
        }

        StyledWindow {
            id: window

            screen: scope.modelData
            name: "drawers"
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: visibilities.launcher || visibilities.session ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            anchors {
                top: true
                bottom: true
                left: true
                right: true
            }

            PersistentProperties {
                id: visibilities

                property bool bar
                property bool osd
                property bool session
                property bool launcher
                property bool dashboard
                property bool utilities

                Component.onCompleted: Visibilities.screens[scope.modelData] = this
            }

            Bar {
                id: bar

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                screen: scope.modelData
                visibilities: visibilities
            }
        }
    }
}
