#include "choosescene.h"
#include<QTimer>
//尝试使用
#include"./func_/jsonrelative.h"
choosescene::choosescene(QWidget *parent) : QMainWindow(parent)
{
    this->setFixedSize(1600,900);
    this->setWindowTitle("智能实验室平台");
    this->setWindowIcon(QIcon(":/res/Icon.jpg"));
    //报告出具
    MyPushButton *reportmenu= new MyPushButton(":/res/mainscene/reportmenu.jpg",":/res/mainscene/reportmenu_on.jpg");
    reportmenu->setParent(this);
    reportmenu->move(418,185);

    connect(reportmenu,&MyPushButton::clicked,[=](){
        QTimer::singleShot(100,this,[=](){ emit this->velqml();});

    });
    //智能化测试
    MyPushButton *intellectezr= new MyPushButton(":/res/mainscene/intellectezr.jpg");
    intellectezr->setParent(this);
    intellectezr->move(814,185);
    connect(intellectezr,&MyPushButton::clicked,[=](){
       // this->hide();
        inTellectest = new intellectest;
        inTellectest->show();
    });
    //数据库
    MyPushButton *database= new MyPushButton(":/res/mainscene/database.jpg");
    database->setParent(this);
    database->move(1101,185);
    //原始记录
    MyPushButton *sourcerecord= new MyPushButton(":/res/mainscene/sourcerecord.jpg");
    sourcerecord->setParent(this);
    sourcerecord->move(418,411);
    //设备管理
    MyPushButton *equipmamager= new MyPushButton(":/res/mainscene/equipmamager.jpg");
    equipmamager->setParent(this);
    equipmamager->move(705,411);
    connect(equipmamager,&MyPushButton::clicked,[=](){
        manageMent = new management;
        manageMent->show();

    });
    //日志
    MyPushButton *log= new MyPushButton(":/res/mainscene/log.jpg");
    log->setParent(this);
    log->move(418,636);
    //拓展功能
    MyPushButton *continuation= new MyPushButton(":/res/mainscene/continuation.jpg");
    continuation->setParent(this);
    continuation->move(418+438+11,636);
    //数据库




}
void choosescene::paintEvent(QPaintEvent *){

    QPainter painter(this);
    QPixmap pix;
    pix.load(":/res/mainbackground.jpg");
    painter.drawPixmap(0,0,this->width(),this->height(),pix);



}


//报告生成页面

void choosescene::velqml(){
    qmlRegisterType<CppObject>("MyCppObject", 1, 0, "CppObject");
    qmlRegisterType<jsonui_qml>("myjsonui_qml", 1, 0, "Jsonui_qml");
    quickWidget = new QQuickWidget();
    quickWidget->setSource(QUrl("QML/reportscene.qml"));

}
