import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let networkManager = NetworkManagerImplementation()
        let userRepository = UserLocalRepositoryImplementation(networkManager: networkManager)
        let viewModel = UsersViewModelImplementation(userRepository: userRepository)
        window?.rootViewController = UsersViewController(viewModel: viewModel)
        window?.makeKeyAndVisible()
    }
}

