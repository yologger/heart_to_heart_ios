import ObjectMapper

struct LogInSuccessResponseData: Mappable {
    
    var userId: Int?
    var email: String?
    var nickname: String?
    var url: String?
    var accessToken: String?
    var refreshToken: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userId          <- map["user_id"]
        email           <- map["email"]
        nickname        <- map["nickname"]
        url             <- map["url"]
        accessToken     <- map["access_token"]
        refreshToken    <- map["refresh_token"]
    }
}
