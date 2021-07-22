

import UIKit

class PresentationViewController: UIViewController {
    
    @IBOutlet weak var gifImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Se configura el ImageView con el gif descargado
        self.gifImage.loadGif(name: "Gif")
    }

}
