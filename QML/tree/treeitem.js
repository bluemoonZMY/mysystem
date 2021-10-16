/*
  *全局常量
  *定义数的id和选择情况
*/
var _TREE_ITEM_ID_MIN = 100; //最小id
var _TREE_ITEM_ID_INVALID = -1; //无效id
var _TREE_ITEM_ID_CURRENT = _TREE_ITEM_ID_MIN;//当前的id
//枚举定义
var SELECTION_NONE = 0; //未选择
var SELECTION_CURRENT = 1; //当前选择
var SELECTION_SELECTED = 2; //已选择

/*
  *初始化树的项
  *数据初始化
  *text:文本;icon:图标;parent:父级节点
*/
function TreeItem(text, icon, parent) {
    //分配id,每次实例化在当前项的id上加1
    var __allocateID = function() {
        return (_TREE_ITEM_ID_CURRENT++);
    };
    //项的id
    this.itemID = __allocateID();
    //项的文本
    this.displayText = text;
    //项的图标
    this.displayIcon = icon;
    //是否展开
    this.expanded = true;
    //选择的标识,默认是不选择任何项
    this.selectionFlag = SELECTION_NONE;
    //事件标识,默认为空字符串,如单击或双击事件
    this.actionFlag = "";
    //参数
    this.parameters = "";
    //子级组件
    this.subComponents = [];
    //默认图标,使用字体图标先设为空字符
    this.iconName = "";
    //父级节点,默认为空
    this.parentNode = null;
    //所有子级,默认为空数组
    this.subNodes = [];
    //如果存在父级节点,添加它的子级
    if(parent) {
        parent.appendChild(this);
    }
}
/*
  *附加方法和属性
*/
TreeItem.prototype = {
    //指定构造方法名
    constructor: TreeItem
    //获取项的数据模型
    ,__getItemFromModel: function() {
        var item = this, vPath = [];
        while(item) {
            //在数组的第0的位置前添加项的id
            vPath.splice(0,0,item.itemID);
            //指定父级节点
            item = item.parentNode;
        }
        //数据模型
        var model = listModel;
        //遍历数组与数据模型对比id,查找当前项及它的子级项
        for(var i = 0; i < vPath.length; i++){
            var bFound = false;
            for(var j = 0; j < model.count; j++){
                var node = model.get(j);
                if(vPath[i] === node.itemID){
                    if(i == vPath.length - 1){
                        return node;
                    }else{
                        model = node.subNodes;
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
    //项的层级
    ,level: function() {
        var level = 0, item = this;
        while(item.parentNode) {
            item = item.parentNode;
            level++;
        }
        return level;
    }
    //添加子级
    ,appendChild: function(item) {
        if(item.parentNode){
            item.parentNode.removeChild(item);
        }
        item.parentNode = this;

        this.subNodes.push(item);

        var node = this.__getItemFromModel();
        if(node){
            node.subNodes.append(item);
        }
    }
    //插入子级
    ,insertChild: function(pos, item){
        if(item.parentNode){
            item.parentNode.removeChild(item);
        }
        item.parentNode = this;

        this.subNodes.splice(pos, 0, item);

        var node = this.__getItemFromModel();
        if(node){
            node.subNodes.insert(pos, item);
        }
    }
    // 删除子级
    ,removeChild: function(item){
        var i = this.subNodes.indexOf(item);
        this.subNodes.splice(i, 1);
        item.parentNode = null;

        var currentSelectionFlag = item.getSelectionFlag();
        // 清除选择标识当删除当前项的时候
        item.setSelectionFlag(SELECTION_NONE);
        //删除当前项之后选择下个项为当前项
        if(currentSelectionFlag === SELECTION_CURRENT){
            if(this.subNodes.length > 0){
                var nextCurrent = i;
                if(nextCurrent >= this.subNodes.length){
                    nextCurrent = this.subNodes.length - 1;
                }
                this.subNodes[nextCurrent].setSelectionFlag(SELECTION_CURRENT);
            }else{
                if(this.itemID !== rootItem.itemID) this.setSelectionFlag(SELECTION_CURRENT);
            }
        }


        var node = this.__getItemFromModel();
        if(node){
            node.subNodes.remove(i);
        }

    }
    //根据索引获取子级项
    ,childItem: function(index){
        return this.subNodes[index];
    }
    //获取子级项的索引
    ,indexOfChildItem: function(item){
        for(var i = 0; i < this.subNodes.length; i++){
            if(this.subNodes[i].itemID === item.itemID){
                return i;
            }
        }
        return -1;
    }
    //统计子级项的数量
    ,childernCount: function(recursive){
        if(!recursive) recursive = false
        var count = this.subNodes.length;
        if(recursive){
            for(var i = 0; i < this.subNodes.length; i++){
                count += this.subNodes[i].childernCount(recursive);
            }
        }
        return count;
    }
    //获取父级项
    ,parent: function(){
        return this.parentNode;
    }

    ,setText: function(text){
        this.displayText = text;

        var node = this.__getItemFromModel();
        if(node){
            node.displayText = text;
        }
    }
    ,text: function(){
        return this.displayText;
    }

    ,setIcon: function(source){
        this.displayIcon = source;

        var node = this.__getItemFromModel();
        if(node){
            node.displayIcon = source;
        }
    }
    ,icon: function(){
        return this.displayIcon;
    }

    ,setExpanded: function(expanded){
        this.expanded = expanded;

        var node = this.__getItemFromModel();
        if(node){
            node.expanded = expanded;
        }
    }
    ,isExpanded: function(){
        return this.expanded;
    }

    ,setSelectionFlag: function(flag){
        this.selectionFlag = flag;
        if(flag === SELECTION_CURRENT){
            currentItem = this;
        }else{
            if(currentItem) {
                if(currentItem.itemID === this.itemID){
                    currentItem = null;
                }
            }
        }

        var node = this.__getItemFromModel();
        if(node){
            node.selectionFlag = flag;
        }
    }
    ,getSelectionFlag: function(){
        return this.selectionFlag;
    }

    ,setActionFlag: function(flag){
        this.actionFlag = flag;
    }
    ,getActionFlag: function(){
        return this.actionFlag;
    }
    ,setExtraParameters: function(para){
        this.parameters = para;
    }
    ,getExtraParameters: function(){
        return this.parameters;
    }
    ,setSubComponents: function(comArray){
        this.subComponents = comArray;
    }
    ,getSubComponents: function(){
        return this.subComponents;
    }
    ,setItemIcon: function(iconName){
        this.iconName = iconName;
    }
    ,itemIcon: function(){
        return this.iconName;
    }
}
