#ifndef FILE_H
#define FILE_H

#include <QObject>

class File : public QObject
{
    Q_OBJECT
public:
    explicit File(QString filename,bool isFile,QObject *parent = 0);

    Q_PROPERTY (QString filename READ filename NOTIFY fileNameChanged)
    Q_PROPERTY (bool isFile READ isFile NOTIFY isFileChanged)
    Q_PROPERTY (bool selected READ selected WRITE setSelected NOTIFY selectedChanged)
    
    QString filename() { return mFilename; }
    bool isFile() { return mIsFile; }
    bool selected() { return mSelected; }

    void setSelected(bool selected) { if (mSelected != selected) { mSelected = selected; emit selectedChanged();}}

signals:
    void fileNameChanged();
    void isFileChanged();
    void selectedChanged();

private:
    QString mFilename;
    bool mIsFile;
    bool mSelected;
    
};

#endif // FILE_H
