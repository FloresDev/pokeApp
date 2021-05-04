

import UIKit

class MoveViewController: UIViewController {
    
    @IBOutlet weak var pokeMoveLabel: UILabel!
    @IBOutlet weak var damageClassLabel: UILabel!
    @IBOutlet weak var defAtackLabel: UILabel!
    
    var connection = Connection()
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
            connection.getMove(withID: name) { pokeMove in
                if let pokeMove = pokeMove{
                    print(pokeMove.name)
                    
                    DispatchQueue.main.async{
                        self.pokeMoveLabel.text = pokeMove.name?.capitalized
                        self.damageClassLabel.text = " Tipo de ataque: " + (pokeMove.damage_class?.name)!
                        self.defAtackLabel.text = pokeMove.flavor_text_entries[15].flavor_text
                    }
                    
                    
            }
            
                print(pokeMove!.name)
                print(pokeMove!.damage_class?.name)
                print(pokeMove!.flavor_text_entries[15].flavor_text)
        }
        
        
       
        
       

        // Do any additional setup after loading the view.
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
