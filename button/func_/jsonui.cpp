#include "jsonui.h"

//函数声明
void createJoinJson();
jsonui::jsonui(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::jsonui)
{
    ui->setupUi(this);
    this->setWindowTitle("选取标准模板（默认支持格式是utf-8，路径不能有中文）");
    //json文件的生成
    //点击弹出对话框
    connect(ui->pushButton,&QPushButton::clicked,[=](){
        QString path=  QFileDialog::getOpenFileName(this,"模板");
        //路径放入lineedit中
        qDebug()<<&path;
        ui->lineEdit->setText(path);
        QFile file(path);
        //设置打开方式
        file.open(QIODevice::ReadOnly);

        QByteArray array= file.readAll();

        //将读取到的数据放入textEdit中
        ui->textEdit->setText(array);
        file.close();

    });

    connect(ui->writeButton,&QPushButton::clicked,[=](){
        QString path=  QFileDialog::getOpenFileName(this,"模板");
        QFile fileout(path);
        fileout.open(QIODevice::WriteOnly);
        //如何获取文本框内容？
        QString str = ui->textEdit->toPlainText();
        QTextStream stream(&fileout);
        stream<<str;
        fileout.close();
    });

}

jsonui::~jsonui()
{
    delete ui;
}
jsonui_qml::jsonui_qml(QObject *parent)
    : QObject(parent)

{
}

QByteArray jsonui_qml::json_back(){


    QJsonDocument doc;
    QJsonObject rootObj;
    rootObj.insert("name",QJsonValue("join"));
    rootObj.insert("power",QJsonValue("Mary"));

    doc.setObject(rootObj);
    QByteArray myjson=doc.toJson(QJsonDocument::Indented);


    return myjson;
}
