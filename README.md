# MultipleImageView

Displaying multiple images like Twitter.

## Installation

### CocoaPods

```ruby
pod 'MultipleImageView'
```

### Carthage

```
github "nnsnodnb/MultipleImageView"
```

### Swift Package Manager

```swift
// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "SampleApp",
    dependencies: [
        .package(name: "MultipleImageView",
                 url: "https://github.com/nnsnodnb/MultipleImageView.git",
                 from: "0.1.0")
    ],
    .targets: [
        .target(name: "SampleApp,
                dependencies: ["MultipleImageView"])
    ]
)
```

## Example

Please see Example project.

## License

[MultipleImageView](https://github.com/nnsnodnb/MultipleImageView) is released under the MIT license. See [LICENSE](https://github.com/nnsnodnb/MultipleImageView/blob/main/LICENSE) for details.
