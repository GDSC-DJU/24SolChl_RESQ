## 1. 😀 Welcome to RESQ :)
  * Provides accident type alerts to users by analyzing real-time location-based risk information.
  * Instills a sense of danger in users, providing accident prevention and response measures.
  * **An accident prevention service through place recognition and crisis detection.**
  
## 2. 📢 Introduction
  Unexpected accidents and emergencies can occur at any time depending on the characteristics of each country or region. This includes earthquakes, fires, traffic accidents, etc. When an urgent situation occurs, it is difficult to make quick and accurate judgments. Therefore, we wanted to allow users to be aware of countermeasures in advance by having a sense of caution before a crisis situation.
  RESQ helps users to prevent and prepare wherever they are. It collects and analyzes user data in real time to inform you of all possible dangerous situations. Then, it presents preventive measures that users can prepare for. 

## 3. ⚽️ UN SDGs & Our Goals
![alt text](sdgs.png)
  Our solution has selected **Health and Well-being, Sustainable Cities and Communities, and Climate Action from the UN's Sustainable Development Goals.** The reason for choosing these goals is considering the reality that many people are currently unable to cope with unexpected accidents or disasters, and as a result, casualties and property damage are occurring. We aimed to develop a system that could take immediate action to prevent and prepare for such situations.
  * From the perspective of Health and Well-being, our solution helps people live healthily and safely in a safe environment. It provides ways to prepare for each type of accident in advance, enabling quick and accurate responses when a disaster occurs. Through accident awareness, a more composed response is possible, which in turn can minimize casualties.
  * In terms of Sustainable Cities and Communities, our system aids in identifying and preventing risk factors in cities and residences. This helps create a safe environment in cities and residences, improving the quality of life for residents.
  * From the perspective of Climate Action, our solution assists in preventing and preparing for disasters caused by climate change. By integrating weather information and location information to prevent unexpected accidents caused by climate change in specific places, it provides ways to deal with accident types, reducing damage from disasters.
  In this way, we decided to use smartphones and wearable devices, which are always with us and can ask for help. Based on your real-time location, we inform you of all situations that can occur in that place and also provide immediate solutions. Through our service, we will contribute to promoting health and safety, creating sustainable cities and residences, and ensuring people's safety and well-being in response to climate change.
  
## 4. Google Technologies Used
  * **Flutter**: Flutter is an open-source mobile application development framework developed by Google. It is based on the Dart language and provides high-quality native interfaces for both iOS and Android from a single codebase. Flutter offers many advantages to developers, such as fast development speed, various UI components, and performance identical to native apps. Also, Flutter includes the features that RESQ needs to use in its package, and it's convenient to integrate with the GCP API. For these reasons, we chose the Flutter technology.
  
  * **Firebase**: Firebase is a cloud-based backend service platform provided by Google. It offers a variety of backend services such as real-time database, authentication, cloud storage, hosting, push notifications, etc. Using Firebase reduces the burden of server development and maintenance, and allows easy use of cloud-based backend services. Also, Firebase integrates well with Flutter, making it suitable for Flutter application development. For these reasons, we chose Firebase technology.
  
* **Google Cloud API Service**: Processed and processed the required information using the Google Maps API, Google Places API, Google Elevation API, and Google Geocode API.
  
## 5. Architecture

## 6. APP Screenshot & Description

## 7. Future
  Our goal is to get as many people as possible to use the RESQ application, enabling them to live in a safe environment. To this end, we plan to pursue the following expansion plans in the next step:
  * **Hardware integration**: We will distribute accident prevention videos and images on billboards or signs and attach QR codes for easy access to the RESQ application. This will reduce the inconvenience of users having to find and install the application themselves and increase the accessibility of the application.
  * **AI feature expansion**: Currently, we have the ability to detect disaster situations such as fires and earthquakes, but we plan to expand this to detect and respond to various accident situations. We will improve the AI algorithm and collect new data for learning if needed to analyze and provide more information.
  * **UI improvement**: We will improve the UI so that users can use the RESQ application more conveniently. To this end, we will collect user feedback, conduct A/B tests, and improve the UI/UX.

## 8. How to Run
  * To build, an API key is required.
    * Modify the following part in the code located in the /android/app/src/main/AndroidManifest.xml directory.
    ```
    <meta-data 
	android:name = "com.google.android.geo.API KEY"
	android:value = "API KEY"/> <!-- Please insert the API key here --> 
    ```
    
    * Add the API key to the "GEOCODE_API" variable in the /lib/widgets/location_display.dart file.
    ```
    const GEOCODE_API = "API KEY"; // Please insert the API key here
    ```
    * Add the API key to the API variable in the /lib/widgets/location_based_information.dart file.
    ```
    const googleElevationKey = "API KEY" //Please insert the API key here
    const googlePlacesKey = "API KEY" //Please insert the API key here
    const weatherKey = "API KEY"; //Please insert the Openweather API key here
    ```
  * **The runApp code only exists in the /lib/main.dart file. Therefore, the app is built from the main.dart file.**
  * After the app is launched, it analyzes and outputs the type of accident based on the acquired location and weather data.
    * There may be a slight delay in providing this information.

## 9. R&R
- **김민혁** (MinHyeok Kim)
- **정애리** (AeRi Jung)
- **곽지훈** (JiHoon Kwak)
- **표성우** (SungWoo Pyo)
    

## Credits
This project uses icons from Flaticon(www.flaticon.com) by various designers:

- [Andrejs Kirma](https://www.flaticon.com/kr/authors/andrejs-kirma)
- [BankSeeNgern](https://www.flaticon.com/kr/authors/bankseengern)
- [Circlon Tech](https://www.flaticon.com/kr/authors/circlon-tech)
- [Dixit Lakhani_02](https://www.flaticon.com/kr/authors/dixit-lakhani-02)
- [Ehtisham Abid](https://www.flaticon.com/kr/authors/ehtisham-abid)
- [Freepik](https://www.flaticon.com/kr/authors/Freepik)
- [GOFOX](https://www.flaticon.com/kr/authors/GOFOX)
- [IdeaGrafc](https://www.flaticon.com/kr/authors/ideagrafc)
- [kliwir art](https://www.flaticon.com/kr/authors/kliwir-art)
- [Leremy](https://www.flaticon.com/kr/authors/leremy)
- [Mehwish](https://www.flaticon.com/kr/authors/mehwish)
- [Muhammad_Usman](https://www.flaticon.com/kr/authors/muhammad-usman)
- [NajmunNahar](https://www.flaticon.com/kr/authors/najmunnahar)
- [orvipixel](https://www.flaticon.com/kr/authors/orvipixel)
- [Prosymbols Premium](https://www.flaticon.com/kr/authors/prosymbols-premium)
- [Smashicons](https://www.flaticon.com/kr/authors/smashicons)
- [tulpahn](https://www.flaticon.com/kr/authors/tulpahn)
- [Vector Stall](https://www.flaticon.com/kr/authors/vector-stallk)
- [WR Graphic Garage](https://www.flaticon.com/kr/authors/wr-graphic-garage)
- [Yuluck](https://www.flaticon.com/kr/authors/Yuluck)

