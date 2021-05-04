
import Foundation

//Clase Mappable que se encargara de recibir y formatear el JSON

protocol Mappable: Codable {
    init?(withJSONData: Data?)
}

extension Mappable{
    init?(withJSONData: Data?){
        guard let data = withJSONData else {return nil}
        do{
            self = try JSONDecoder().decode(Self.self, from: data)
        }catch{
            return nil
        }
    }
}
