

//Al ser un view controller y ponerle un table view hay que añadir UITableViewDelegate y UITableViewDataSource. Por otro lado en el storyBoard con boton derecho y arrastrando arriba hay que decirle que use su datasource y su delegate

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLabel: UILabel!
    @IBOutlet weak var statNumber: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    @IBOutlet weak var AbilityButton: UIButton!
    
    
    var pokemon: Pokemon?
    var pokemonImages: UIImage?
    var pokemonImages2: UIImage?
    var pokemonMoves = [Move?]()
    var pokemonAbility = [Ability?]()
    var pokemonStats = [Stat]()
    var pokemons = [Pokemon?]()
    var move = 0
    var ability = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let pokemon = pokemon{
            self.pokemonNameLabel.text = pokemon.name?.capitalized
            self.typeLabel.text = "Pokemon type: " + (pokemon.types?.first?.type!.name)!.capitalized
            self.pokemonLabel.text = pokemon.stats![move].stat?.name
            self.statNumber.text = pokemon.stats![move].base_stat.description
            self.AbilityButton.setTitle(pokemon.abilities![ability].ability.name, for: .normal)
            self.pokemonImage.image = pokemonImages2
            
            
        }
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonMoves.count
      
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalTableViewCell2", for: indexPath)
        
        pokemonMoves = pokemonMoves.sorted { ($0!.move?.name)! < ($1!.move?.name)! }
        // Configure the cell...
        let poke = pokemonMoves[indexPath.row]
       
               // cell.pokemonNameLabel.text = pokemon.moves[3].move?.name
        cell.textLabel?.text = poke!.move?.name?.capitalized
       
        return cell
    }
    
    @IBAction func nextMove(_ sender: Any) {
    
        if move == pokemonStats.count - 1{
            move = -1
        }
        move += 1
        self.pokemonLabel.text = pokemon!.stats![move].stat?.name
        self.statNumber.text = pokemon!.stats![move].base_stat.description
    }
    @IBAction func preMove(_ sender: Any) {
        
        if move == 0{
            move = pokemonStats.count
        }
        move -= 1
        self.pokemonLabel.text = pokemon!.stats![move].stat?.name
        self.statNumber.text = pokemon!.stats![move].base_stat.description
        
    }
    
    @IBAction func abilityNextButton(_ sender: Any) {
        
        if ability == (pokemon?.abilities?.count)! - 1{
            ability = -1
        }
        ability += 1
        self.AbilityButton.setTitle(pokemon!.abilities![ability].ability.name, for: .normal)
    }
    
    @IBAction func abilityPreButton(_ sender: Any) {
        
        if ability == 0{
            ability = (pokemon?.abilities?.count)!
        }
        ability -= 1
        self.AbilityButton.setTitle(pokemon!.abilities![ability].ability.name, for: .normal)
    }
    @IBAction func changeImageButton(_ sender: Any) {
        
        if  self.pokemonImage.image == pokemonImages2{
            self.pokemonImage.image = pokemonImages
            
        }else{
            self.pokemonImage.image = pokemonImages2
        }
        
    }
    
   
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "go", sender: indexPath)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "go"{
            if let detalle = segue.destination as?
                MoveViewController,
               let indexPath = sender as? IndexPath,
               let pokemon = pokemonMoves[indexPath.row]
            {
                
                detalle.name = (pokemon.move?.name)!
                
            }
            
        }
        
        let viewController = segue.destination
        
        if let next = viewController as? AbilityViewController{
            next.name = pokemon!.abilities![ability].ability.name!
        }
        
    }
}
        
       
        
        
        
        
        
    
    



