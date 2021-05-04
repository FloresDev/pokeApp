

import Foundation
import UIKit

//Clase encargada de los datos de Pokemon
//Implementa el metodo Mappable
class Pokemon: Mappable {
    
    //Campos de la clase
    var id: Int?
    var name: String?
    var sprites: Sprite?//la variable sprite se encarga de recibir los sprites pero vienen en url
    var types: [Type]?
    var moves: [Move]?
    var stats: [Stat]?
    var image: UIImage? //se crea la variable image para que se pueda llamar a la imagen desde la clase
    var imageTras: UIImage?
    var abilities: [Ability]?
    
 
    //enum co el que se maneja el formato de texto del campo de la clase para que coincida con los que se reciban de la API.
    //este formato es obligatorio si se quiere usar el UIKit pero la variable con UIImage no se pone en los casos
    private enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case sprites
        case types
        case moves
        case stats
        case abilities
       
    }
}

