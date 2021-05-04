

import Foundation

//Clase encargada de los datos de Movimientos
//Implementa el metodo Mappable
class PokeMove: Mappable {
    //campos de la clase
    var id: Int?
    var name: String?
    var damage_class: DamageClass?
    var flavor_text_entries: [Flavor_text]
}
