[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License][license-image]][license-url]

# AMConstraints

This framework is basically a wrapper around the anchor API that Apple introduced in iOS 9. It provides functions that are supposed to make dealing with constriants easier. This is still a work in progress though.


# Installation

## Carthage
1. Add the following to your Cartfile

        github "aboodmufti/AMConstraints"
        
2. Run `carthage update`
3. Add the framework to your project, as defined [here](https://github.com/Carthage/Carthage#if-youre-building-for-ios-tvos-or-watchos)

# Some usage examples:
For the next few examples, we'll use the following view:
```Swift
let newView = UIView()
view.addSubview(newView)
```

Constrain all sides:
```Swift
newView.constrain(sides: .all, to: view, constant: 5)
```

Constrain one or multiple sides:
```Swift
newView.constrain(sides: .top, to: view, constant: 5)
newView.constrain(sides: [.left, .right], to: view, constant: 5)
```

Constrain dimensions:
```Swift
newView.constrain(dimensions: .width, to: view, multiplier: 0.8)
```

# Contribute
Contributions to AMConstraints are more than welcome, check the `LICENSE` file for more info.


## Docs
Here you can [find the official library documentation](https://aboodmufti.github.io/AMConstraints/docs).

[license-image]: https://img.shields.io/hexpm/l/plug.svg
[license-url]: LICENSE
