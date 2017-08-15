FourTinyFancyBallsLoadingIndicator ![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)
========================
A Loading Indicator Inspired by [Pelly Benassi](https://dribbble.com/shots/3712012--SVG-Loading-Icon-FTFB-Four-Tiny-Fancy-Balls)

## 动画效果
![Screenshot](https://github.com/lukapool/FourTinyFancyBallsLoadingIndicator/blob/master/ScreenShot.gif "Example of FourTinyFancyBallsLoadingIndicatorView")

##  安装
复制 LKAFTFBLoadingIndicatorView.h / LKAFTFBLoadingIndicatorView.m 到你的工程
导入头文件
```
#import "LKAFTFBLoadingIndicatorView.h"
```


## 如何使用 LKAFTFBLoadingIndicatorView

手动创建与添加 `LKAFTFBLoadingIndicatorView` 类或者通过 Storyboard 设置 UIView 的 custom class 为 `LKAFTFBLoadingIndicatorView`


使用 `startAnimating` 方法`开启`或`关闭` Loading 动画，开始前/关闭后均隐藏该指示器

```
[self.loadingIndicatorView startAnimating];

```

调用 `stopAnimating` 方法`关闭` Loading 动画.

```
[self.loadingIndicatorView stopAnimating];

```

## Credits

Inspired by [Pelly Benassi](https://dribbble.com/shots/3712012--SVG-Loading-Icon-FTFB-Four-Tiny-Fancy-Balls).

## License

MIT license.
