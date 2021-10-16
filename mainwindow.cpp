#include "mainwindow.h"
#include "ui_mainwindow.h"
#include<QTimer>
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->setFixedSize(1600,900);
    this->setWindowTitle("智能实验室平台");
    this->setWindowIcon(QIcon(":/res/Icon.jpg"));
    //退出
    connect(ui->actionquit,&QAction::triggered,[=](){
        this->close();
    });
    //开始
    MyPushButton *startBtn= new MyPushButton(":/res/MenuSceneStartButton.png");
    startBtn->setParent(this);
    startBtn->move(this->width()*0.5-startBtn ->width()*0.5,this->height()*0.7);
    chooseScene = new choosescene;
    connect(startBtn,&MyPushButton::clicked,[=](){
        startBtn->Zoom1();
        startBtn->Zoom2();
        //进入到用户主场景
        QTimer::singleShot(500,this,[=](){
            this->hide();
            chooseScene->show();
        });
    });
}
void MainWindow::paintEvent(QPaintEvent *){

    QPainter painter(this);
    QPixmap pix;
    pix.load(":/res/background.jpg");
    painter.drawPixmap(0,0,this->width(),this->height(),pix);
}
MainWindow::~MainWindow()
{
    delete ui;
}

