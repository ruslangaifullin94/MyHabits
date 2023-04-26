//
//  HabitsViewCell.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 17.04.2023.
//

import UIKit

final class HabitViewCell: UICollectionViewCell {
    
    var habit: Habit?
    weak var delegate: HabitsViewControllerDelegate?

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var statusHabit: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupConstraits()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionCell(with habit: Habit) {
        self.habit = habit
        nameLabel.text = habit.name
        nameLabel.textColor = habit.color
        nameLabel.tintColor = habit.color
        timeLabel.text = habit.dateString
        statusHabit.tintColor = habit.color
        countLabel.text = "Cчетчик: " + String(habit.trackDates.count)
        if habit.isAlreadyTakenToday == true {
            statusHabit.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        } else {
            statusHabit.setImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    
    
    @objc private func didTapButton() {
        if habit?.isAlreadyTakenToday == false {
            guard let habit = self.habit else {return}
            HabitsStore.shared.track(habit)
            statusHabit.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            delegate?.reloadDataCollection()
        }
       
    }
    
    private func setupConstraits() {
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(statusHabit)
        contentView.addSubview(countLabel)
        
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            timeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            
            statusHabit.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusHabit.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            statusHabit.widthAnchor.constraint(equalToConstant: 50),
            statusHabit.heightAnchor.constraint(equalToConstant: 50),
            
            countLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            countLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor)
        ])
        
    }
    
    
    
}
