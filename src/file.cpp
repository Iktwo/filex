#include "file.h"

File::File(QString filename, bool isFile, QObject *parent) :
    QObject(parent),
    mFilename(filename),
    mIsFile(isFile),
    mSelected(false)
{
}
