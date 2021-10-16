
#ifndef JSONRELATIVE_H
#define JSONRELATIVE_H

#include<QObject>
#include<QString>
#include<QDebug>
#include"jsonui.h"
class CppObject : public QObject
{
    Q_OBJECT


public:
    explicit CppObject(QObject *parent = nullptr);
jsonui *jsonUi=NULL;

Q_INVOKABLE void openUI();

signals:
void cppSignalB(const QString &str,int value); // 一个带参数信号
public slots:

private:

};
#endif // JSONRELATIVE_H
