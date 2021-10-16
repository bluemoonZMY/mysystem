/*
文件名必须是大写
引擎是Qv4。只能支持标准是es5
by———康亚卓
*/

//随机数生成
function getRangeRandom(max){
    return Math.floor(Math.random()*max)
}
//随机颜色生成
function getColorRandom(){
    let red = getRangeRandom(256)
    let green = getRangeRandom(256)
    let blue= getRangeRandom(256)
    return{
        red:red/255,green:green/255,blue:blue/255

    }
}
//闭包函数
function getColorBulider(rgbFunction){
    return function(){

        let color=getColorRandom()
        return rgbFunction(color.red,color.green,color.blue)
    }
}
