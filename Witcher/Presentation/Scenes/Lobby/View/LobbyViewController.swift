//
//  LobbyViewController.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//

import UIKit


final class LobbyViewController: UIViewController,
                                 UIPickerViewDelegate,
                                 UIPickerViewDataSource {
    
    // MARK: - Dependencies
    
    private let viewModel: LobbyViewModelProtocol
    
    
    // MARK: - Init
    
    init(viewModel: LobbyViewModelProtocol,
         nibName nibNameOrNil: String? = nil,
         bundle nibBundleOrNil: Bundle? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nibNameOrNil,
                   bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View's lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    
    // MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .white
        aiPickerView.selectRow(viewModel.selectedAiSetupPickerRow,
                               inComponent: 0,
                               animated: false)
        roundPickerView.selectRow(viewModel.selectedTotalCountOfRoundsPickerRow,
                                  inComponent: 0,
                                  animated: false)
    }
    
    private lazy var aiPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Сложность бота"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aiPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = #colorLiteral(red: 0.8976908326, green: 0.8977413177, blue: 0.918277204, alpha: 1)
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var roundPickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Количество раундов"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var roundPickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = #colorLiteral(red: 0.8976908326, green: 0.8977413177, blue: 0.918277204, alpha: 1)
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var startGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать игру",
                        for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,
                                                    weight: .semibold)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0, green: 0.7409000993, blue: 0.9917448163, alpha: 1)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func startGameButtonTapped() {
        viewModel.startGameButtonTapped()
    }
    
    
    // MARK: - Layout
    
    private func setupLayout() {
        view.addSubview(aiPickerLabel)
        view.addSubview(aiPickerView)
        view.addSubview(roundPickerLabel)
        view.addSubview(roundPickerView)
        view.addSubview(startGameButton)
        
        aiPickerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        aiPickerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        aiPickerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        aiPickerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        aiPickerView.topAnchor.constraint(equalTo: aiPickerLabel.bottomAnchor, constant: 10).isActive = true
        aiPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        aiPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        aiPickerView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        roundPickerLabel.topAnchor.constraint(equalTo: aiPickerView.bottomAnchor, constant: 40).isActive = true
        roundPickerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        roundPickerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        roundPickerLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        roundPickerView.topAnchor.constraint(equalTo: roundPickerLabel.bottomAnchor, constant: 10).isActive = true
        roundPickerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        roundPickerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        roundPickerView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        startGameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        startGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startGameButton.widthAnchor.constraint(equalToConstant: 190).isActive = true
        startGameButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    // MARK: - UIPickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView {
        case aiPickerView:
            return 1
        case roundPickerView:
            return 1
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case aiPickerView:
            return viewModel.availableAiSetup.count
        case roundPickerView:
            return viewModel.totalCountOfRounds.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case aiPickerView:
            return viewModel.availableAiSetup[row]
        case roundPickerView:
            return String(viewModel.totalCountOfRounds[row])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case aiPickerView:
            viewModel.aiSetupPickerDidSelectRow(row)
        case roundPickerView:
            viewModel.countOfRoundsPickerDidSelectRow(row)
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch pickerView {
        case aiPickerView:
            return NSAttributedString(
                string: viewModel.availableAiSetup[row],
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]
            )
        case roundPickerView:
            return NSAttributedString(
                string: String(viewModel.totalCountOfRounds[row]),
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.black]
            )
        default:
            return nil
        }
    }
    
}
