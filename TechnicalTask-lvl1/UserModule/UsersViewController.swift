import UIKit
import Combine

class UsersViewController: UIViewController {
    // MARK: - Properties
    private var viewModel: UsersViewModel
    private var store: Set<AnyCancellable> = []

    // MARK: - GUI Properties

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(UserTableViewCell.self,
                           forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        bind()
    }

    // MARK: - Initialization
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    // MARK: - Methods
    private func bind() {
        viewModel.users
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { [weak tableView] _ in
                tableView?.reloadData()
            }.store(in: &store)

        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                guard let self else { return }
                self.showErrorAlert(message: message)
            }.store(in: &store)

        viewModel.getUsers()
    }

    private func setupConstraints() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // FIXME: - Add retry action
    private func showErrorAlert(message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate/ UITableViewDataSource
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? UserTableViewCell else {
            return UITableViewCell()
        }
        let userModel = viewModel.getUserModels(at: indexPath.row)
        cell.configure(with: userModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
