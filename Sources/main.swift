import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache
import PerfectLogger
import PerfectRequestLogger

struct TestHandler: MustachePageHandler {
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        var values = MustacheEvaluationContext.MapType()
        values["title"] = "swift user"
        
        contxt.extendValues(with: values)
        
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
    }
}


// 创建HTTP服务器
let server = HTTPServer()
// 注册您自己的路由和请求／响应句柄
var routes = Routes()
//routes.add(method: .get, uri: "/", handler: {
//        request, response in
//        response.setHeader(.contentType, value: "text/html")
//        response.appendBody(string: "<html><title>你好，世界！</title><body>你好，世界！</body></html>")
//        response.completed()
//    }
//)

routes.add(method: .get, uri: "/") { (request, response) in
    let webRoot = request.documentRoot
    mustacheRequest(request: request, response: response, handler: TestHandler(), templatePath: webRoot + "/index.html")
}

// 将路由注册到服务器上
server.addRoutes(routes)

// 监听8181端口
server.serverPort = 8181

server.documentRoot = "./webroot"
//
let logPath = "./files/log"
let dir = Dir(logPath)
if !dir.exists {
    try Dir(logPath).create()
}
LogFile.location = "\(logPath)/myLog.log"

server.setRequestFilters([(RequestLogger(), .high)])
server.setResponseFilters([(RequestLogger(), .low)])


LogFile.debug("debug")
LogFile.info("info")
LogFile.warning("warning")
LogFile.error("error")
LogFile.critical("critical")




do {
    // 启动HTTP服务器
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("网络出现错误：\(err) \(msg)")
}


