import QtQuick 1.1

Rectangle {

    property alias text: lbl.text

    signal rejected;
    signal accepted;

    function open(){
        opacity = 1
    }

    function close(){
        opacity = 0
    }


    anchors.fill: parent

    color: "#99000000"
    opacity: 0

    MouseArea {
        anchors.fill: parent
    }

    Behavior on opacity { PropertyAnimation { duration: 650} }

    Rectangle {
        id: lblBackground

        anchors.fill: lbl
        anchors.margins: -10

        color: "gray"
    }

    Label {
        id: lbl

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top; anchors.topMargin: parent.height/3

        font.pointSize: 30
    }

    Button {

        anchors.top: lblBackground.bottom; anchors.topMargin: 10
        x: (parent.width/2) - width - 40

        text: "Yes"

        onClicked: {
            accepted()
            close()
        }
    }

    Button {

        anchors.top: lblBackground.bottom; anchors.topMargin: 10
        x: (parent.width/2) + 40

        text: "No"

        onClicked: {
            rejected()
            close()
        }
    }

}
