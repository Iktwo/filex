import QtQuick 1.1

Rectangle {

    property int openedX: width - menu.width
    property int initX: width + menu.width

    function open(){
        opacity = 1
        menu.x = openedX;
    }

    function close(){
        opacity = 0
        menu.x = initX;
    }

    anchors.fill: parent

    color: "#66000000"
    opacity: 0

    Behavior on opacity { PropertyAnimation { duration: 650} }

    MouseArea {

        anchors.fill: parent

        onClicked: {
            close()
        }
    }

    Rectangle {
        id: menu

        width: parent.width/3
        height: parent.height

        x: initX

        color: "gray"

        Behavior on x { PropertyAnimation { easing.type: Easing.InOutQuad; duration: 650} }

    }
}

