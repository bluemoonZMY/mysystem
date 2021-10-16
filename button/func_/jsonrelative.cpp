#include "jsonrelative.h"
//切记！！构造函数名称为CppObject

CppObject::CppObject(QObject *parent)
    : QObject(parent)

{
    jsonUi = new jsonui;
}
void CppObject::openUI()
{
    jsonUi->show();
}
