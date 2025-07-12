import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import QtQuick.Controls

Scope {
  Variants {
    model: Quickshell.screens;

    PanelWindow {
      color: "transparent"
      property var modelData
      id: screenRoot

      screen: modelData
      anchors {
        top: true
        left: true
        right:true
      }

      implicitHeight: 30

      MarginWrapperManager {leftMargin: 8; rightMargin: 8;}

      RowLayout {
        id: rootRow
        spacing: 6

        anchors{
          horizontalCenter: parent.horizontalCenter
          verticalCenter: parent.verticalCenter
        }

        RowLayout {
          Rectangle {
            color: "#1e1e2e"
            MarginWrapperManager { leftMargin: 10; rightMargin: 10 }
            Layout.fillHeight: true
            border.color: "#a6e3a1"
            border.width: 2
            radius: 4
            RowLayout {
              id: sysTrayRepeat
              Layout.fillHeight: true
              Layout.fillWidth: true
              Repeater {
                model: SystemTray.items
                MouseArea {
                  required property QtObject modelData

                  id: button
                  hoverEnabled: true
                  Layout.fillHeight: true
                  acceptedButtons: Qt.LeftButton | Qt.RightButton
                  implicitWidth: 15
    
                  onClicked: function(mouse) {
                      if (mouse.button === Qt.LeftButton) {
                        modelData.activate()
                      } else if (mouse.button === Qt.RightButton) {
                        if (modelData.hasMenu) {
                          menu.open()
                        }
                      }
                  }
                  QsMenuAnchor {
                    id: menu
                    menu: modelData.menu
                    anchor.window: screenRoot

                    anchor.rect.y: 34
                    anchor.rect.x: 0
                    anchor.rect.width: button.width
                    anchor.edges: Edges.Bottom
                  }

                  IconImage {
                    id: trayIcon
                    visible: true // There's already color overlay
                    source: modelData.icon
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                  }
                }
              }
            }
          }
        }
        Rectangle { Layout.fillWidth: true }
        RowLayout {
          anchors.horizontalCenter: parent.horizontalCenter
          Rectangle {
            property real margin: 10
            color: "#1e1e2e"
            MarginWrapperManager { leftMargin: 10; rightMargin: 10; topMargin: 6.5 }
            Layout.fillHeight: true
            border.color: "#a6e3a1"
            border.width: 2
            radius: 4
            ClockWidget {
              id: clockWidget
              color: "#cdd6f4"
            }
          }
        }
        Rectangle { Layout.fillWidth: true }
        Rectangle {
          visible: UPower.displayDevice.isLaptopBattery
          property real margin: 10
          color: "#1e1e2e"
          MarginWrapperManager { margin: 2 }
          Layout.fillHeight: true
          radius: 4;
          gradient: Gradient{
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: UPower.displayDevice.state === UPowerDeviceState.Charging ? "#f9e2af" : UPower.displayDevice.state === UPowerDeviceState.Discharging ? "#f38ba8" : "#a6e3a1" }
            GradientStop { position: UPower.displayDevice.percentage - 0.01; color: UPower.displayDevice.state === UPowerDeviceState.Charging ? "#f9e2af" : UPower.displayDevice.state === UPowerDeviceState.Discharging ? "#f38ba8" : "#a6e3a1" }
            GradientStop { position: UPower.displayDevice.percentage; color: UPower.displayDevice.percentage * 100 >= 99 && UPower.displayDevice.state !== UPowerDeviceState.Discharging ? "#a6e3a1" : "#1e1e2e" }
          }
          Rectangle {
            MarginWrapperManager { leftMargin: 10; rightMargin: 10; }
            color: "#1e1e2e"
            radius: 2;
            RowLayout{  
              Text {
                Layout.alignment: Qt.AlignVCenter
                color: "#cdd6f4"
                text: "bat " + (UPower.displayDevice.percentage * 100 >= 99 ? ("full") : (UPower.displayDevice.percentage * 100 + "%"))
              }
            }
          }

          //TODO Tooltip with TIME TO FULL
        }
        
      }
    } 

  }
}