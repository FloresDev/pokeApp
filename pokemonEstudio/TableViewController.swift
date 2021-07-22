
import UIKit


class TableViewController: UITableViewController, UISearchBarDelegate,UISearchResultsUpdating {
    
    @IBOutlet weak var label: UILabel!
    
    var pokemons: [Pokemon?] = []
    var images: [UIImage?] = []
    //var images2: [UIImage?] = []
    var MAX_POKEMONS = 50
    var imagesDownload = 0
    var imagesDownload2 = 0
    var connection = Connection()
    var filteredData : [Pokemon?] = []
    let searchController = UISearchController()
    var pokemonsDownload = 0
    var notifications: Bool?
    //variable para el tiempo de comprobacion de la conexion
    var notiTime = 0.0
    
    //variables para el indicador de carga
    var activityIndicator = UIActivityIndicatorView()
    var container = UIView()
    var loadingView = UIView()
    var loadingLabel = UILabel()
    
    //variable reachability para la comprobacion de conexion a internet
    var reachability: Reachability?
    let hostNames = [nil, "google.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startHost(at: 0) //Se inicia star host a 0 para la comprobacion de la conexion
       
        self.setupLoadingViews()//se hace la llamada a la funcion de carga
        
        
        //se iguala filtered data a pokemons para que tengan el mismo valor al iniciar la vista. filtered data sera la variable usada a partir de ahora para la vista, de esta manera se actualiza la tabla al hacer la busqueda en la barra
        filteredData = pokemons
        setupSearch()
        
        //se hace la descarga de datos desde la API, en este caso los pokemons y la imagenes
        pokemons = [Pokemon?] (repeating: nil, count: MAX_POKEMONS)
        filteredData = [Pokemon?] (repeating: nil, count: MAX_POKEMONS)
        images = [UIImage?] (repeating: nil, count: MAX_POKEMONS)
       // images2 = [UIImage?] (repeating: nil, count: MAX_POKEMONS)
        
        for i in 1...MAX_POKEMONS{
            connection.getPokemon(withID: i) { pokemon in
                self.pokemonsDownload += 1
                if let pokemon = pokemon, let id = pokemon.id{
                    self.pokemons[id-1] = pokemon
                   
                    self.filteredData = self.pokemons
                    
                    if let image = pokemon.sprites?.other?.officialArt?.front_default{
                        self.connection.getSprite(withURLString: image) { image in
                            self.imagesDownload += 1
                            print("image1: \(self.imagesDownload.description)")
                            if let image = image{
                                pokemon.image = image
                            }
                            
                            if let image2 = pokemon.sprites?.frontDefault{
                                self.connection.getSprite(withURLString: image2) { image2 in
                                    self.imagesDownload2 += 1
                                    
                                    if let image2 = image2{
                                        pokemon.imageTras = image2
                                    }
                                    if self.imagesDownload == self.MAX_POKEMONS {
    
                                        DispatchQueue.main.async{
                                           
                                            self.filteredData = self.filteredData.sorted { ($0!.name!) < ($1!.name!) }
                                            self.tableView.reloadData()
                                            
                                            self.pokemons = self.pokemons.sorted { ($0!.name!) < ($1!.name!) }
                                            self.tableView.reloadData()
                                            
                                           
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Configuracion de la barra de busqueda
    func setupSearch(){
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
        let searchBar = searchController.searchBar
        searchBar.delegate = self
        searchBar.placeholder = "Introduce ubicación"
    }
 
 
   
    //funcion para actualizar los datos cuando se haga la busqueda en la barra de busqueda
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text != "" {
            filteredData = pokemons.filter({ pokemon -> Bool in
                guard let text = searchController.searchBar.text else { return false }
                return pokemon!.name!.lowercased().contains(text.lowercased())
            }).sorted { $0!.name! < $1!.name! }
        }else{
            filteredData = pokemons
        }
        tableView.reloadData()
        
    }
    
    
    
    //el numero de secciones en la tabla sera 1 por cada resultado
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    //Los datos que aparecen en la celda seran los de filteredData
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       // return filteredData.count
        return filteredData.count
    }

    //Se configura la celda con los dattos
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalTableViewCell", for: indexPath) as! PersonalTableViewCell

        // Configure the cell...
       // if let pokemon = filteredData[indexPath.row]{
        if let pokemon = filteredData[indexPath.row]{
               // cell.pokemonNameLabel.text = pokemon.moves[3].move?.name
            cell.pokemonNameLabel.text = pokemon.name!.capitalized
            cell.pokemonImage.image = pokemon.image
            cell.container.layer.cornerRadius = cell.container.frame.height / 2
           
        }
        
        
        //si el contador de imagenes descargadas no es igual al maximo de pokemons la celda no se muestra y se mostrara el indicador de cargando
        if imagesDownload != MAX_POKEMONS {
            showLoading()//se muestra la carga de la pagina
            cell.isHidden = true
            //sino, se ocultara el indicador de cargando y se muestra las celdas con los resultados
        }else{
        cell.isHidden = false
            hideLoading()//Se oculta la carga de la pagina
        }
        return cell
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    
    //Envio de datos a otra vista mediante el segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailSegue" {
        let nextViewController: ViewController = segue.destination as! ViewController
        
        //Variable que recoge el index de la celda que se pulsa en la tabla
        let indexPath = self.tableView.indexPathForSelectedRow
        let pokemon = filteredData[indexPath!.row]
        
        //Se igualan las varables de la siguiente vista a las que estan en esta, de esta manera se pasa el dato que queramos
        nextViewController.pokemon = pokemon
        nextViewController.pokemonImages = pokemon?.imageTras
        nextViewController.pokemonImages2 = pokemon?.image
        nextViewController.pokemonMoves = pokemon!.moves!
        nextViewController.pokemonStats = pokemon!.stats!
        
     }
    }
    
    //configuracion del activity indicator
    func setupLoadingViews(){
        self.container.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y + 140, width: self.view.frame.width, height: self.view.frame.height - 140)
        self.container.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.3)
        
        //Loading View
        self.loadingView.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
        self.loadingView.center = self.view.center
        self.loadingView.backgroundColor = #colorLiteral(red: 1, green: 0.8227627873, blue: 0.1279867589, alpha: 1)
        self.loadingView.clipsToBounds = true
        self.loadingView.layer.cornerRadius = 10
        
        //Activity Indicator View
        self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.activityIndicator.style = .large
        self.activityIndicator.center = self.view.center
        self.activityIndicator.color = #colorLiteral(red: 0.2250583768, green: 0.3118225634, blue: 0.387561202, alpha: 1)
        self.activityIndicator.startAnimating()
        
        //Label
        self.loadingLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        let center = self.activityIndicator.center
        self.loadingLabel.center = CGPoint(x: center.x, y: center.y + 40)
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.textColor = #colorLiteral(red: 0.2250583768, green: 0.3118225634, blue: 0.387561202, alpha: 1)
    }
    
    //Funcion para mostrar la vista de loading
    func showLoading(){
        self.view.addSubview(self.container)
        self.view.addSubview(self.loadingView)
        self.view.addSubview(self.activityIndicator)
        self.view.addSubview(self.loadingLabel)
    }
    
    //funcion para esconder la vista de loading
    func hideLoading(){
        self.loadingLabel.removeFromSuperview()
        self.activityIndicator.removeFromSuperview()
        self.loadingView.removeFromSuperview()
        self.container.removeFromSuperview()
    }
    
    
    //CONFIGURACION DEL REACHABILITY PARA COMPROBAR LA CONEXION A INTERNET DEL DISPOSITIVO
    func startHost(at index: Int){
        reachability?.stopNotifier()
        setupReachability(hostNames[index])
        try? reachability?.startNotifier()
        DispatchQueue.main.asyncAfter(deadline: .now() + notiTime) {
            self.startHost(at: (index+1)%2)
        }
    }
    
    func setupReachability(_ hostName: String?){
        if let hostName = hostName{
            reachability = try? Reachability(hostname: hostName)
        }else{
            reachability = try? Reachability()
        }
        
        reachability?.whenReachable = {
            reachability in
            self.notiTime = 0.0
           
        }
        reachability?.whenUnreachable = {
            reachability in
            self.label.text = "No connection!!"
            self.label.textColor = .red
            self.mostrarAlert(title: "Conexión perdida", message: "Has perdido la conexión a internet")
            self.notiTime += 20.0
            print(self.notiTime)
        }
    }
    
    // Función para mostrar alert en la app
    func mostrarAlert(title: String, message: String) {
        
        // Creamos la alerta
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        // Botones del alert para ejecutar acciones tras su pulsación
        let ok = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
    }
    


