//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Руслан Гайфуллин on 17.04.2023.
//

import UIKit


class HabitViewController: UIViewController{
    
    private let dateFormatter = DateFormatter()
    private let habit: Habit?
    weak var delegate: HabitDetailViewControllerDelegate?
    
    private lazy var habitScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemBackground
        return scrollView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.tintColor = .black
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var enterHabitName: UITextField = {
        let habitName = UITextField()
        habitName.translatesAutoresizingMaskIntoConstraints = false
        habitName.placeholder = "enter habit name"
        habitName.keyboardType = .default
        habitName.returnKeyType = .done
        habitName.delegate = self
        return habitName
    }()

    private lazy var habitColor: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.tintColor = .black
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var setHabitColor: UIImageView = {
       let setColor = UIImageView()
        setColor.translatesAutoresizingMaskIntoConstraints = false
        setColor.image = UIImage(systemName: "circle.fill")
        setColor.isUserInteractionEnabled = true
        setColor.clipsToBounds = true
        return setColor
    }()
    
    private lazy var habitTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.tintColor = .black
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .black
        label.font = .systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    private lazy var setTimePicker: UIDatePicker = {
        let pickerDate = UIDatePicker()
        pickerDate.translatesAutoresizingMaskIntoConstraints = false
        pickerDate.preferredDatePickerStyle = .wheels
        pickerDate.datePickerMode = .time
        pickerDate.locale = .init(identifier: "ru_RU")
        pickerDate.addTarget(self, action: #selector(datePickerValue), for: .valueChanged)
        return pickerDate
    }()
    
    private lazy var deleteHabitButton: UILabel = {
       let button = UILabel()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.tintColor = .systemRed
        button.text = "Удалить привычку"
        button.textColor = .systemRed
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var habitController: HabitDetailsViewController = {
        let controller = HabitDetailsViewController(habit: habit)
        
        return controller
    }()
    
    init(habit: Habit?) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        dateFormatter.dateFormat = "HH : mm"
        setupView()
        setupSubview()
        initHabit()
        setupConstraits()
        datePickerValue()
        setupGestureRecognizer()
        
    }
    
    private func initHabit() {
        if let habit = self.habit {
            // изменить привычку
            self.navigationItem.title = "Изменить"
            enterHabitName.text = habit.name
            setHabitColor.tintColor = habit.color
            setTimePicker.date = habit.date
            deleteHabitButton.alpha = 1
        } else {
            // создать привычку
            self.navigationItem.title = "Создать"

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setNeedsLayout()
        navigationController?.navigationBar.isHidden = false

    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "tabBarBackgroundColor")
        title = "Cоздать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(closeAddHabit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(makeHabit))
    }
    
    private func setupSubview() {
        view.addSubview(habitScrollView)
        habitScrollView.addSubview(nameLabel)
        habitScrollView.addSubview(enterHabitName)
        habitScrollView.addSubview(habitColor)
        habitScrollView.addSubview(setHabitColor)
        habitScrollView.addSubview(habitTimeLabel)
        habitScrollView.addSubview(habitTime)
        habitScrollView.addSubview(setTimePicker)
        habitScrollView.addSubview(deleteHabitButton)
    }
    
    private func setupConstraits() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            habitScrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            habitScrollView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            habitScrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            habitScrollView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: habitScrollView.topAnchor, constant: 21),
            nameLabel.leftAnchor.constraint(equalTo: habitScrollView.leftAnchor, constant: 16),
            
            enterHabitName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            enterHabitName.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            habitColor.topAnchor.constraint(equalTo: enterHabitName.bottomAnchor, constant: 15),
            habitColor.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            setHabitColor.topAnchor.constraint(equalTo: habitColor.bottomAnchor, constant: 7),
            setHabitColor.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            setHabitColor.heightAnchor.constraint(equalToConstant: 30),
            setHabitColor.widthAnchor.constraint(equalToConstant: 30),
            
