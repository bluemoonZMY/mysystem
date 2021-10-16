import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Controls.impl 2.14
import "treeitem.js" as TreeItem

Rectangle {
    id: control
    //根级的项
    property var rootItem: new TreeItem.TreeItem("","",null)
    //当前的项,供treeitem.js 与 构建树节点时使用
    property var currentItem: null
    //数据模型
    property var modelData: []
    //右键菜单
    property Menu rightMenu
    //项的枚举
    readonly property int selectionNone: TreeItem.SELECTION_NONE
    readonly property int selectionCurrent: TreeItem.SELECTION_CURRENT
    readonly property int selectionSelected: TreeItem.SELECTION_SELECTED
    //图标大小
    property size iconSize: Qt.size(17,17)
    //默认字体
    property font font: Qt.font({family:"Microsoft YaHei",pixelSize:17})
    //默认样式
    //树的大背景颜色
    property color backgroundFill: "transparent"
    //树的项背景颜色
    property color backgroundNormal: Qt.rgba(255,255,255)
    //文本的前景色
    property color foregroundNormal: Qt.rgba(0,0,0)
    //树的项鼠标经过时的背景颜色
    property color backgroundHovered: Qt.rgba(47/255,82/255,143/255,130/255)
    //背景经过颜色47/255,82/255,143/255,230/255
    property color foregroundHovered: Qt.rgba(1,1,1)
    //当前项的背景颜色
    property color backgroundCurrent: Qt.rgba(47/255,82/255,143/255,230/255)
    //当前项的文本颜色
    property color foregroundCurrent: Qt.rgba(1,1,1)
    //选择颜色
    property color selectionFlagColor: "transparent"
    //展开图标
    property string uriExpandIcon: "qrc:/QML/tree/i-expand-16.svg"
    //折叠图标
    property string uriCollapseIcon: "qrc:/QML/tree/i-collpase-16.svg"

    //删除项
    signal itemRemoved(var flags)
    //添加项
    signal itemCreated(var item)
    //双击当前项
    signal currentItemDoubleClicked(var item)
    //单击当前项
    signal currentItemClicked(var item)
    //鼠标经过当前项
    signal currentItemEntered(var item)
    //鼠标离开当前项
    signal currentItemExited(var item)
    //设置图标
    signal setItemIcon(var item)

    //设置宽高
    implicitWidth: 300
    implicitHeight: parent.height
    //设置背景颜色透明
    color: backgroundFill
    //裁剪溢出
    clip: true

    //数据模型供treeitem.js 与 ListView构建树结构时使用
    ListModel { id: listModel }

    //用ListView构建树
    ListView {
        id: listView
        anchors.fill: parent
        model: listModel
        delegate: delegateRoot
        Component.onCompleted: {
            rootItem.setExpanded(true)
            listModel.append(rootItem)
        }
        ScrollBar.vertical: ScrollBar {}

    }

    //ListView代理,一级节点
    Component {
        id: delegateRoot
        Column {
            Repeater {
                model: subNodes
                delegate: delegateItems
            }
        }
    }
    //节点的代理
    Component {
        id: delegateItems
        Column {
            //当前项
            Rectangle {
                id: itemRect
                width: listView.width
                height: itemRow.implicitHeight + 6
                //项的背景颜色
                color: (selectionFlag == TreeItem.SELECTION_CURRENT) ? backgroundCurrent : backgroundNormal

                //根据id或获取项
                function getItem(){
                    var item = parentNode, vPath = [itemID];
                    while(item){
                        vPath.splice(0, 0, item.itemID);
                        item = item.parentNode;
                    }

                    var children = [rootItem];
                    for(var i = 0; i < vPath.length; i++){
                        var bFound = false;
                        for(var j = 0; j < children.length; j++){
                            var child = children[j];
                            if(vPath[i] === child.itemID){
                                if(i == vPath.length - 1){
                                    return child;
                                }else{
                                    children = child.subNodes;
                                    bFound = true;
                                    break;
                                }
                            }
                        }
                        if(!bFound){
                            return null;
                        }
                    }
                }
                //操作节点项的动作
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {

                        itemRect.color = backgroundHovered
                        textTitle.color = foregroundHovered
                        imageIndicator.icon.color = foregroundHovered
                        imageIcon.icon.color = foregroundHovered

                    }
                    onExited: {
                        itemRect.color = Qt.binding(function(){
                            return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? backgroundCurrent : backgroundNormal)
                        })
                        textTitle.color = Qt.binding(function(){
                            return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal)
                        })
                        imageIcon.icon.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal);});
                        imageIndicator.icon.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal);});
                    }
                    onClicked: {
                        var item = itemRect.getItem()
                        if(currentItem)
                            currentItem.setSelectionFlag(TreeItem.SELECTION_NONE)
                        if(item)
                            item.setSelectionFlag(TreeItem.SELECTION_CURRENT)
                    }
                }
                //右键的action
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.RightButton
                    onClicked: {
                        var item = itemRect.getItem()
                        if(currentItem)
                            currentItem.setSelectionFlag(TreeItem.SELECTION_NONE)
                        if(item)
                            item.setSelectionFlag(TreeItem.SELECTION_CURRENT)
                        if(rightMenu != undefined)
                            rightMenu.popup()
                    }
                }
                Row {
                    id: itemRow
                    anchors.verticalCenter: itemRect.verticalCenter
                    height: textTitle.implicitHeight
                    //选择标识
                    Rectangle {
                        width: 3
                        height: parent.height
                        color: selectionFlag != TreeItem.SELECTION_NONE ? selectionFlagColor : "transparent"
                    }
                    //占位
                    Item {
                        width: getIndent()
                        height: parent.height
                        function getIndent() {
                            var item = itemRect.getItem()
                            console.log(item.level() + "/n")
                            return (item ? (item.level() -1) : 0) * 20 + 10
                        }
                    }
                    //展开与收起
                    MouseArea {
                        id: itemIndicator
                        width: imageIndicator.width + 4
                        height: imageIndicator.height + 4
                        anchors.verticalCenter: itemRow.verticalCenter
                        propagateComposedEvents: (subNodes.count == 0)
                        onClicked: {
                            if(subNodes.count > 0){
                                var item = itemRect.getItem();
                                item.setExpanded(!item.isExpanded());
                            }else{
                                mouse.accepted = false;
                            }
                        }
                        IconLabel {
                            id: imageIndicator
                            anchors.centerIn: parent
                            visible: subNodes.count > 0
                            icon.source: expanded ? uriCollapseIcon : uriExpandIcon
                            icon.width: iconSize.width
                            icon.height: iconSize.height
                            icon.color: (selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal
                        }
                    }
                    //图标
                    Item {
                        visible: (displayIcon != "")// treeitem.js  里的this.displayIcon
                        width: imageIcon.width + 4
                        height: imageIcon.height + 4
                        anchors.verticalCenter: itemRow.verticalCenter
                        IconLabel {
                            id: imageIcon
                            anchors.centerIn: parent
                            icon.source: displayIcon
                            icon.width: iconSize.width
                            icon.height: iconSize.height
                            icon.color: (selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal
                        }
                    }
                    //标题
                    Label {
                        id: textTitle
                        anchors.verticalCenter: itemRow.verticalCenter
                        width: control.width * 2 / 3
                        color: (selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal
                        font: control.font
                        textFormat: Label.AutoText
                        text: displayText
                        MouseArea {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: -5
                            anchors.bottomMargin: -5
                            hoverEnabled: true
                            onEntered: {

                                itemRect.color = backgroundHovered;
                                textTitle.color = foregroundHovered;
                                imageIndicator.icon.color = foregroundHovered
                                imageIcon.icon.color = foregroundHovered


                                var item = itemRect.getItem();
                                if(item)
                                    currentItemEntered(item);
                            }
                            onExited: {
                                itemRect.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? backgroundCurrent : backgroundNormal);});
                                textTitle.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal);});
                                imageIcon.icon.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal);});
                                imageIndicator.icon.color = Qt.binding(function(){return ((selectionFlag == TreeItem.SELECTION_CURRENT) ? foregroundCurrent : foregroundNormal);});
                                var item = itemRect.getItem();
                                if(item)
                                    currentItemExited(item);
                            }
                            onClicked: {
                                var item = itemRect.getItem();
                                if(currentItem) currentItem.setSelectionFlag(TreeItem.SELECTION_NONE);
                                if(item){
                                    item.setSelectionFlag(TreeItem.SELECTION_CURRENT);
                                    if(item.level() > 0)
                                    {
                                        currentItemClicked(item);
                                    }
                                }
                            }
                            onDoubleClicked: {
                                if(getCurrentItemLevel() > 0)
                                {
                                    currentItemDoubleClicked(getCurrentItem());
                                }
                            }
                        }
                    }
                }
            }
            Item {
                visible: expanded
                width: repeaterSubNodes.implicitWidth
                height: repeaterSubNodes.implicitHeight
                Column {
                    id: repeaterSubNodes
                    Repeater {
                        model: subNodes
                        delegate: delegateItems
                    }
                }
            }
        }
    }

    function createItem(text, icon, parent) {
        return new TreeItem.TreeItem(text, icon, parent)
    }


    function topLevelItem(index) {
        return rootItem.childItem(index)
    }

    function indexOfTopLevelItem(item) {
        return rootItem.indexOfChildItem(item)
    }

    function addTopLevelItem(item) {
        rootItem.appendChild(item)
    }

    function takeTopLevelItem(item) {
        rootItem.removeChild(indexOfTopLevelItem(item))
    }

    function getCurrentItem() {
        return currentItem
    }

    function getCurrentItemLevel() {
        if(getCurrentItem())
            return getCurrentItem().level()
        else
            return -1;
    }

    function getItemIndex(item)
    {
        if(item){
            var parentItem = item.parent();
            if(parentItem){
                return parentItem.indexOfChildItem(item);
            }
        }
        else
            return -1;
    }
}
