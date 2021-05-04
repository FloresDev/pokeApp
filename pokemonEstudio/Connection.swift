

import UIKit

//Clase que se ocupa de la conexion con la API

class Connection{
    
    //Se crea una constante con la URL base
    let baseURLString = "https://pokeapi.co/api/v2/"
    
    //Funcion encargada de hacer la llamada para obtener los pokemons
    func getPokemon(withID id: Int, completion: @escaping(_ pokemon: Pokemon?)-> Void){
        //Se crea la conexion a traves de una cadena
        guard let url = URL(string: "\(baseURLString)pokemon/\(id)")else{
            //Si no se puede se devuelve un completion nil y se detiene la ejecucion
            completion(nil)
            return
        }
        
        //Una vez se tiene la url se crea un URLSession con esa url y con la configuracion por defecto
        let urlSession = URLSession(configuration: .default)
        
        //Se crea una taarea para descargar los datos con la URL que se ha creado antes
        //Este metodo devuelve un data, un response y un error
        let task = urlSession.dataTask(with: url){ data, response, error in
            
            //si no se produce error y ademas puede obtener datos
            if error == nil, let data = data{
                
                //Se crea el pokemon mediante el data
                let pokemon = Pokemon(withJSONData: data)
                
                //Mediante el completion se devuelve el pokemon
                completion(pokemon)
                
                //Si hay errores o no se han podido obtener los datos
            }else{
                //Se devuelve un nil mediante el completion
                completion(nil)
            }
        }
        //Una vez terminado se devuelve el resume del task
        task.resume()
    }
    
    //Funcion encargada de hacer la llamada para obtener los movimientos
    func getMove(withID name: String, completion: @escaping(_ pokeMove: PokeMove?)-> Void){
        
        //Se crea la conexion a traves de una cadena
        guard let url = URL(string: "\(baseURLString)move/\(name)")else{
            //Si no se puede se devuelve un completion nil y se detiene la ejecucion
            completion(nil)
            return
        }
        //Una vez se tiene la url se crea un URLSession con esa url y con la configuracion por defecto
        let urlSession = URLSession(configuration: .default)
        
        //Se crea una tarea para descargar los datos con la URL que se ha creado antes
        //Este metodo devuelve un data, un response y un error
        let task = urlSession.dataTask(with: url){ data, response, error in
            
            //si no se produce error y ademas puede obtener datos
            if error == nil, let data = data{
                //Se crea el movimineto mediante el data
                let pokeMove = PokeMove(withJSONData: data)
                //Mediante el completion se devuelve el movimiento
                completion(pokeMove)
                
                //Si hay errores o no se han podido obtener los datos
            }else{
                //Se devuelve un nil mediante el completion
                completion(nil)
            }
        }
        //Una vez terminado se devuelve el resume del task
        task.resume()
    }
    
    //Funcion encargada de hacer la llamada para obtener las habilidades
    func getAbility(withID name: String, completion: @escaping(_ pokeAbility: PokeAbility?)-> Void){
        
        //Se crea la conexion a traves de una cadena
        guard let url = URL(string: "\(baseURLString)ability/\(name)")else{
            //Si no se puede se devuelve un completion nil y se detiene la ejecucion
            completion(nil)
            return
        }
        //Una vez se tiene la url se crea un URLSession con esa url y con la configuracion por defecto
        let urlSession = URLSession(configuration: .default)
        //Se crea una tarea para descargar los datos con la URL que se ha creado antes
        //Este metodo devuelve un data, un response y un error
        let task = urlSession.dataTask(with: url){ data, response, error in
            //si no se produce error y ademas puede obtener datos
            if error == nil, let data = data{
                //Se crea la habilidad mediante el data
                let pokeAbility = PokeAbility(withJSONData: data)
                //Mediante el completion se devuelve la habilidad
                completion(pokeAbility)
                //Si hay errores o no se han podido obtener los datos
            }else{
                //Se devuelve un nil mediante el completion
                completion(nil)
            }
        }
        //Una vez terminado se devuelve el resume del task
        task.resume()
    }
    
    //Funcion encargada de hacer la llamada para obtener los sprites
    func getSprite(withURLString urlString:String, completion: @escaping(_ image: UIImage?) -> Void){
        //Se crea la conexion a traves de una cadena
        guard let url = URL(string: urlString)else{
            //Si no se puede se devuelve un completion nil y se detiene la ejecucion
            completion(nil)
            return
        }
        //Una vez se tiene la url se crea un URLSession con esa url y con la configuracion por defecto
        let urlSession = URLSession(configuration: .default)
        //Se crea una tarea para descargar los datos con la URL que se ha creado antes
        //Este metodo devuelve un data, un response y un error
        let task = urlSession.dataTask(with: url){ data, response, error in
            //si no se produce error y ademas puede obtener datos
            if error == nil, let data = data{
                //Se crea la habilidad mediante el data
                let image = UIImage(data: data)
                //Mediante el completion se devuelve la imagen
                completion(image)
                //Si hay errores o no se han podido obtener los datos
            }else{
                //Se devuelve un nil mediante el completion
                completion(nil)
            }
            
        }
        //Una vez terminado se devuelve el resume del task
        task.resume()
    }
}
