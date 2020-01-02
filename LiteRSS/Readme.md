# 说明文档


```swift
// 关键字别名，例如 description 是系统的关键字，那我们用别名 descriptions 代替
override internal func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
    return [("descriptions", "description")]
}
```


1. [AlamofireXmlToObjects](https://github.com/evermeer/AlamofireXmlToObjects)
2. [Swift 原生Xml解析](https://www.cnblogs.com/chenxiaopao/p/9142873.html)