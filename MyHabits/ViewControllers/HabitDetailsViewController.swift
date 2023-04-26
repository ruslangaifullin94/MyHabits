//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 19.04.2023.
//

import UIKit

protocol HabitDetailViewControllerDelegate: AnyObject {
    func closeController()
}

class HabitDetailsViewController: UIViewController {
    
    private let habit: Habit?
//    private let store: HabitsStore?
    fileprivate lazy var data = self.habit?.trackDates
    private lazy var habitDateTrack: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.dataSource = self
        tableView.register(HabitDetailViewCell.self, forCellReuseIdentifier: CellReuse.detail.rawValue)
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        return  tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraits()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupController()
    }
    
    
    init(habit: Habit?) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(didTapRightBarButton))
        self.title = habit?.name
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = UIColor(named: "tabBarBackgroundColor")
    }
    
    private func setupView() {
       
        view.addSubview(habitDateTrack)
    }
    
    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitDateTrack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitDateTrack.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            habitDateTrack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitDateTrack.rightAnchor.constraint(equalTo: safeArea.rightAnchor)
        ])
    }
    
    @objc private func didTapRightBarButton() {
        let habitViewController = UINavigationController(rootViewController: HabitViewController(habit: habit))
//        habitViewController.title = "Создать"
        habitViewController.modalTransitionStyle = .coverVertical
        habitViewController.modalPresentationStyle = .fullScreen
        
//        self.navigationController?.present(habitViewController, animated: true)
        self.navigationController?.pushViewController(HabitViewController(habit: habit), animated: true)
    }


}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        habit?.trackDates.count ?? 1
        HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellReuse.detail.rawValue) as? HabitDetailViewCell else {return UITableViewCell()}
//        let model = habit?.trackDates[indexPath.row]
        let date = HabitsStore.shared.dates[indexPath.item]
//        let model = HabitsStore.shared.habits[indexPath.item]
        cell.update(date)
        return cell
    }
    
    
}

extension HabitDetailsViewController: HabitDetailViewControllerDelegate {
     func closeController() {
         print("work")
         self.navigationController?.popToRootViewController(animated: true)
         
    }
}
