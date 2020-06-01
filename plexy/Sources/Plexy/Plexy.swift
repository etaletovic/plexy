public struct Plexy {

    public static var port: Int = 32400
    public static var baseUrl: String = "http://127.0.0.1"
    public static var productId: String = "plexy"
    public static var clientIdentifier: String = "plexy"

    private init() {}
}

extension Plexy {

    public struct Auth {
        public static var token: String = ""
        public static var username: String = ""
        public static var password: String = ""

        private init() {}
    }
}

extension Plexy {

    public static func configure(baseUrl: String, port: Int) {
        Plexy.port = port
        Plexy.baseUrl = baseUrl
    }
}
