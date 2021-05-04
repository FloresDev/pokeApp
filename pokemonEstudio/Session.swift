

import Foundation

class Session: Codable {
    static let current = Session()
    private static let kArchiveKey = "ArchiveKey"
    
    var userName: String?
    
    private init(){
        if let data = UserDefaults.standard.object(forKey: Session.kArchiveKey) as? Data {
            if let savedSession = try? PropertyListDecoder().decode(Session.self, from: data){
                userName = savedSession.userName
            }
        }
    }
    
    static func save(){
        if let data = try? PropertyListEncoder().encode(current){
            UserDefaults.standard.set(data, forKey: kArchiveKey)
        }
    }
}
