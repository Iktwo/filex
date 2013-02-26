import QtQuick 1.1
import FileExporer 1.0
import "." 1.0

Item {

    FileExplorer {
        id: filex
    }

    Rectangle {
        id: title

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        color: "gray"

        height: lblPath.height + 40

        Label {
            id: lblPath

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            width: parent.width - 40

            text: filex.currentDir
        }
    }

    ListView {
        id: fileList

        clip: true

        anchors.top: title.bottom
        anchors.bottom: toolBar.top
        anchors.left: parent.left
        anchors.right: parent.right

        model: filex.files

        spacing: 10

        delegate: Item {
            objectName: index

            height: imgIcon.height + 40
            width: parent.width - 40

            anchors.horizontalCenter: parent.horizontalCenter

            Image {
                id: imgIcon

                anchors.left: parent.left; anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                source: model.modelData.isFile ? "qrc:/images/file" : "qrc:/images/folder"
            }

            Label {

                anchors.left: imgIcon.right; anchors.leftMargin: 20
                anchors.right: parent.right; anchors.rightMargin: 20
                anchors.verticalCenter: imgIcon.verticalCenter

                elide: Text.ElideRight

                text: model.modelData.filename
            }

            Rectangle {

                anchors.fill: parent

                color: "#55FFFFFF"
                border.color: "lightblue"
                border.width: 3

                opacity: model.modelData.selected ? 1 : 0

                Behavior on opacity { NumberAnimation{}}
            }

            MouseArea {

                anchors.fill: parent

                onClicked: {
                    if (btnSelect.checked){
                        // Change selection
                        model.modelData.selected = !model.modelData.selected
                    } else if (!model.modelData.isFile){
                        // Go inside
                        filex.goInside(model.modelData.filename)
                    }
                }
            }
        }
    }

    Rectangle {
        id: toolBar

        height: 80
        width: parent.width

        anchors.bottom: parent.bottom

        color: "gray"

        Row {

            //height: parent.height
            anchors.left: parent.left; anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20

            Button {

                text: "up"

                onClicked: {
                    filex.goUp()
                }


            }

            CheckableButton {
                id: btnSelect

                text: "Select"

                onClicked: {
                    if (!checked) {
                        for (var i = 0; i < fileList.model.length; i++){
                            filex.files[i].selected = false
                        }
                    }
                }
            }

            Button {
                id:  btnDelete

                text: "Delete"

                onClicked: {
                    if (!filex.isSelectionEmpty()){
                        dlgDelete.open()
                    }
                }

                opacity: btnSelect.checked ? 1 : 0

                Behavior on opacity { NumberAnimation{}}
            }

            /*Button {
                id: btnAddDir

                text: "+Dir"

                onClicked: {
                    filex.createDir("TEST")
                }
            }

            Button {
                id: btnMenu

                text: "Menu"

                onClicked: {
                    menu.open()
                }
            }*/
        }
    }

    Menu {
        id: menu

        anchors.top: parent.top
        anchors.bottom: parent.bottom

        //x: parent.width+width
        //initX: parent.width+width
        //openedX: parent.width-width
    }

    YesNoDialog {
        id:  dlgDelete

        text: qsTr("Delete selected files?")

        onAccepted: {
            filex.deleteFiles()
            btnSelect.checked = false
        }
    }

}
