# BEEPopupKit

[![CI Status](https://img.shields.io/travis/liuxc123/BEEPopupKit.svg?style=flat)](https://travis-ci.org/liuxc123/BEEPopupKit)
[![Version](https://img.shields.io/cocoapods/v/BEEPopupKit.svg?style=flat)](https://cocoapods.org/pods/BEEPopupKit)
[![License](https://img.shields.io/cocoapods/l/BEEPopupKit.svg?style=flat)](https://cocoapods.org/pods/BEEPopupKit)
[![Platform](https://img.shields.io/cocoapods/p/BEEPopupKit.svg?style=flat)](https://cocoapods.org/pods/BEEPopupKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BEEPopupKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BEEPopupKit'
```

## Usage

### Quick Usage

```
// Customized view
let customView = SomeCustomView()
/*
Do some customization on customView
*/

// Attributes struct that describes the display, style, user interaction and animations of customView.
var attributes = BEEAttributes()
/*
Adjust preferable attributes
*/
```
And then, just call:
```
BEEPopupKit.display(entry: customView, using: attributes)
```

### Alert 

```
let alert = BEEAlertView(title: "我是主标题", message: "我是副标题", imageName: "info")
let action1 = BEEAlertAction(title: "确定", style: .default) { (action) in
    print("点击了确定")
}
let action2 = BEEAlertAction(title: "取消", style: .destructive) { (action) in
    print("点击了取消")
}
action2.titleColor = BEEColor(.red)
alert.addAction(action1)
alert.addAction(action2)
alert.show()
```

### ActionSheet 

```
let actionSheet = BEEActionSheetView(title: "我是主标题", message: "我是副标题", imageName: "zhiwen")

let action1 = BEEAlertAction(title: "Default", style: .default) { (action) in
    print("点击了Default")
}

let action2 = BEEAlertAction(title: "Destructive", style: .destructive) { (action) in
    print("点击了Default")
}

let action3 = BEEAlertAction(title: "Cancel", style: .cancel) { (action) in
    print("点击了Default")
}

actionSheet.addAction(action1)
actionSheet.addAction(action3) // 取消按钮一定排在最底部
actionSheet.addAction(action2)
actionSheet.show()
```


## Author

liuxc123, lxc_work@126.com

## License

BEEPopupKit is available under the MIT license. See the LICENSE file for more info.


