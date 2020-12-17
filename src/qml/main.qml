import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.12
import QMLTermWidget 1.0
import MeuiKit 1.0 as Meui

ApplicationWindow {
    width: 640
    height: 480
    minimumWidth: 300
    minimumHeight: 200
    visible: true
    id: rootWindow
    title: qsTr("Terminal")

    background: Rectangle {
        color: Meui.Theme.backgroundColor
    }

    Action {
        onTriggered: terminal.copyClipboard();
        shortcut: "Ctrl+Shift+C"
    }

    Action {
        onTriggered: terminal.pasteClipboard();
        shortcut: "Ctrl+Shift+V"
    }

    QMLTermWidget {
        id: terminal
        anchors.fill: parent
        font.family: "JetBrains Mono"
        font.pointSize: 9
        colorScheme: "Linux"
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: terminal.width
                height: terminal.height
                radius: 4
            }
        }

        session: QMLTermSession{
            id: session
        }

        Component.onCompleted: {
            session.startShellProgram()
            terminal.forceActiveFocus()
        }

        QMLTermScrollbar {
            terminal: terminal
            width: 20
            Rectangle {
                opacity: 0.4
                anchors.margins: 5
                radius: width * 0.5
                anchors.fill: parent
            }
        }
    }
}