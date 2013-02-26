#include "fileexplorercomponent.h"
#include "file.h"

#include <QCoreApplication>
#include <QDir>
//#include <QDebug>

FileExplorerComponent::FileExplorerComponent(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
    setPath(QCoreApplication::applicationDirPath());
}

void FileExplorerComponent::getFilesInPath(QString path){
    QDir dir(path);
    QStringList files = dir.entryList(QDir::Dirs|QDir::NoDotAndDotDot);

    while (!mFiles.isEmpty()){
        delete mFiles.takeFirst();
    }

    for (int i = 0; i < files.count(); ++i) {
        mFiles.append(new File(files.at(i),false));
    }

    files = dir.entryList(QDir::Files);

    for (int i = 0; i < files.count(); ++i) {
        mFiles.append(new File(files.at(i),true));
    }

    emit filesChanged();
}

QString FileExplorerComponent::getDirNameFromPath(QString path){
    if (path=="/"){
        return path;
    }

    if (path.lastIndexOf("/")+1==path.length()){
        path.remove(path.length()-1,1);
        path.mid(path.lastIndexOf("/")+1);
    }
    return path.mid(path.lastIndexOf("/")+1);
}

void FileExplorerComponent::deleteFiles(){
    for (int i = 0; i < mFiles.count(); ++i) {
        if (mFiles.at(i)->property("selected").toBool()){
            if (mFiles.at(i)->property("isFile").toBool()){
                QFile f(mPath+"/"+mFiles.at(i)->property("filename").toString());
                f.remove(); // TODO: handle erros if can't delete
            } else {
                QDir d(mPath+"/"+mFiles.at(i)->property("filename").toString());

                QStringList files = d.entryList(QDir::Files);

                for (int i = 0; i < files.count(); ++i) {
                    qDebug() << "f " << files.at(i);
                    QFile f(d.absolutePath()+"/"+files.at(i));
                    f.remove(); // TODO: handle erros if can't delete
                }
                d.rmdir(d.absolutePath());
            }
        }
    }

    getFilesInPath(mPath);
}

void FileExplorerComponent::goInside(QString dir){
    setPath(mPath+"/"+dir);
}

void FileExplorerComponent::setPath(QString path){
    if (mPath != path){
        mPath = path;
        emit pathChanged();

        if (mCurrentDir!=getDirNameFromPath(path)) {
            mCurrentDir = getDirNameFromPath(path);
            emit currentDirChanged();
        }

        getFilesInPath(path);
    }
}

void FileExplorerComponent::goUp(){
    setPath(getParentDir(mPath));
}

QString FileExplorerComponent::getParentDir(QString path){
    if (path.lastIndexOf("/")==0){
        return "/";
    }

    if (path=="/"){
        return path;
    }

    if (path.lastIndexOf("/")+1==path.length()){
        path.remove(path.length()-1,1);
    }
    return path.mid(0,path.lastIndexOf("/"));
}

bool FileExplorerComponent::isSelectionEmpty(){
    bool isEmpty = true;

    for (int i = 0; i < mFiles.count(); ++i) {
        if (mFiles.at(i)->property("selected").toBool()==true){
            isEmpty = false;
            break;
        }
    }

    return isEmpty;
}

void FileExplorerComponent::createDir(QString dir){
    QDir d(mPath);
    d.mkdir(dir); // TODO: handle error if dir wasn´t created
    getFilesInPath(mPath);
}
