//
//  TodayProgressViewCell.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 17.04.2023.
//

import UIKit

final class TodayProgressViewCell: UICollectionViewCell {
        
    private let motivation: [String] = ["Вперед к мечте!","Все получится!","Ты молодец!","Еще чуть-чуть!"]
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = motivation.randomElement()
        
        return label
    }()
    
    private lazy var progressPercent: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String((HabitsStore.shared.todayProgress) * 100)+"%"
        return  label
    }()
    
    private lazy var progressBar: UISlider = {
        let slider = UISlider()
            slider.setThumbImage(UIImage(), for: .normal)
            slider.setValue(HabitsStore.shared.todayProgress, animated: true)
            slider.tintColor = .purple
            slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func upgradeProgress() {
        progressPercent.text = String((HabitsStore.shared.todayProgress) * 100)+"%"
        progressBar.setValue(HabitsStore.shared.todayProgress, animated: true)
    }
    
    private func setupView() {
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressPercent)
        contentView.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            progressBar.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 10),
            progressBar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressBar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressBar.heightAnchor.constraint(equalToConstant: 7),
            
            progressPercent.topAnchor.constraint(equalTo: progressLabel.topAnchor),
            progressPercent.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12)
//            progressPercent.leftAnchor.constraint(equalTo: , constant: <#T##CGFloat#>)
        
        ])
        
    }
}
