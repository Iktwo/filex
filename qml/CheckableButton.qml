import QtQuick 1.1

Button {
    id: checkableButton

    property bool checked: false

    backgroundOpacity: checked ? 1 : 0

    onClicked: {
        checked = !checked
    }
}
