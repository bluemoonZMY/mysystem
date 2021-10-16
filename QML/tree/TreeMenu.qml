import QtQuick 2.14
import QtQuick.Controls 2.14

Menu {
    property var target
    MenuItem {
        enabled: target.isAddBrother
        text: "Add item above"
        onTriggered: {
            var curItem = target.getCurrentItem()
            if(curItem){
                var parentItem = curItem.parent();
                if(parentItem){
                    var item = target.createItem("请输入名称", target.iconName);

                    var pos = parentItem.indexOfChildItem(curItem);
                    parentItem.insertChild(pos, item);
                    target.itemCreated(item);
                }
            }
        }
    }
    MenuItem {
        enabled: target.isAddBrother
        text: "Add item below"
        onTriggered: {
            var curItem = target.getCurrentItem();
            if(curItem){
                var parentItem = curItem.parent();
                if(parentItem){
                    var item = target.createItem("请输入名称", target.iconName);

                    var pos = parentItem.indexOfChildItem(curItem);
                    if(pos < parentItem.childernCount() - 1){
                        parentItem.insertChild(pos + 1, item);
                    }else{
                        parentItem.appendChild(item);
                    }
                    target.itemCreated(item);
                }
            }
        }
    }
    MenuItem {
        text: "Add child item"
        enabled: target.isAddChild
        onTriggered: {
            var curItem = target.getCurrentItem();
            if(curItem){
                var item = target.createItem("请输入名称", target.iconName);

                curItem.appendChild(item);
                curItem.setExpanded(true);
                target.itemCreated(item);
            }
        }
    }

    MenuSeparator {}
    MenuItem {
        text: "Rename"
        enabled: target.isRename
        onTriggered: {
            var curItem = target.getCurrentItem();
            if(curItem){
                target.reName(curItem);
            }
        }
    }
    MenuSeparator {}
    MenuItem {
        text: qsTr("Delete")
        enabled: target.isDelete
        onTriggered: {
            var curItem = target.getCurrentItem();
            if(curItem){
                //var pageFlag = curItem.getExtraParameters();
                var parentItem = curItem.parent();
                if(parentItem){
                    parentItem.removeChild(curItem);

                    //target.itemRemoved(pageFlag);
                }
            }
        }
    }
}
