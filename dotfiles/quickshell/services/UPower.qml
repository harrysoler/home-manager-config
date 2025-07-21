pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    readonly property bool isReady: UPower.displayDevice.ready
    readonly property bool onBattery: UPower.onBattery
    readonly property real floatPercentage: UPower.displayDevice.percentage

    function formatPercentage(): string {
        const percentage = UPower.displayDevice.percentage * 100
        return percentage == 100 ? "FL" : percentage
    }
}
