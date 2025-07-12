pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick


Singleton {
  id: root
  // an expression can be broken across multiple lines using {}
  readonly property string time: {
    // The passed format string matches the default output of
    // the `date` command.
    Qt.formatDateTime(clock.date, "dddd | hh:mm | dd. of MMMM yyyy")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}