#include "mypushbutton.h"
#include<QPropertyAnimation>
#include<QDebug>
MyPushButton::MyPushButton(QString normalImg,QString pressImg)
{
    this->normalImgPath = normalImg;
    this->pressedImgPath = pressImg;
     QPixmap pix;
     bool ret = pix.load(normalImgPath);
     if(!ret)
     {
         QString str=QString("%1 图片加载失败").arg(this->normalImgPath);
         qDebug()<<str;
         return;
     }
     this->setFixedSize(pix.width(),pix.height());
     this->setStyleSheet("QPushButton{border:0px;}");
     this->setIcon(pix);
     this->setIconSize(QSize(pix.width(),pix.height()));
}
void MyPushButton::Zoom1(){
     QPropertyAnimation *animation=new QPropertyAnimation(this,"geometry");
     animation->setDuration(200);
     animation->setStartValue(QRect(this->x(),this->y(),this->width(),this->height()));
     animation->setEndValue(QRect(this->x(),this->y()+10,this->width(),this->height()));
     animation->setEasingCurve(QEasingCurve::OutBounce);
     animation->start();
 }
 void MyPushButton::Zoom2(){

     QPropertyAnimation *animation=new QPropertyAnimation(this,"geometry");
     animation->setDuration(200);
     animation->setStartValue(QRect(this->x(),this->y()+10,this->width(),this->height()));
     animation->setEndValue(QRect(this->x(),this->y(),this->width(),this->height()));
     animation->setEasingCurve(QEasingCurve::OutBounce);
     animation->start();
}
 void  MyPushButton::mousePressEvent(QMouseEvent *e)
    {

     if(this->pressedImgPath!="")
     {
        QPixmap pix;
        pix.load(this->pressedImgPath);
        bool ret=pix.load(this->pressedImgPath);
        if(!ret)
        {
            qDebug()<<"图片加载失败";
            return;
        }

        this->setFixedSize(pix.width(),pix.height());

        this->setStyleSheet("QPushButton{border:0px;}");
        this->setIcon(pix);
        //设置图片大小
        this->setIconSize(QSize(pix.width(),pix.height()));

     }
//其他事情交给父类
     QPushButton::mousePressEvent(e);
 }


 void  MyPushButton::mouseReleaseEvent(QMouseEvent *e)
 {
     if(this->pressedImgPath!="")
     {
        QPixmap pix;
        pix.load(this->pressedImgPath);
        bool ret=pix.load(this->normalImgPath);
        if(!ret)
        {
            qDebug()<<"图片加载失败";
            return;
        }
        //设定图片大小
        this->setFixedSize(pix.width(),pix.height());
        //设置不规则图片的样式
        this->setStyleSheet("QPushButton{border:0px;}");
        //设置图片
        this->setIcon(pix);
        //设置图片大小
        this->setIconSize(QSize(pix.width(),pix.height()));

     }
//其他事情交给父类
     QPushButton::mouseReleaseEvent(e);





 }


