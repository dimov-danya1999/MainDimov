//
//  ViewController.swift
//  MainProject
//
//  Created by Даниил Димов on 04.11.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    private var userModel = UserModel()
    private var helloTextModel = HelloModel()
    
    private let helloLabel = UILabel()
    private let resultLabel = UILabel()
    private let randomLabel = UILabel()
    private let nameLabel = UILabel()
    private let familyLabel = UILabel()
    private let fatherLabel = UILabel()
    
    private let addSumButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .randomButton)
        button.updateState(isActive: true)
        return button
    }()
    
    private let guessNumberButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .sumButton)
        button.updateState(isActive: true)
        return button
    }()
    
    private let toBeginButton: CustomButton = {
        let button = CustomButton()
        button.configure(type: .helloButton)
        button.updateState(isActive: true)
        button.addTarget(MainViewController.self, action: #selector(validityHello), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackLabel = UIStackView(view: [nameLabel, familyLabel, fatherLabel], axis: .vertical, spacing: 7)
    
    private lazy var stackButton = UIStackView(view: [addSumButton, guessNumberButton], axis: .horizontal, spacing: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [helloLabel, resultLabel, randomLabel, nameLabel, familyLabel, fatherLabel, stackLabel, addSumButton, stackButton, guessNumberButton, toBeginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        alertWithTF()
        setupElement()
    }

    @objc private func validityHello() {
        let alert = UIAlertController(title: "Верни hello", message: "Введи leohl", preferredStyle: .alert)
        let action = UIAlertAction(title: "Вернуть", style: .default) { [weak self] action in
            self?.helloLabel.text = self?.helloTextModel.textHello(alert.textFields?.first?.text ?? "")
           
        }
        alert.addTextField{ textField in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc private func randomGame() {
        let rollIt = String(arc4random_uniform(3))
        
        let alert = UIAlertController(title: "Cыграй в игру - угадай число", message: "Введи число", preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть", style: .default) { action in
            let number = alert.textFields?[0]
            number?.text == rollIt ? "угадал" : "не угадал "
        }
        alert.addTextField{ (textField: UITextField) in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    @objc private func alertguessNumberButton() {
        let alert = UIAlertController(title: "Cыграй в игру", message: "Введи два числа", preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть", style: .default) { [weak self] action in
            let firstNumber = alert.textFields?[0]
            let twoNumber = alert.textFields?[1]
            self.resultLabel.text = String(Int(firstNumber.text) + (Int(twoNumber?.text)))
        }
        alert.addTextField{ textField in
            textField.keyboardType = .default
        }
        alert.addTextField{ textField in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func setupElement() {

        view.addSubview(stackLabel)
        stackLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(stackButton)
        view.addSubview(resultLabel)
        view.addSubview(randomLabel)
        view.addSubview(toBeginButton)
        view.addSubview(helloLabel)
        
        NSLayoutConstraint.activate([
            stackButton.topAnchor.constraint(equalTo: stackLabel.bottomAnchor, constant: 35),
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackButton.widthAnchor.constraint(equalToConstant: 300),
            stackButton.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.topAnchor.constraint(equalTo: stackButton.bottomAnchor, constant: 15),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            resultLabel.widthAnchor.constraint(equalToConstant: 300),
            resultLabel.heightAnchor.constraint(equalToConstant: 50),
            
            randomLabel.topAnchor.constraint(equalTo: stackButton.bottomAnchor, constant: 15),
            randomLabel.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 250),
            randomLabel.widthAnchor.constraint(equalToConstant: 300),
            randomLabel.heightAnchor.constraint(equalToConstant: 50),
            
            toBeginButton.bottomAnchor.constraint(equalTo: stackLabel.topAnchor, constant: -120),
            toBeginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toBeginButton.widthAnchor.constraint(equalToConstant: 300),
            toBeginButton.heightAnchor.constraint(equalToConstant: 50),
            
            helloLabel.bottomAnchor.constraint(equalTo: toBeginButton.topAnchor, constant: -50),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.widthAnchor.constraint(equalToConstant: 300),
            helloLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension  MainViewController {
    
    func alertWithTF() {
        let alert = UIAlertController(title: "Привет, Гость!", message: "Пожалуйста, введи свое ФИО", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ввести", style: .default, handler: { [weak self] action in
            guard let family = alert.textFields?[0] else { return }
            guard let name = alert.textFields?[1] else { return }
            guard let father = alert.textFields?[2] else { return}
            
            self?.userModel.family = family.text
            self?.userModel.name = name.text
            self?.userModel.father = father.text
        
            self?.familyLabel.text = self?.userModel.family
            self?.nameLabel.text = self?.userModel.name
            self?.fatherLabel.text = self?.userModel.father
           
        })
        
        let cancel = UIAlertAction(title: "Выйти", style: .destructive, handler: { action in })
    
        alert.addTextField { textField in
            textField.placeholder = "Введи свою фамилию"
            textField.keyboardType = .default
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Введи свое имя "
            textField.keyboardType = .default
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Введи свое отчество"
            textField.keyboardType = .default
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

