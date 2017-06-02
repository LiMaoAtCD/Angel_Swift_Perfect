import PackageDescription

let package = Package(
    name: "Angel_Swift_Perfect",
    dependencies: [
        .Package(
            url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git",
            majorVersion: 2, minor: 0
        ),
        .Package(
                url: "https://github.com/PerfectlySoft/Perfect-Mustache.git",
                majorVersion: 2, minor: 0
        ),
        .Package(url: "https://github.com/dabfleming/Perfect-RequestLogger.git",
                     majorVersion: 0),
        
        .Package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git",
                 majorVersion: 0, minor: 0)
        
        
    ]
)
