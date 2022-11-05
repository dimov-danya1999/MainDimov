//
//  ViewController.swift
//  MainProject
//
//  Created by Даниил Димов on 04.11.2022.
//


import UIKit

final class MainViewController: UIViewController {
    
    private var model = FIOModel()
    private var helloTextModel = HelloModel()
    
    private lazy var helloLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var randomLabel: UILabel = {
        let randomLabel = UILabel()
        randomLabel.translatesAutoresizingMaskIntoConstraints = false
        return randomLabel
    }()
    
    private lazy var nameLabel: UILabel = {
        let familyLabel = UILabel()
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        return familyLabel
    }()
    
    private lazy var familyLabel: UILabel = {
        let familyLabel = UILabel()
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        return familyLabel
    }()
    
    private lazy var fatherLabel: UILabel = {
        let familyLabel = UILabel()
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        return familyLabel
    }()
    
    private lazy var addSumButton: UIButton = {
        let addSumButton = UIButton(type: .system)
        addSumButton.backgroundColor = .blue
        addSumButton.setTitle("Угадай число", for: .normal)
        addSumButton.setTitleColor(.white, for: .normal)
        addSumButton.layer.cornerRadius = 7
        addSumButton.addTarget(self, action: #selector(randomGame), for: .touchUpInside)
        addSumButton.translatesAutoresizingMaskIntoConstraints = false
        return addSumButton
    }()
    
    private lazy var guessNumberButton: UIButton = {
        let guessNumberButton = UIButton(type: .system)
        guessNumberButton.backgroundColor = .blue
        guessNumberButton.setTitle("Сложение", for: .normal)
        guessNumberButton.setTitleColor(.white, for: .normal)
        guessNumberButton.layer.cornerRadius = 7
        guessNumberButton.addTarget(self, action: #selector(alertguessNumberButton), for: .touchUpInside)
        guessNumberButton.translatesAutoresizingMaskIntoConstraints = false
        return guessNumberButton
    }()
    
    private lazy var toBeginButton: UIButton = {
        let toBeginButton = UIButton(type: .system)
        toBeginButton.backgroundColor = .blue
        toBeginButton.setTitle("Начать", for: .normal)
        toBeginButton.setTitleColor(.white, for: .normal)
        toBeginButton.layer.cornerRadius = 7
        toBeginButton.addTarget(self, action: #selector(validityHello), for: .touchUpInside)
        toBeginButton.translatesAutoresizingMaskIntoConstraints = false
        return toBeginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        alertWithTF()
        setupLayout()
    }

    @objc func validityHello() {
        let alert = UIAlertController(title: "Верни hello", message: "Введи leohl", preferredStyle: .alert)
        let action = UIAlertAction(title: "Вернуть", style: .default) { (action ) in
            self.helloLabel.text = self.helloTextModel.textHello(alert.textFields?.first?.text ?? "")
           
        }
        alert.addTextField{ (textField: UITextField) in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc func randomGame() {
        let rollIt = String(arc4random_uniform(3))
        
        let alert = UIAlertController(title: "Cыграй в игру - угадай число", message: "Введи число", preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть", style: .default) { (action ) in
            let number = alert.textFields?[0]
            
            if number?.text == rollIt {
                self.randomLabel.text = "угадал"
            } else {
                self.randomLabel.text = "неугадал"
            }
            
        }
        alert.addTextField{ (textField: UITextField) in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    @objc func alertguessNumberButton() {
        let alert = UIAlertController(title: "Cыграй в игру", message: "Введи два числа", preferredStyle: .alert)
        let action = UIAlertAction(title: "Сыграть", style: .default) { (action ) in
            let firstNumber = alert.textFields?[0]
            let twoNumber = alert.textFields?[1]
            self.resultLabel.text = " Сумма введеных чисел = \(String(Int(firstNumber?.text ?? "0")! + Int(twoNumber?.text ?? "0")!))"
        }
        alert.addTextField{ (textField: UITextField) in
            textField.keyboardType = .default
        }
        alert.addTextField{ (textField: UITextField) in
            textField.keyboardType = .default
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    private func setupLayout() {
        
        //MARK: - Настройка с кнопками лейблами
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 7
        stackview.translatesAutoresizingMaskIntoConstraints = false
        
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(familyLabel)
        stackview.addArrangedSubview(fatherLabel)
        
        self.view.addSubview(stackview)
        stackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //MARK: - Настройки стэка с кнопками
        let stackviewButton = UIStackView()
        stackviewButton.axis = .horizontal
        stackviewButton.distribution = .fillProportionally
        stackviewButton.spacing = 50
        stackviewButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackviewButton.addArrangedSubview(addSumButton)
        stackviewButton.addArrangedSubview(guessNumberButton)
        
        self.view.addSubview(stackviewButton)
        NSLayoutConstraint.activate([
            stackviewButton.topAnchor.constraint(equalTo: stackview.bottomAnchor, constant: 35),
            stackviewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackviewButton.widthAnchor.constraint(equalToConstant: 300),
            stackviewButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //MARK: - Настройка результата лейбла
        self.view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: stackviewButton.bottomAnchor, constant: 15),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            resultLabel.widthAnchor.constraint(equalToConstant: 300),
            resultLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //MARK: - Настройка рандомного лейбла
        self.view.addSubview(randomLabel)
        NSLayoutConstraint.activate([
            randomLabel.topAnchor.constraint(equalTo: stackviewButton.bottomAnchor, constant: 15),
            randomLabel.leadingAnchor.constraint(equalTo: resultLabel.leadingAnchor, constant: 250),
            randomLabel.widthAnchor.constraint(equalToConstant: 300),
            randomLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        //MARK: - Настройка кнопки начать
        self.view.addSubview(toBeginButton)
        NSLayoutConstraint.activate([
            toBeginButton.bottomAnchor.constraint(equalTo: stackview.topAnchor, constant: -120),
            toBeginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toBeginButton.widthAnchor.constraint(equalToConstant: 300),
            toBeginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //MARK: - Настройка кнопки hellotext
        self.view.addSubview(helloLabel)
        NSLayoutConstraint.activate([
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
        let action = UIAlertAction(title: "Ввести", style: .default, handler: { (action) -> Void in
            let family = alert.textFields![0]
            let name = alert.textFields![1]
            let father = alert.textFields![2]
            
            self.model.family = family.text
            self.model.name = name.text
            self.model.father = father.text
        
            self.familyLabel.text = self.model.family
            self.nameLabel.text = self.model.name
            self.fatherLabel.text = self.model.father
           
        })
        
        let cancel = UIAlertAction(title: "Выйти", style: .destructive, handler: { (action) -> Void in })
    
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введи свою фамилию"
            textField.keyboardType = .default
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введи свое имя "
            textField.keyboardType = .default
        }
        
        alert.addTextField { (textField: UITextField) in
            textField.placeholder = "Введи свое отчество"
            textField.keyboardType = .default
        }
        
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

