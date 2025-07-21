import QtQuick

QtObject {
    readonly property bool persistent: true
    readonly property Workspaces workspaces: Workspaces {}

    component Workspaces: QtObject {
        readonly property int shown: 10

        readonly property int activeIndicatorWidth: 2
        readonly property int activeIndicatorHOffset: -2
    }
}
