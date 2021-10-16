import QtQuick 2.0
import QtQuick.Controls 2.5
import'./Jiejs.js' as Jie
Item {
    id:sheet2jieItem
    anchors.fill:parent
    //颜色随机生成器
    property var colorBuilder:Jie.getColorBulider(Qt.rgba)

    ListView{
        clip:true//保证不超出范围
        anchors.fill: parent
        id:sheet2jieList
        model:[
            {
                name:"大娃",
                power:"金刚"
            },
            {
                name:"二娃",
                power:"冰冻"
            },
            {
                name:"三娃",
                power:"无敌"
            },
            {
                name:"三娃",
                power:"无敌",
                dddd:"111"
            }

        ]
        delegate:ItemDelegate
        {
            width:sheet2jieList.width
            text:modelData.name+modelData.power+(sheet2jieList.currentIndex===index?'√':'')
            background:Rectangle{
                color:sheet2jieItem.colorBuilder()
            }
            onClicked:{
                sheet2jieList.currentIndex=index
            }
        }
        //添加横竖滚动条
        ScrollBar.vertical:ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}

        //组件完成，添加
        Component.onCompleted: {
            let modeltemp=sheet2jieList.model
            modeltemp.push({name:"加",aaa:"111"})
            sheet2jieList.model=modeltemp     //这样才能够生效

        }

    }
}
