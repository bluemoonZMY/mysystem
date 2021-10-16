import QtQuick 2.14
import QtQuick.Controls 2.14

Item {
    id: treeDemo
    clip: true

    property alias treeName: tree
    signal textChanged(var item)
    signal itemRemoved(var flags)
    signal currentItemDoubleClicked(var item)

    Dialog {
        id: renameDialog
        anchors.centerIn: Overlay.overlay
        modal: true
        title: "Rename"
        width: 300
        property alias curName: textName.text
        standardButtons: Dialog.Ok | Dialog.Cancel
        Column {
            anchors.fill: parent
            Label {
                text: "Re-entering the name"
            }
            TextField {
                id: textName
                width: 200
                height: 40
                clip: true
                selectByMouse: true
                onAccepted: renameDialog.close()
            }
        }
        onAccepted: {
            var curItem = tree.getCurrentItem()
            if(curItem) {
                curItem.setText(textName.text)
                treeDemo.textChanged(curItem)
            }
        }
    }

    Tree {
        id: tree
        anchors.fill: parent
        anchors.margins: 2
        property bool isDelete: getCurrentItemLevel() > 1 ? true : false
        property bool isAddBrother: getCurrentItemLevel() > 0 ? true : false
        property bool isAddChild: getCurrentItemLevel() > 0 ? true : false
        property bool isRename: true
        property string iconName: "qrc:/QML/tree/i-file-16.svg"
        rightMenu: TreeMenu { target: tree }
        onItemRemoved: {
            treeDemo.itemRemoved(flags)
        }
        onItemCreated: {

        }
        onCurrentItemDoubleClicked: {
            treeDemo.currentItemDoubleClicked(item)
        }
        onSetItemIcon: {
            var icon = function(value)
            {
                if(value != "") item.setItemIcon(value);
            }
            //定义openDialog方法保存图标
            //pageIconSelectDialog.openDialog(icon);
        }

        function reName(curItem) {
            renameDialog.curName = curItem.text()
            renameDialog.open()
            textName.forceActiveFocus()
        }
    }
}
