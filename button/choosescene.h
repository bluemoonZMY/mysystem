#ifndef CHOOSESCENE_H
#define CHOOSESCENE_H

#include <QMainWindow>
#include<QPainter>
#include"mypushbutton.h"
#include <QQuickWidget>
#include"src/intellectest/intellectest.h"
#include"src/management/management.h"
class choosescene : public QMainWindow
{
    Q_OBJECT
public:
    explicit choosescene(QWidget *parent = nullptr);
void paintEvent(QPaintEvent *);

QQuickWidget * quickWidget;
void velqml();
intellectest *inTellectest=NULL;
management *manageMent =NULL;
signals:

};

#endif // CHOOSESCENE_H
