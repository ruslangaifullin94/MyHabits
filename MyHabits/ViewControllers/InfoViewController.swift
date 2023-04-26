//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 16.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private var data = HabitsStore.shared.habits
    
    private lazy var infoScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        scrollView.isHidden = false
        scrollView.isScrollEnabled = true
//        scrollView.backgroundColor = .cyan
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var infoLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Привычка за 21 день"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
//        textView.backgroundColor = .black
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text =
        """
        
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

        1. Провести 1 день без обращения
        к старым привычкам, стараться вести себя так, как будто цель, загаданная
        в перспективу, находится на расстоянии шага.

        2. Выдержать 2 дня в прежнем состоянии самоконтроля.

        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
        с чем еще предстоит серьезно бороться.

        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

        
        """
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 17)
        return textView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraits()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "tabBarBackgroundColor")
        view.addSubview(infoScrollView)
        self.infoScrollView.addSubview(infoLabel)
        
        self.infoScrollView.addSubview(infoTextView)
     

    }

    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            infoScrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            infoScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            infoScrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            infoLabel.topAnchor.constraint(equalTo: infoScrollView.topAnchor, constant: 22),
            infoLabel.leftAnchor.constraint(equalTo: infoScrollView.leftAnchor, constant: 16),
            infoLabel.rightAnchor.constraint(equalTo: infoScrollView.rightAnchor, constant: -141),
            
            infoTextView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 0),
            infoTextView.leftAnchor.constraint(equalTo: infoScrollView.leftAnchor, constant: 16),
//            infoTextView.rightAnchor.constraint(equalTo: infoScrollView.rightAnchor, constant: -32),
            infoTextView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor, constant: 0),
            infoTextView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16),
            
        ])
    }
    
   
}
