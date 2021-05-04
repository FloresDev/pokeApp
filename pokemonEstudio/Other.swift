

import Foundation

class Other: Mappable {
    var officialArt: OfficialArt?
    
    private enum CodingKeys: String, CodingKey {
        case officialArt = "official-artwork"
       
    }
}
