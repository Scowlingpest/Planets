# Planets

# Features

- Supports a minimum application version of iOS 11.0
- App will go to the API: https://swapi.co/api/planets and download the list of planets, if the list has a 'next' url for the next page of the data then the app will go and download that list as well. It will do so until 'next' is nil.
- Planet data is stored using Core Data and is persisted for offline viewing
- App is universal and will run on both iPhones and iPads
- Unit testing has been added where appropriate
- Application is developed using only Apple provided frameworks
- Dark/Light mode themes can be accessed via the settings screen, with the users choice being stored on device once the application is closed to save the user from reselecting their preferred theme next time they run the app
- Planet data can be viewed by tapping on the planets name, which will extend the section and display the data below that section.
- Settings screen includes a small about section with details relevant to the application.
- Icons provided by https://icons8.com
- All tables in the application have been developed using iOS system fonts to allow for larger text sizes.

# How to Use

1. Install the app on your iPhone or iPad
2. Open the app, it will download the planet information and show you an activity spinner whilst it does.
3. The app will now show you a list of planets.
4. Tap on a planet name/row to open that planet, the app will scroll that planet to the top of the screen so you can see the data.
5. To close a planet simply tap on its row again, or tap on another planet. This will close the planet you had open, scroll you to the new planet and open it.
6. There is a search bar along the top of the planet list, simply type in there to update the list of planets you see. If you type in something it cannot find, it will not update your planets, so you will always have at least 1 planet on screen. To clear your search either click the X, click Cancel, or remove your text.
7. Click the cogs in the top left corner to go to the Settings screen, this contains information about the application and the theme switch.
8. Tap the switch (titled Dark Mode) to change the theme. If the switch is off, you are in Light mode. If the switch is on, you are in Dark mode. The app will remember which theme you picked even if you close and reopen the app.
9. Reopening the app in future will not re-download the data and will take you straight to the planet list.


# Future Features and Improvements

1. Theme

    Currenty the apps two themes are achieved via static colours created in the ThemeHelper class. Once the app has a more extensive theme then the colour values should be moved into a plist and the static colours removed. For future iOS versions, color sets would be the preferred theme storage, due to iOS 13s introduction of system wide themeing, however the Any/Light/Dark feature of color sets is not supported by iOS 11. Therefore if iOS 11 support is planned as a long term goal, then the plist option should be preferred over color sets since we will need the plist regardless and having color sets would just cause duplication and increase the chance of mismatching colours. If iOS 11 support is planned to be phased out relatively soon however, then the move to color sets should happen sooner rather than later. 
    
2. Core Data

    The Core Data implementation presently supports the Planet object, however Planets have links to two other objects: Residents and Films. Both of these objects also contain links to other objects, Vehicles for example. Future development should look to include these other objects in the database and support the corresponding relationships these various objects can have. Additionally, the Core Data implementation should be moved to it's own subproject in future once it becomes more advanced, in order to avoid cluttering up the main project. Another improvement to be considered is to leverage the Codable protocol to make future decoding of the json easier. As the Core Data store gets more complex, we should rely on the CoreDataManager more and investigate having Managers for each type of object.
    
3. Additional Objects

    If the core data implementation is extended to include the other objects, at minimum Residents and Films, then the UI should be updated to show these objects. One possibility it to convert the home screen to a tab/segmented view, one tab for each object, and show the overall list of these objects on each tab with extending headers similar to the planet screen. If we are planning on storing all possible objects from the API however, then a segment view may get cluttered. As such if we wished to support a segment view, we would need to identify which of the objects are important enough to the user, to govern the use of their own tab. We would also need to support showing connected objects modally, such as tapping on a Resident name in a Planet would modally show you their information. The UI workflow would need to be designed with the users needs in mind, meaning that this plan is subject to change. 
  
4. Edited date

    The Planet objects have two dates in them: Created and Edited. Presently the app stores these values, but does not do anything with them. In future, when the app first loads and detects that it has data stored offline, instead of directly going to the application it could repeat the api call and compare the stored planets Edited dates with the downloaded ones. If any of the downloaded Planets have a more recent Edited date, then we should update our stored information for that planet. Alternatively this comparison could occur in the background while the user uses the app, however that causes a potential issue where the planet the user needs the data for could be the planet whose data is out of date, risking us showing the user invalid data. 
  
5. Coordinators

    The application currently utilises the segue pattern of storyboard workflows, however as the app increases in size and complexity, it will be converted to the Coordinator pattern. Whilst this will cause more work in the short term, in the long term it will allow us to have more flexible workflows which require less code to achieve. Since the app presently only has a few screens, the cost of the coordinator pattern outweighs it's advantages, but as the app size increases then the coordinator pattern will be utilised. 
