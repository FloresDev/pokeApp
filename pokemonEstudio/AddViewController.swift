
import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var pokemonNameField: UITextField!
    
    

    var pokemon: Pokemon?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "save"{
            savePokemon()
        }
    }
    
    func savePokemon(){
        if let pokemonName = self.pokemonNameField.text,
           !pokemonName.isEmpty{
            let newPokemon = Pokemon()
            newPokemon.name = pokemonName
            let newImage = UIImage(imageLiteralResourceName: "poke_icon")
            self.pokemon = newPokemon
            self.image = newImage
        }
    }
    

   

}
