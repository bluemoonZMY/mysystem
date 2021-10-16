import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import"tree"
import MyCppObject 1.0
import myjsonui_qml 1.0    //这个是
import "./qmlsheet"
import"./controlsheet"
Window {
    id: mainWindow
    visible: true
    width:1600
    height:950
    title:qsTr("报告生成")
    //flags:Qt.FramelessWindowHint
    color: "#e6edf5"
    property alias treeItemRec: treeItemRec
    property alias treeItemBottomLine: treeItemBottomLine
    minimumHeight: 700
    minimumWidth: 850
    //信号槽

    Item{
        id:treeItem
        anchors.top: chooseBar.bottom
        anchors.left: leftItem.right
        width:250
        anchors.bottom: search.top
        Rectangle{
            id:treeItemRightLine
            anchors.top:parent.top
            anchors.bottom:parent.bottom
            anchors.right:parent.right
            width:2
            color:"#c3c3c3"
        }
        Rectangle{
            id:treeItemtop
            anchors.top:parent.top
            anchors.left:parent.left
            anchors.right:treeItemRightLine.left
            height:30
            color:"#e6edf5"


            Text {
                x:20
                y:5
                text: "机种"
                font.family: "Helvetica"
                // font.pointSize: 16

            }
            Image{
                anchors.top:parent.top
                anchors.bottom:parent.bottom
                anchors.right:parent.right
                source: "images/icon4.png"
                width:parent.height

            }
        }
        Rectangle{
            id:treeItemBottomLine
            anchors.bottom:parent.bottom
            anchors.left: parent.left
            anchors.right:treeItemRightLine.left
            height: 2
            color:"#c3c3c3"
        }
        Rectangle{
            id:treeItemRec
            anchors.top: treeItemtop.bottom
            anchors.left:parent.left
            anchors.right:treeItemRightLine.left
            anchors.bottom:treeItemBottomLine.top
            TreeDemo {
                id: treeDemo
                anchors.fill: parent
                anchors.margins: 10

                Component.onCompleted: {
                    var treeRootItem = treeName.createItem("第一层","qrc:/QML/tree/i-file-16.svg")
                    treeRootItem.setSelectionFlag(treeName.selectionCurrent)
                    treeName.addTopLevelItem(treeRootItem)

                    var item01 = treeName.createItem("第二层","qrc:/QML/tree/i-file-16.svg")
                    treeRootItem.appendChild(item01)

                    var item02 = treeName.createItem("第三层","qrc:/QML/tree/i-image-16.svg")
                    treeRootItem.appendChild(item02)

                    var item03 = treeName.createItem("大气层","qrc:/QML/tree/i-save-16.svg")
                    treeRootItem.appendChild(item03)
                }
            }

        }
    }
    Image {
        id: titleBar
        x:0
        y:0
        anchors.top: parent.top             //对标题栏定位
        anchors.left: parent.left
        anchors.right: parent.right
        height:30
        source: "images/top.jpg"
        cache: false
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            property point clickPos: "0,0"
            onPressed: {
                clickPos = Qt.point(mouse.x, mouse.y)
            }


            onPositionChanged: {
                //鼠标偏移量
                var delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)


                //如果mainwindow继承自QWidget,用setPos
                mainWindow.setX(mainWindow.x + delta.x)
                mainWindow.setY(mainWindow.y + delta.y)
            }
        }
        Image {
            id: closeButton
            x:0
            anchors.right: parent.right
            width: parent.height
            height: width
            source: "images/close.jpg"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainWindow.close()               //退出程序
                }
            }}
        Image {
            id: minButton
            x: 0
            anchors.right: closeButton.left
            anchors.rightMargin: 1
            width: parent.height
            height: width
            source: "images/min.jpg"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    mainWindow.showMinimized()        //窗口最小化
                }
            }

        }
    }
    Rectangle{
        id:leftBar
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top:titleBar.bottom
        width:5
        color:"#2f528f"
    }
    Rectangle{
        id:bottomBar
        anchors.left: leftBar.right
        anchors.right: parent.right
        anchors.bottom:parent.bottom
        height:5
        color:"#2f528f"
    }
    Rectangle{
        id:rightBar
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom:bottomBar.top
        width:5
        color:"#2f528f"
    }
    Item{
        id:menuBar
        anchors.top: titleBar.bottom
        anchors.left: leftBar.right
        anchors.right: rightBar.left
        height:28
        Rectangle{
            id:menuBar1
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right:parent.right
            height:2
            color:"#41719c"

        }
        Rectangle{
            id:menuBar2
            anchors.top:menuBar1.bottom
            anchors.left: parent.left
            anchors.right:parent.right
            height:24
            color:"#ededed"
            Text {
                y:2
                x:parent.x+15
                text: "文件（F）"
                font.family: "Helvetica"
                //  font.pointSize: 16 Qt5中不能加这句话
            }
            Text {
                y:2
                x:parent.x+115
                text: "编辑（E）"
                font.family: "Helvetica"
                // font.pointSize: 16       Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+215
                text: "构建（B）"
                font.family: "Helvetica"
                // font.pointSize: 16          Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+315
                text: "调试（F）"
                font.family: "Helvetica"
                //    font.pointSize: 16             Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+415
                text: "分析（A）"
                font.family: "Helvetica"
                //     font.pointSize: 16            Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+515
                text: "工具（T）"
                font.family: "Helvetica"
                //      font.pointSize: 16     Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+615
                text: "控件（W）"
                font.family: "Helvetica"
                // font.pointSize: 16     Qt5中不能加这句话

            }
            Text {
                y:2
                x:parent.x+715
                text: "帮助（H）"
                font.family: "Helvetica"
                //         font.pointSize: 16     Qt5中不能加这句话
            }
        }

        Rectangle{
            id:menuBar3
            anchors.top:menuBar2.bottom
            anchors.left: parent.left
            anchors.right:parent.right
            height:2
            color:"#c3c3c3"
        }
    }

    Item{
        id:chooseBar
        anchors.top: menuBar.bottom
        anchors.left: leftBar.right
        anchors.right: rightBar.left
        height:75
        Rectangle{
            id:chooseBar1
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.right:parent.right
            height:72
            color:"#e6edf5"
            Image{
                id:chooseimage1
                anchors.top:parent.top
                x:parent.x+10
                height:parent.height
                width:parent.height
                anchors.bottom: parent.bottom
                source: "images/icon1.png"

            }
            Image{
                id:chooseimage2
                anchors.top:parent.top
                x:parent.x+100
                height:parent.height
                width:parent.height
                anchors.bottom: parent.bottom
                source: "images/icon2.png"

            }
            Image{
                id:chooseimage3
                anchors.top:parent.top
                x:parent.x+190
                height:parent.height
                width:parent.height
                anchors.bottom: parent.bottom
                source: "images/icon3.png"
            }
        }
        Rectangle{
            id:chooseBar2
            anchors.top:chooseBar1.bottom
            anchors.left: parent.left
            anchors.right:parent.right
            height:3
            color:"#c3c3c3"
        }
    }
    Item{
        id:leftItem
        anchors.top:chooseBar.bottom
        anchors.left: leftBar.right
        anchors.bottom: bottomBar.top
        width:90

        Text {
            y:10
            x:parent.x+15
            text: "欢迎"
            font.family: "Helvetica"
            //    font.pointSize: 17

        }
        Text {
            y:50
            x:parent.x+15
            text: "编辑"
            font.family: "Helvetica"
            //     font.pointSize: 17

        }
        Text {
            y:90
            x:parent.x+15
            text: "调试"
            font.family: "Helvetica"
            //      font.pointSize: 17

        }
        Text {
            y:130
            x:parent.x+15
            text: "帮助"
            font.family: "Helvetica"
            //      font.pointSize: 17

        }
        Rectangle{
            anchors.left: parent.left
            anchors.right:parent.right
            y:run.y-parent.width
            height:2
            color:"#c3c3c3"
        }


        Image{
            id:config
            y:parent.height-parent.width
            x:20

            width:parent.width-40

            source: "images/config.png"
            height:parent.width-40

        }

        Image{
            id:bug
            y:config.y-parent.width
            x:20
            width:parent.width-40


            source: "images/bug.png"
            height:parent.width-40

        }

        Image{
            //信号槽函数测试
            function processB(str, value){
                console.log('信号槽函数测试', str, value)
            }
            Component.onCompleted:{
                // 1. Cpp对象的信号关联到 Qml的槽函数[js函数]
                cpp_obj.onCppSignalB.connect(processB)
            }
            id:run
            y:bug.y-parent.width
            x:20
            width:parent.width-40
            //定义别名
            CppObject{
                id: cpp_obj
            }
            Jsonui_qml{
                id:json_obj
            }
            MouseArea{
                anchors.fill:parent
                //点击调用cpp函数
                onClicked: {
                    cpp_obj.openUI()//打开文件界面
                    cpp_obj.cppSignalB("lisi", 1995)//测试信号
                    console.log(json_obj.json_back())//Obj信号
                }
            }
            source: "images/run.png"
            height:parent.width-40
        }
    }
    Item{
        id: search
        anchors.left:leftItem.right
        anchors.bottom:bottomBar.top

        width:treeItem.width
        height:40
        Rectangle{
            anchors.fill: parent
            color: "red"
        }
    }
    //第一个表格
    Item{
        id:sheet00item
        width:(parent.width-250)/3
        height:(parent.height-100)/3
        anchors.top: chooseBar.bottom
        anchors.left:treeItem.right
        anchors.topMargin: 10
        anchors.leftMargin: 10
        Sheet1{
            anchors.fill: parent
        }
    }
    //第二个表格
    Item{
        id:sheet01item
        width:(parent.width-250)/3
        height:(parent.height-100)/3
        anchors.top: chooseBar.bottom
        anchors.left:sheet00item.right
        anchors.topMargin: 10
        anchors.leftMargin: 10
        Sheet2{
            anchors.fill: parent
        }
    }
    //第三个表格
    Item{
        id:sheet10item
        width:(parent.width-250)/3
        height:(parent.height-100)/3
        anchors.top: sheet00item.bottom
        anchors.left:treeItem.right
        anchors.topMargin: 10
        anchors.leftMargin: 10
        Sheet3{
            anchors.fill: parent
        }
    }

    //第四个表格
    Item{
        id:sheet11item
        width:(parent.width-250)/3
        height:(parent.height-100)/3
        anchors.top: sheet01item.bottom
        anchors.left:sheet10item.right
        anchors.topMargin: 10
        anchors.leftMargin: 10
        Sheet4{
            anchors.fill: parent
        }
    }
    //控制台
    Item{
        id:controlItem
        width:(parent.width-250)/3
        height:(parent.height-100)/3
        anchors.left:treeItem.right
        anchors.top: sheet11item.bottom
        anchors.right: rightBar.left
        anchors.bottom:bottomBar.top
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        Controlbottom{
            anchors.fill: parent
        }
    }

    //最右流程
    Item{
        id:rightControlItem
        anchors.left:sheet01item.right
        anchors.right:rightBar.left
        anchors.top: chooseBar.bottom
        anchors.bottom: controlItem.top
        anchors.topMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        Controlright{
            anchors.fill: parent
        }
    }



}






