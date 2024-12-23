import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        // FIXME: - add di container
        let urlBuilder = URLBuilderImp()
        let networkManager = NetworkManagerImpl(urlBuilder: urlBuilder)
        let userRepository = UserRepositoryImpl(networkManager: networkManager)
        let coreDataConfigurator = CoreDataConfiguratorImplementation(with: Environment.dataModelName)
        let coreDataManager = CoreDataManagerImplementation(coreDataConfigurator: coreDataConfigurator)
        let userLocalRepository = UserLocalRepositoryImplementation(coreDataManager: coreDataManager)
        let userRepositoryManager = UserRepositoryManagerImplementation(localUserRepository: userLocalRepository,
                                                                        remoteUserRepository: userRepository)
        let viewModel = UsersViewModelImpl(userRepositoryManager: userRepositoryManager)
        window?.rootViewController = UsersViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}

