

import UIKit

class AbilityViewController: UIViewController {
    
    @IBOutlet weak var abilityNameLabel: UILabel!
    @IBOutlet weak var abilityDescriLabel: UILabel!
    
    var connection = Connection()
    var pokeAbilities: [PokeAbility?] = []
    var poke : PokeMove?
    var name = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.name)
        connection.getAbility(withID: name) { pokeAbilities in
            if let pokeAb = pokeAbilities{
                print(pokeAb.name)
                
                DispatchQueue.main.async{
                    self.abilityNameLabel.text = pokeAb.name
                    self.abilityDescriLabel.text = pokeAbilities?.flavor_text_entries[0].flavor_text
                    
                    print(pokeAb.name)
                    print(pokeAbilities?.flavor_text_entries[13].flavor_text)
                }
                
                print(self.name)
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
    }}
