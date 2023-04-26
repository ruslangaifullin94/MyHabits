//
//  DetailViewCell.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 20.04.2023.
//

import UIKit

final class HabitDetailViewCell: UITableViewCell {
    var habit: Habit?

    private let dateFormatter = DateFormatter()
    fileprivate lazy var data = self.habit?.trackDates
    private lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusDate: UIImageView = {
        let status = UIImageView()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.image = UIImage(systemName: "checkmark")
        status.alpha = 0
        return status
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupView()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(statusDate)
        
        NSLayoutConstraint.activate([
            
            dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
//            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: <#T##CGFloat#>)
            
            statusDate.centerYAnchor.constraint(equalTo: dateLabel.centerYAnchor),
            statusDate.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -14),
            statusDate.heightAnchor.constraint(equalToConstant: 44),
            statusDate.widthAnchor.constraint(equalToConstant: 22)
        
        ])
    }
    
    func update (_ date: Date) {
        dateFormatter.dateStyle = .medium
        let dateValue = dateFormatter.string(from: date)
//        let dateValue = HabitsStore.trackDateString()
//        let data = habit.trackDates
        dateLabel.text = dateValue
        
//        if date == habit.trackDates[]
        
    }
}
