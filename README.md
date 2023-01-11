# GameWo
 Games tracker app  where you can find the most popular and newly coming games and search with different genres, stores and platforms and search for specific games 

----------------------------
#### App architecture 
* MVP - > model view presenter 

#### App Structure 
1. Storyboards -> contains storyboards
2. Scenes -> contains app screans each with (view+presenter+protocols)
3. Appbase -> contains main Viewcontroller that other views inherit from and base protocols that other protocols inherit from 
4. Secrets -> contains xcconfig file that contains the token in it and a Secret manager to read the token from the xcconfig file 
5. Helper Extensions -> contains helper extensions for uiview IBDesignable, IBInspectable, and animation manager 
6. network layer -> contains api configuration, Endpoints, api constant, network caller and routes
7. App constant -> contains identifiers for viewcontrollers, cells ...etc 
8. models -> contains models for api responses  

![](appGIF.gif)
