#include <QApplication>
#include "src/qmlviewer.h"

Q_DECL_EXPORT int main(int argc, char *argv[]){
    QApplication app(argc, argv);
    
    QCoreApplication::setOrganizationName("Iktwo Corp.");
    QCoreApplication::setOrganizationDomain("iktwo.com");
    QCoreApplication::setApplicationName("filex");
    
    QMLViewer qmlViewer;
    qmlViewer.show();
    
    return app.exec();
}


