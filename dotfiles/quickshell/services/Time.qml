pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property int hours: clock.hours
    readonly property int minutes: clock.minutes

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
