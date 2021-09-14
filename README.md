# TWTagsCollectionView

[![CI Status](https://img.shields.io/travis/acct<blob>=0xE69D8EE69993E696B9/TWTagsCollectionView.svg?style=flat)](https://travis-ci.org/acct<blob>=0xE69D8EE69993E696B9/TWTagsCollectionView)
[![Version](https://img.shields.io/cocoapods/v/TWTagsCollectionView.svg?style=flat)](https://cocoapods.org/pods/TWTagsCollectionView)
[![License](https://img.shields.io/cocoapods/l/TWTagsCollectionView.svg?style=flat)](https://cocoapods.org/pods/TWTagsCollectionView)
[![Platform](https://img.shields.io/cocoapods/p/TWTagsCollectionView.svg?style=flat)](https://cocoapods.org/pods/TWTagsCollectionView)
## 功能
- 在业务中经常会使用各自标签
- 本组件是方便快速接入，根据你的配置，不需要去额外计算字符串长度
- 同时支持三种对齐方式，居左，居中，居右
- 支持自定义 cell 方式

## Example

```swift
/* 配置对象 TWTagsCollectionCellModel */
/// 剩余文本间隙
public var gap: CGFloat = 4
/// 文本背景色
public var titleBgColor: UIColor = UIColor.white.withAlphaComponent(0.1) 
/// 文本颜色
public var titleColor: UIColor =  UIColor.black // TWColor_2478d2!
/// 文本对齐方式
public var titleAlignment: NSTextAlignment = .center
/// 文本字体
public var font: UIFont = UIFont.systemFont(ofSize: 10)
/// cell 高度
public var height: CGFloat = 14
/// 图片 icon
public var icon: String = ""
/// 图片位置
public var iconPosition: TWTagsCollectionIconPosition = TWTagsCollectionIconPosition.zero
/// cell 边框
public var borderWidth: CGFloat = 0
/// cell 边框颜色
public var borderColor: UIColor?
/// cell 边框弧度
public var cornerRadius: CGFloat = 0
/// 文本
public var title: String = ""
/// 文本宽度
public var titleWidth: CGFloat = 0
```

```
/* DEMO */
fileprivate lazy var tagsView: TWTagsCollectionView = {
        var configure = TWTagsCollectionViewConfigure()
        configure.alignedType = .left
        configure.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let tagsView = TWTagsCollectionView(frame: .zero, configure: configure)
        tagsView.delegate = self
        tagsView.observerContentSizeBlock = { [weak self] size in
            guard let self = self else { return }
            self.tagViewHeigth = size.height
            tagsView.snp.updateConstraints { make in
                make.height.equalTo(self.tagViewHeigth)
            }
        }
        return tagsView
    }()
    
    fileprivate var tagViewHeigth: CGFloat = 0
    
    fileprivate lazy var dataSource: [TWTagsCollectionCellModel] = {
        var models: [TWTagsCollectionCellModel] = []
        let titles: [String] = [
            "iOS",
            "Android",
            "PHP",
            "Java",
            "hello word",
            "welcome in china",
            "my name is zhengzeqin",
            "china is number 1"
        ]
        for (i, title) in titles.enumerated() {
            let model = TWTagsCollectionCellModel()
            model.gap = 16
            model.height = 24
            model.titleColor = UIColor.randomColor
            model.titleBgColor = UIColor.randomColor
            model.font = UIFont.systemFont(ofSize: 12)
            if i % 2 == 0 {
                var iconPosition = TWTagsCollectionIconPosition()
                iconPosition.height = 12
                iconPosition.width = 12
                iconPosition.left = 3
                iconPosition.right = 2
                iconPosition.top = 5
                model.iconPosition = iconPosition
                model.icon = "rent_house_tag"
                model.cornerRadius = 8
                model.gap = 6
                model.titleAlignment = .left
            }
            model.title = title
            model.updateTitle()
            models.append(model)
        }
        return models
  }()
tagsView.dataSource = dataSource
```

- 基于 collectionView 封装的标签组件
- 支持自定义 cell
* 效果

<img src="https://github.com/zeqinjie/TWTagsCollectionView/blob/main/assets/1.jpeg" width="375" height="667" align="middle"/>
<img src="https://github.com/zeqinjie/TWTagsCollectionView/blob/main/assets/2.jpeg" width="375" height="667" align="middle"/>
<img src="https://github.com/zeqinjie/TWTagsCollectionView/blob/main/assets/3.jpeg" width="375" height="667" align="middle"/>

## Requirements

## Installation

TWTagsCollectionView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TWTagsCollectionView'
```

## Version
- v0.1.0
        - 在业务中经常会使用各自标签
        - 本组件是方便快速接入，根据你的配置，不需要去额外计算字符串长度
        - 同时支持三种对齐方式，居左，居中，居右
        - 支持自定义 cell 方式      
- v0.2.0
        - 重命名
        - 修复 bug 移除 self.contentSizeObserver 


## Author

zhengzeqin, zhengzeqin@addcn.com

## License

TWTagsCollectionView is available under the MIT license. See the LICENSE file for more info.
