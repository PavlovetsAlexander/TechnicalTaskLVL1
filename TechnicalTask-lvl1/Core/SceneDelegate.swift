import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let urlBuilder = URLBuilderImp()
        let networkManager = NetworkManagerImpl(urlBuilder: urlBuilder)
        let userRepository = UserRepositoryImpl(networkManager: networkManager)
        let viewModel = UsersViewModelImpl(userRepository: userRepository)
        window?.rootViewController = UsersViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}

