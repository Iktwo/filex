import QtQuick 1.1

Item {
    id: button

    property alias text: lbl.text
    property alias backgroundOpacity: rctBackground.opacity


    signal clicked;

    width: (lbl.implicitWidth+10) < 80 ? 100 : lbl.implicitWidth+10
    height: 70

    Rectangle {
        id: rctBackground

        anchors.fill: parent

        color: "#44FFFFFF"
        border.color: "white"
        border.width: 3

        opacity: mouseArea.pressed ? 1 : 0

        Behavior on opacity { NumberAnimation{}}
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        onClicked: {
            button.clicked()
        }
    }

    Label {
        id: lbl

        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.left: parent.left
        //anchors.right: parent.right
        height: parent.height

        //horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
