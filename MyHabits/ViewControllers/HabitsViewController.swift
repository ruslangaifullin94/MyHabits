//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 16.04.2023.
//

import UIKit
import Foundation

protocol HabitsViewControllerDelegate: AnyObject{
    func reloadDataCollection()
}

class HabitsViewController: UIViewController {

    var habitData = HabitsStore.shared.habits
    
    private lazy var habitCollectionView: UICollectionView  = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 22, left: 16, bottom: 0, right: 17)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "collectionViewBackgroundColor")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TodayProgressViewCell.self, forCellWithReuseIdentifier: CellReuse.custom.rawValue)
        collectionView.register(HabitViewCell.self, forCellWithReuseIdentifier: CellReuse.base.rawValue)
        return collectionView
    }()
    
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraits()
        NotificationCenter.default.addObserver(self, selector: #selector(didTapStatusButtonNotification), name: Notification.Name("tapStatusButton"), object: nil)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupController()
//        habitCollectionView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        print("privet")
        
        habitData = HabitsStore.shared.habits
        habitCollectionView.reloadData()
    }
    //MARK: - Metods
    
    private func setupController() {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(named: "tabBarBackgroundColor")
        navigationController?.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addHabit))
        view.addSubview(habitCollectionView)
    }
    
    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            habitCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ])
    }
    
    @objc private func addHabit() {
        let habitViewController = UINavigationController(rootViewController: HabitViewController(habit: nil))
//        habitViewController.title = "Создать"
        habitViewController.modalTransitionStyle = .coverVertical
        habitViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(habitViewController, animated: true)
    }
    
    internal func reload() {
        let cell = habitCollectionView.cellForItem(at: IndexPath(row: 0, section: 0)) as? TodayProgressViewCell
        cell?.upgradeProgress()
        self.habitCollectionView.reloadData()
    }
    
    @objc private func didTapStatusButtonNotification() {
        
    }

}


extension HabitsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var sideInset: CGFloat {
        return 12
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
          return habitData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuse.custom.rawValue, for: indexPath) as? TodayProgressViewCell else {return UICollectionViewCell()}
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            cell.upgradeProgress()
            return cell
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuse.base.rawValue, for: indexPath) as? HabitViewCell else {return UICollectionViewCell()}
//            let sortedHabitStore = HabitsStore.shared.habits
//                .sorted {$0.date > $1.date}
//                .map {$0.name}
//            let model = sortedHabitStore[indexPath.row]
            let model =  habitData[indexPath.row]
            cell.delegate = self
            cell.setupCollectionCell(with: model)
            cell.backgroundColor = .systemBackground
            cell.layer.cornerRadius = 8
            cell.clipsToBounds = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habitDetailsViewController = HabitDetailsViewController(habit: HabitsStore.shared.habits[indexPath.item])
            self.navigationController?.pushViewController(habitDetailsViewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.bounds.width - 33
        if indexPath.section == 0 {
            return CGSize(width: width, height: 60)
        } else {
            return CGSize(width: width, height: 130)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sideInset
    }
   
}

extension HabitsViewController: HabitsViewControllerDelegate {
    func reloadDataCollection() {
        print("reload")
        self.reload()
    }
}
