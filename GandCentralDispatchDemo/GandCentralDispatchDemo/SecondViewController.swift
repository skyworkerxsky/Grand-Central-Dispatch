//
//  SecondViewController.swift
//  GandCentralDispatchDemo
//
//  Created by Алексей on 21/10/2019.
//  Copyright © 2019 Alexey Makarov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        get { // получение значения
            return imageView.image
        }
        
        set { // установка нового значения
            imageView.image = newValue
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchImage()
        delay(3) {
            self.showAlert(title: "Зарегистрированы", message: "Введите ваш логин и пароль")
        }
        
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> ()){
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay )){
            closure()
        }
    }
    
    fileprivate func fetchImage() {
        
        let widthView: Int? = Int(self.view.frame.size.width)
        let heightView: Int? = Int(self.view.frame.size.height)
        
        imageURL = URL(string: "https://picsum.photos/\(widthView!)/\(heightView!)") // Адрес изображения
        print(imageURL)
        activityIndicator.startAnimating() // Запускаем индикатор
        activityIndicator.isHidden = false // Делаем индикатор видимым
        
        // Поместили загрузку картинки в другой поток чтобы не тормозить взаимодействие с интерфейсом
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else  { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
        
    }
    
    fileprivate func showAlert(title: String, message: String) {
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cansel = UIAlertAction(title: "Cansel", style: .cancel, handler: nil)
        
        alertControler.addAction(ok)
        alertControler.addAction(cansel)
        
        alertControler.addTextField { (usernameTF) in
            usernameTF.placeholder = "Введите логин"
        }
        
        alertControler.addTextField { (userPasswordTF) in
            userPasswordTF.placeholder = "Введите пароль"
            userPasswordTF.isSecureTextEntry = true
        }
        
        self.present(alertControler, animated: true)
    }
    
}
