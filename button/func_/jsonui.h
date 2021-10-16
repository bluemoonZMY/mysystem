#ifndef JSONUI_H
#define JSONUI_H
#include "ui_jsonui.h"
#include<QFileDialog>
#include<QFile>
#include<QJsonDocument>
#include<QJsonArray>
#include<QJsonObject>
#include<QJsonValue>
#include<QDebug>
#include<QString>
#include <QWidget>

namespace Ui {
class jsonui;
}

class jsonui : public QWidget
{
    Q_OBJECT

public:
    explicit jsonui(QWidget *parent = nullptr);
    ~jsonui();

private:
    Ui::jsonui *ui;
};




class jsonui_qml: public QObject{
     Q_OBJECT
public:
    explicit jsonui_qml(QObject *parent = nullptr);

    Q_INVOKABLE QByteArray json_back();
private:
    QByteArray myjson;
};
#endif // JSONUI_H
