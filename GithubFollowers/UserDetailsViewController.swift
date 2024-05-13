import UIKit


class UserDetailsViewController: UIViewController {
    
    var selectedFollower: Followers?
    
    var userDetails: UserDetails?
    
    let avatarImageView = AvatarImageView(contentMode: .scaleAspectFill)
    
    let profileView = FinacleView(frame: .zero)
    
    let usernameLabel = FinacleLabel(font:UIFont.systemFont(ofSize: 34, weight: .bold))
    
    let urlLabel = FinacleLabel(font:UIFont.systemFont(ofSize: 14, weight: .medium))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayFollowerDetails()
        fetchUserDetails()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(profileView)
        // Profile View Add Subviews
        profileView.addSubview(avatarImageView)
        profileView.addSubview(usernameLabel)
        profileView.addSubview(urlLabel)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        urlLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // Profile View Constraints
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            profileView.heightAnchor.constraint(equalToConstant: 100),
            
            // Avatar Image View Constraints
            avatarImageView.leadingAnchor.constraint(equalTo: profileView.leadingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            
            // Usernmae Label Constraints
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            usernameLabel.centerYAnchor.constraint(equalTo: profileView.centerYAnchor),
            
            // Testing selectedFollower.url Label data constraints
            urlLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            urlLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
        ])
    }
    
    func displayFollowerDetails() {
        guard let follower = selectedFollower else { return }
        
        if let avatarURL = URL(string: follower.avatarURL) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: avatarURL) {
                    DispatchQueue.main.async { [weak self] in
                        self?.avatarImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        usernameLabel.text = follower.login
        urlLabel.text = follower.url
    }
    
    
    func fetchUserDetails(){
        guard let follower = selectedFollower,
              let url = URL(string: follower.url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error fetching user details:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                self?.userDetails = userDetails
                print("Received User Details:", userDetails)
            } catch {
                print("Error decoding JSON:", error.localizedDescription)
            }
            
        }
        task.resume()
    }
}
