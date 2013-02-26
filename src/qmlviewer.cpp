#include "qmlviewer.h"
#include "fileexplorercomponent.h"

#include <QDeclarativeEngine>

QMLViewer::QMLViewer(QWidget *parent) : QDeclarativeView(parent){

    qmlRegisterType<FileExplorerComponent>("FileExporer",1,0,"FileExplorer");

    setSource(QUrl("qrc:/qml/qml/main.qml"));
}

