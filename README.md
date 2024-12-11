# TechnicalTaskLVL1
It’s necessary to create an iOS application for this assignment, which contains two screens.
In the first screen it’s needed to list some Users (description for ‘what should be shown on UI’ you will find later in this document) from CoreData storage.
I should be able to delete a User from the database.
In the second screen users should be able to create a new user just locally, and update the list of users after creation.
Business rules:
In the first screen, the user list should be sorted by the names in ascending order and case insensitive. 
Emails of users should be unique.
If the user tries to create a new user with an already taken email then it’s needed to display some kind of error to the user. 
Whenever the application is launched, the user list should be fetched again from the API. 
If there are users in the API response which don’t exist in the database, then they should be inserted. 
Users previously created locally should not be deleted after updates from API response.
Offline mode should be handled. When the device does not connect to the internet, 
info from CoreData and a banner with information about “No internet connection. 
You’re in Offline mode” should be shown on the screen.
In the first screen, updates to the list should be animated. 
When the application is launched, the user should be navigated to the first screen automatically. 
Email input on the second screen should handle basic email validation.

# Project requirements:
Use the native CoreData framework for the database layer is required. 
Architectural pattern - feel free to choose the one that suits you best.
Reactive Approach (RxSwift or Combine) is strongly recommended. 
The application can be targeted for iOS 15.0. 
UIKit is required.
UI should adopt different screen sizes.
Swift 5.0+ is required. 
Using Git is required (you should create PR’s even without code review, just to show us how you work with Git). 
Main (master) branch required for the project - final PR should be opened into this branch and a link should be provided to the Jedi for review.
Third-party usage is allowed. 
You can use whatever tech you feel most comfortable. 
There are no special design requirements, but the functionality and UI will be reviewed.
Submissions and starting point:
For the starting point you should fork repository to your Git account (Innowise git is preferable)
For submission please use Git and PR’s system. All steps of submission described above.
Repository for starting point:
https://github.com/ValeryVasilevich/TechnicalTaskLVL1
UI (base idea of what we expect):
https://drive.google.com/file/d/1GBrRLzci-BFrBmrslZmqmvl4VoqcLYhN/view?usp=sharing 
# API:
https://jsonplaceholder.typicode.com/users
