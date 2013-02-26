QT       += declarative

TARGET = filex
CONFIG   += app_bundle

TEMPLATE = app

HEADERS += \
    src/qmlviewer.h \
    src/fileexplorercomponent.h \
    src/file.h

SOURCES += \
    src/main.cpp \
    src/qmlviewer.cpp \
    src/fileexplorercomponent.cpp \
    src/file.cpp

RESOURCES += \
    resources.qrc

OTHER_FILES += \
    qml/YesNoDialog.qml \
    qml/Menu.qml \
    qml/main.qml \
    qml/Label.qml \
    qml/FilesPage.qml \
    qml/CheckableButton.qml \
    qml/Button.qml