            habitTimeLabel.topAnchor.constraint(equalTo: setHabitColor.bottomAnchor, constant: 15),
            habitTimeLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            habitTime.topAnchor.constraint(equalTo: habitTimeLabel.bottomAnchor, constant: 7),
            habitTime.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            
            setTimePicker.topAnchor.constraint(equalTo: habitTime.bottomAnchor, constant: 20),
            setTimePicker.centerXAnchor.constraint(equalTo: habitScrollView.centerXAnchor),
            
            deleteHabitButton.topAnchor.constraint(equalTo: setTimePicker.bottomAnchor, constant: 100),
            deleteHabitButton.centerXAnchor.constraint(equalTo: habitScrollView.centerXAnchor),
            deleteHabitButton.widthAnchor.constraint(equalToConstant: 150),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 30)
        
        ])
    }
    
    private func setupGestureRecognizer() {
        let tapGestureColor = UITapGestureRecognizer(target: self, action: #selector(setColor))
        tapGestureColor.numberOfTapsRequired = 1
        setHabitColor.addGestureRecognizer(tapGestureColor)
        let tapGestureCloseKeyboard = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        tapGestureCloseKeyboard.numberOfTouchesRequired = 1
        habitScrollView.addGestureRecognizer(tapGestureCloseKeyboard)
        let tapGestureDeleteHabit = UITapGestureRecognizer(target: self, action: #selector(didTapDeleteButton))
        tapGestureDeleteHabit.numberOfTapsRequired = 1
        deleteHabitButton.addGestureRecognizer(tapGestureDeleteHabit)
    }
    
    private func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.title = "Background Color"
        colorPicker.supportsAlpha = false
        colorPicker.delegate = self
        colorPicker.selectedColor = setHabitColor.tintColor
        colorPicker.modalPresentationStyle = .popover
        if #available(iOS 16.0, *) {
            colorPicker.popoverPresentationController?.sourceItem = self.navigationItem.rightBarButtonItem
        } else {
            // Fallback on earlier versions
        }
        self.present(colorPicker, animated: true)
    }
    
   @objc private func datePickerValue() {
       let dateValue = dateFormatter.string(from: setTimePicker.date)
       habitTime.text = "Каждый день в " + dateValue
      
    }
    
    @objc private func closeAddHabit() {
        self.dismiss(animated: true)
    }
    
    @objc private func makeHabit() {
        if let habit = self.habit {
            habit.name = enterHabitName.text!
            habit.date = setTimePicker.date
            habit.color = setHabitColor.tintColor
            if let index = HabitsStore.shared.habits.firstIndex(where: {$0.name == self.habit?.name}){
                HabitsStore.shared.habits[index].name = habit.name
                HabitsStore.shared.habits[index].date = habit.date
                HabitsStore.shared.habits[index].color = habit.color
            }
            HabitsStore.shared.save()
            self.dismiss(animated: true)
            
        } else {
            let newHabit = Habit(name: enterHabitName.text!, date: setTimePicker.date, color: setHabitColor.tintColor)
            let makeHabit = HabitsStore.shared
            makeHabit.habits.append(newHabit)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func setColor() {
        presentColorPicker()
    }
    @objc private func closeKeyboard() {
        self.view.endEditing(true)
    }
    @objc private func didTapDeleteButton() {
        
        let alert = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить \((habit?.name)!) ?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Отмена", style: .default) {
            UIAlertAction in
            
        }
        let cancelAction = UIAlertAction(title: "Удалить", style: .destructive) {
            UIAlertAction in
            if let index = HabitsStore.shared.habits.firstIndex(where: {$0.name == self.habit?.name}){
                HabitsStore.shared.habits.remove(at: index)
                
//                self.delegate?.closeController()
               
//                self.dismiss(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
//                self.habitController.closeController()
                
                
            }
        }
       
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
       
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate, UITextFieldDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.setHabitColor.tintColor = viewController.selectedColor
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
}
