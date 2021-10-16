import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.14

import'./Jiejs.js' as Jie

Item{
    id:sheet1jieItem
    anchors.fill: parent

    //颜色随机生成器
    property var colorBuilder:Jie.getColorBulider(Qt.rgba)
    //全局表示

    //最上用来切换页面的按钮

    ListView{
        id:header
        height:30
        clip:true//保证不超出范围
        width:parent.width
        orientation: ListView.Horizontal
        model:[

            json_obj.json_back(),

            json_obj.json_back(),
            json_obj.json_back()
        ]
        delegate:ItemDelegate
        {
            highlighted: ListView.isCurrentItem
            width:100
            text:(header.currentIndex===index?'☑':'☐')+modelData.name+modelData.power
            background:Rectangle{
                color:sheet1jieItem.colorBuilder()
            }
            onClicked:{
                header.currentIndex=index
                layout.currentIndex=index

            }
        }
        Component.onCompleted: {
            let modeltemp=header.model
            modeltemp.push({name:"加",aaa:"111"})
            header.model=modeltemp     //这样才能够生效
console.log(model)
        }

    }
    StackLayout {
        id: layout
        anchors.top:header.bottom
        anchors.bottom:parent.bottom
        anchors.left:header.left
        anchors.right:header.right

        Component {
            id:pageComponent
            Rectangle {

            }
        }
        Component.onCompleted:{
            let menus=['大娃','二娃','三娃']
            menus.forEach(function(color,index){
                pageComponent.createObject(layout,{color:sheet1jieItem.colorBuilder(),index:layout.currentIndexs})
            })
        }
    }
}










