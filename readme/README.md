# 数据传输

两个流程，分正反两个方向

正方向，前端数据输出到报告

第一步：前端数据导出json格式

第二步：json格式传递给后端

第三步：后端导出文件

第四步：根据文件生成word报告

反方向：

第一步：读取word报告，生成json格式

第二步：json格式传递给后端

第三步:后端导入到前端

## 第一步：前端数据导出json格式

##  第N步：前端数据导出json格式





QML调用c++函数

main函数

```c++
  //将函数注册到QML,为了不被析构只能放在这里了？
    #include"./button/func_/jsonrelative.h"
    jsonrelative j("11",99);
    qmlRegisterSingletonInstance("JieModule",1,0,"Jsonfunc",&j);
```

```c++
// 首先定义一个基于OBject的类，也就是准备注册到QML的类
class SingletonTypeExample : public QObject
{
    Q_OBJECT //必须要
    Q_PROPERTY (int someProperty READ someProperty WRITE setSomeProperty NOTIFY somePropertyChanged)//重定义变量/读/写/改方法

public:
    SingletonTypeExample(QObject* parent = 0)
        : QObject(parent), m_someProperty(0)
    {
    }

    ~SingletonTypeExample() {}

    Q_INVOKABLE int doSomething() { setSomeProperty(5); return m_someProperty; } //Q_INVOKABLE 方便QML系统回调

    int someProperty() const { return m_someProperty; }
    void setSomeProperty(int val) { m_someProperty = val; emit somePropertyChanged(val); }

signals:
    void somePropertyChanged(int newValue);

private:
    int m_someProperty;
};

// 第二步定义一个回调类指针,用于接收回调.
static QObject *example_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    SingletonTypeExample *example = new SingletonTypeExample();
    return example;
}

```

```c++
qmlRegisterSingletonType<SingletonTypeExample>("Qt.example.qobjectSingleton", 1, 0, "MyApi", example_qobject_singletontype_provider);
在QML中使用
import QtQuick 2.0
import Qt.example.qobjectSingleton 1.0
Item {
    id: root
    property int someValue: MyApi.someProperty

    Component.onCompleted: {
        someValue = MyApi.doSomething()
    }
}

```

注：此处有大坑！！！

如果将注册单根类不放在主函数中而放在构造类中，构造函数可执行，但是类函数执行会报错：

```
<Unknown File>: The registered singleton has already been deleted. Ensure that it outlives the engine.

<Unknown File>: qmlRegisterSingletonType(): "Jsonfunc" is not available because the callback function returns a null pointer.

TypeError: Property 'printInfo' of object [object Object] is not a function
```



