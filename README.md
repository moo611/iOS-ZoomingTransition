# ZoomingTransition

[![CI Status](https://img.shields.io/travis/lnpjjds@gmail.com/ZoomingTransition.svg?style=flat)](https://travis-ci.org/lnpjjds@gmail.com/ZoomingTransition)
[![Version](https://img.shields.io/cocoapods/v/ZoomingTransition.svg?style=flat)](https://cocoapods.org/pods/ZoomingTransition)
[![License](https://img.shields.io/cocoapods/l/ZoomingTransition.svg?style=flat)](https://cocoapods.org/pods/ZoomingTransition)
[![Platform](https://img.shields.io/cocoapods/p/ZoomingTransition.svg?style=flat)](https://cocoapods.org/pods/ZoomingTransition)

## Example

![example](https://github.com/moo611/iOS-ZoomingTransition/blob/main/example.gif "example")

## Requirements
ios 10.0  , swift 5.0
## How to use

#### 1. Pod install
```ruby
pod 'ZoomingTransition'
```
#### 2. To make your  viewcontroller as a "PushVC", just extends ZoomPushVC ,and implement ZoomTransitionAnimatorDelegate
```swift

class MyPushVC : ZoomPushVC,ZoomTransitionAnimatorDelegate{

var lastSelectedIndexPath: IndexPath? = nil

//your own code...


func transitionWillStart() {
    guard let lastSelected = self.lastSelectedIndexPath else { return }
    self.collectionView.cellForItem(at: lastSelected)?.isHidden = true
}

func transitionDidEnd() {
    guard let lastSelected = self.lastSelectedIndexPath else { return }
    self.collectionView.cellForItem(at: lastSelected)?.isHidden = false
}

func referenceImage() -> UIImage? {
    guard
        let lastSelected = self.lastSelectedIndexPath,
        let cell = self.collectionView.cellForItem(at: lastSelected) as? CustomCell
    else {
        return nil
    }

    return cell.imageView.image
}

func imageFrame() -> CGRect? {
    guard
        let lastSelected = self.lastSelectedIndexPath,
        let cell = self.collectionView.cellForItem(at: lastSelected) as? CustomCell
    
    else {
        return nil
    }
    
    return FrameHelper.getTargerFrame(originalView: cell.imageView, targetView: self.view)



}
     
}

```
#### 3. Record the lastSelectedIndexPath when click the item of collectionview

```swift

class MyPushVC : ZoomPushVC,ZoomTransitionAnimatorDelegate{

//with the code above ...

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    self.lastSelectedIndexPath = indexPath
    let vc = PreviewVC()
    vc.image = self.slices[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
    
}

}

```
#### 4. To make your viewcontroller as a "PopVC",  just implement ZoomTransitionAnimatorDelegate

```swift
class PreviewVC: UIViewController,ZoomTransitionAnimatorDelegate{


func transitionWillStart() {
   // self.imageView.isHidden = true
    self.view.alpha = 0
}

func transitionDidEnd() {
  //  self.imageView.isHidden = true
    self.view.alpha = 1
}

func referenceImage() -> UIImage? {
    return FrameHelper.getScreenshot(with: self.view)
}

func imageFrame() -> CGRect? {
   
    return self.view.frame
}
}

```

That's it !  Then you will see the fantastic zooming transition :)
## Author

Desong


## License

ZoomingTransition is available under the MIT license. See the LICENSE file for more info.
