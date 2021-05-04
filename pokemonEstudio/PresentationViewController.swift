

import UIKit

class PresentationViewController: UIViewController {
    
    @IBOutlet weak var maxPokemonsField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var gifImage: UIImageView!
    
    var max : Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        //Se configura el ImageView con el gif descargado
        self.gifImage.loadGif(name: "Gif")
    }
    
    //Action del boton. al pulsarlo se haran las comprobaciones de que los datos esten correctos
    @IBAction func NV(_ sender: Any) {
        let MAX_POKEMONS: Int = Int(maxPokemonsField.text ?? "0") ?? 0
        
        max = MAX_POKEMONS
        
        if MAX_POKEMONS <= 0  {
            errorLabel.text = "El numero introducido tiene que ser mayor que 0"
            
        }else if MAX_POKEMONS > 150{
            errorLabel.text = "El numero introducido tiene tiene que ser menor que 150"
        
        }else{
            //si esta todo correcto hara el segue a la siguiente pantalla
            self.performSegue(withIdentifier: "go", sender: self)
        }
        
       
    }
    
    //prepare que se encarga de mandar los datos a la siguiente vista cuando se haga el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination
        
        if let nextVC = VC as? TableViewController{
            nextVC.MAX_POKEMONS = self.max!
           
        }
    }

}
