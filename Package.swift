import PackageDescription

let package = Package(
    name: "SwiftyJIRA",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/hathway/JSONRequest.git", majorVersion: 0),
    ]
)
