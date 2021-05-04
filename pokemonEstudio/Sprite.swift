

import Foundation


class Sprite: Mappable {
    var frontDefault: String?
    var backDefault: String?
    var other: Other?
    
    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case other
    }
}
