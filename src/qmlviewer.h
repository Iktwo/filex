#ifndef QMLVIEWER_H
#define QMLVIEWER_H

#include <QDeclarativeView>

class QMLViewer : public QDeclarativeView
{
    Q_OBJECT
public:
    explicit QMLViewer(QWidget *parent = 0);
    
};

#endif // QMLVIEWER_H
