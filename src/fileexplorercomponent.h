#ifndef FILEEXPLORER_H
#define FILEEXPLORER_H

#include <QDeclarativeItem>

class FileExplorerComponent : public QDeclarativeItem
{
    Q_OBJECT
public:
    explicit FileExplorerComponent(QDeclarativeItem *parent = 0);

    Q_PROPERTY (QString path READ path NOTIFY pathChanged)
    Q_PROPERTY (QString currentDir READ currentDir NOTIFY currentDirChanged)
    Q_PROPERTY (QList<QObject *> files READ files NOTIFY filesChanged)
    
    QString path() { return mPath; }
    QString currentDir() { return mCurrentDir; }
    QList<QObject *> files() { return mFiles; }

    Q_INVOKABLE QString getDirNameFromPath(QString);
    Q_INVOKABLE void deleteFiles();
    Q_INVOKABLE void goInside(QString path);
    Q_INVOKABLE void goUp();
    Q_INVOKABLE bool isSelectionEmpty();
    Q_INVOKABLE void createDir(QString dir);

signals:
    void pathChanged();
    void currentDirChanged();
    void filesChanged();

private:
    QString mPath; // TODO: add function to set this so propper signals are emited
    QString mCurrentDir;
    QList<QObject *> mFiles;

    void setPath(QString path);
    void getFilesInPath(QString);
    QString getParentDir(QString path);
    
};

#endif // FILEEXPLORER_H
