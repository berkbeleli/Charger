# Charger App

App Icon: 

![fast-charge](https://user-images.githubusercontent.com/44535117/179375060-7ed98dfd-2051-4ed4-844c-4ea007507228.png)


Loading Animation:

![loaderr](https://user-images.githubusercontent.com/44535117/179394147-2cf41aaf-e908-4b8f-968b-c6fbf8d2a442.gif)



Application Aims:

This app basically for the electric car users the app users can make appointment according to their choices. Also app users can choice to receive notification option.

## Table Of Content
- About The Project
- Used Packages
- Pages
- Screen Recording
- Small Screen Views

# About The Project

- This project has been created with using MVVM architecture pattern
- This project made with custom font Proxima Nova (This font family is used by big companies like Buzzfeed)
- The Status Bar will always be the light Mode
- All of the Constants are received from the Constants Files the Usage of the quotes as less as possible
- All of the GradientView backgrounds are handled from the same class
- App compatible with small screen sizes.
- Local notifications can be set
- Local notification will be deleted after the appointment deleted
- All of the datas provided by API
- All of the API processes handled from Alamafire Generic API Handler. 
- Users can only make appointment only for the future dates
- All of the custom popups handled from the same view
- Create, Read with CoreData
- Supported Languages: English, Turkish

# Why MVVM
After using MVVM, I've found it to be very beneficial in many ways. Let’s get back to the list of things we set out to accomplish when architecting our app to see if MVVM addresses them.

- Single responsibility principles applied.
- Easy to iterate on.
- Collaboration friendly.
- Separated out concerns.
- Spec-ability.
- Testability.


# Used Packages
- Alamofire = Alamofire let us do more work with less lines of codes than URL Session as I used a generic API handler function with Alamofire I made the project cleaner and more understandable for anyone.
- Skeleton View = Using skeleton View I created a gradient animation for Stations Page
- LottieFiles = Using LottieFiles package I create a nice animation as loading some of the pages datas

# Splash Screen
<img width="375" alt="01_EV_Splash_01" src="https://user-images.githubusercontent.com/44535117/179416931-678ec257-b090-443e-8842-aa4d62040248.png">

## Permission ScreenShots

<img width="217" alt="Screenshot 2022-07-17 at 08 12 23 PM" src="https://user-images.githubusercontent.com/44535117/179417201-fbf21884-d575-498f-b705-ea9fe4b3d213.png"> <img width="218" alt="Screenshot 2022-07-17 at 08 11 48 PM" src="https://user-images.githubusercontent.com/44535117/179417207-22cd8682-26b3-4779-b12d-4f8ed161ad5e.png">

<img width="214" alt="Screenshot 2022-07-17 at 08 16 31 PM" src="https://user-images.githubusercontent.com/44535117/179417211-95c57331-da3e-4843-9ac8-77a5ac9e1e31.png"> <img width="223" alt="Screenshot 2022-07-17 at 08 11 56 PM" src="https://user-images.githubusercontent.com/44535117/179417212-7e40cbf9-e6d2-4400-9ed4-1edc4696347a.png">


# Login Page 
When the app opened for the first time notification and location permissions will be asked from the user. In this page we need to enter a valid email address to create an appointment if we enter a wrong email address firstly the mail address will be checked by the local side after that the server side. If the user exists the user will sign in, otherwise user will be signed up and logged in. if there is any error about entered email or any server side problem there will be custom error pop up in the screen. Also the keyboard type will be email here so user can see email characters in the main keyboard page when people pressed return button from the keyboard the keyboard will be disappear. Also title will be bold in both supported languages.

## Login Page ScreenShots
<img width="334" alt="Screenshot 2022-07-17 at 08 24 12 PM" src="https://user-images.githubusercontent.com/44535117/179417457-cf894a8e-d87a-478f-ad02-6c4dbcb201f4.png">   <img width="337" alt="Screenshot 2022-07-17 at 08 23 14 PM" src="https://user-images.githubusercontent.com/44535117/179417460-5c63c49b-e54c-4be5-8551-30714515e31b.png">

# Server Error(Custom Error View) ScreenShots
For all of the server type errors our custom popUp View's will look like this only the subtitle will be changed according to the error.

<img width="333" alt="Screenshot 2022-07-17 at 10 43 42 PM" src="https://user-images.githubusercontent.com/44535117/179422268-23c699be-0992-4102-85d9-ee4a1882c39f.png"> <img width="321" alt="Screenshot 2022-07-17 at 10 44 03 PM" src="https://user-images.githubusercontent.com/44535117/179422270-aea005da-75df-4a8f-8890-934a87c21a3c.png">



# Appointments Page (Empty State)
In this page you can see your past and current appointments if you haven't created any appointment you will not see any appointment in this page. As this page loading you will see lottifiles animation laoding view. In this page datafetch and showing animation made in the  Viewwillload function so the appointments will be reloaded when user returns to this page.

## Appointments Page (Empty State) ScreenShots
<img width="341" alt="Screenshot 2022-07-17 at 08 31 35 PM" src="https://user-images.githubusercontent.com/44535117/179417678-3ab76135-3075-4342-be27-93b89a7ae43a.png">  <img width="324" alt="Screenshot 2022-07-17 at 08 26 35 PM" src="https://user-images.githubusercontent.com/44535117/179417613-062543c8-8d11-47ab-afc2-d56bc4be3409.png">


# Profile Page
In this page you can see your profile infos (email and deviceUDID) if you want to logout of current user profile you can logout from this page. This page supports the swipe to back page option.

## Profile Page Screen Shots

<img width="328" alt="Screenshot 2022-07-17 at 08 33 42 PM" src="https://user-images.githubusercontent.com/44535117/179417755-24edefb5-ffb0-4b42-8897-1153413d2324.png">  <img width="325" alt="Screenshot 2022-07-17 at 08 33 52 PM" src="https://user-images.githubusercontent.com/44535117/179417765-8bef1b57-29b5-4ddc-b841-2a0ca4afdd85.png">



# City Selection Page
You can reach this page after pressing create appointment button from the Appointments page. The cities those are catched from API will be listed in this page. Datas will be loaded in the ViewwillLoad function just like the Appointments page. As this datas loading you will see the lottieFile animation view. Via Custom SearchBar you can search by city names you can search by turkish or english character even the table shows in turkish. For example you can search for "can" for the city "Çankırı" the app will handle it and make bolder entered text in the result cities also change custom search textfield border color green color. if there is not any matching cities the no result view will appear also change custom search textfield border color red. Also the keyboard(for search city textfield) return button handled in this page as well when user press that button the keyboard will disappers. This page supports swipe to back page option.

## City Selection Page ScreenShots
<img width="323" alt="Screenshot 2022-07-17 at 08 43 47 PM" src="https://user-images.githubusercontent.com/44535117/179418152-bb4965e9-c89d-4d82-bc7f-f3d051ea502f.png">  <img width="334" alt="Screenshot 2022-07-17 at 08 43 59 PM" src="https://user-images.githubusercontent.com/44535117/179418157-cd8f7d48-a074-47df-a346-0779f02f2df9.png">  <img width="332" alt="Screenshot 2022-07-17 at 08 44 07 PM" src="https://user-images.githubusercontent.com/44535117/179418164-20ffc345-694f-406c-8bb7-e4b02f27e5f6.png">

<img width="334" alt="Screenshot 2022-07-17 at 08 44 15 PM" src="https://user-images.githubusercontent.com/44535117/179418169-7950654f-ee73-47c8-8131-c67ebdf0a43a.png"> <img width="330" alt="Screenshot 2022-07-17 at 08 47 45 PM" src="https://user-images.githubusercontent.com/44535117/179418273-6953546f-1bf4-4f60-b641-49c53734328c.png"> <img width="327" alt="Screenshot 2022-07-17 at 08 44 24 PM" src="https://user-images.githubusercontent.com/44535117/179418179-51540048-9360-4adc-a82e-c0b6feefe970.png">

  
# Station Selection Page
You will see this page after selecting a city from City Selection Page. In this page you will see the stations according to selected city as loading the stations you will see a skeleton view as skeleton view appears you will not be able to touch the stations. You can see station values that are fetched from API like distance, charge type, number of available sockets and station name in this page. Also in this page you can use a custom searchText field to search stations by theirs name. If User allowed the location permission the distance values will be appears and the stations will be sorted according to that value, if not allowed that value will not be shown and sorted by the received order from the API. also with the label made the city name bold and showed the number of the stations. This page supports swipe to back page option.

## Station Selection Page Skeleton View
<img src="https://user-images.githubusercontent.com/44535117/179397379-03975fab-abe7-4bff-a441-a1177b5a7dc4.gif" height="300" width="250" >

## Station Selection View ScreenShots
<img width="330" alt="Screenshot 2022-07-17 at 08 54 50 PM" src="https://user-images.githubusercontent.com/44535117/179418605-b7b361d9-6e40-4e1d-8f67-7b6f261d541c.png"> <img width="339" alt="Screenshot 2022-07-17 at 08 55 12 PM" src="https://user-images.githubusercontent.com/44535117/179418611-b2941d7c-bcfe-4021-a298-b19586bc20d9.png"> <img width="334" alt="Screenshot 2022-07-17 at 08 55 20 PM" src="https://user-images.githubusercontent.com/44535117/179418616-6a35f2ff-a543-42e0-9fe5-0bea0ab0553c.png">

<img width="330" alt="Screenshot 2022-07-17 at 08 55 02 PM" src="https://user-images.githubusercontent.com/44535117/179418632-8ab3d8a4-c60a-4c28-8986-a31c5b6f40fb.png"> <img width="339" alt="Screenshot 2022-07-17 at 08 55 31 PM" src="https://user-images.githubusercontent.com/44535117/179418654-d000cfd5-77b9-44d7-9cca-6203897d11e9.png"> <img width="334" alt="Screenshot 2022-07-17 at 08 55 37 PM" src="https://user-images.githubusercontent.com/44535117/179418659-18a7acf5-78c9-4b4c-b263-fe4328cbba19.png">

City with No Station View:

<img width="320" alt="Screenshot 2022-07-17 at 09 00 29 PM" src="https://user-images.githubusercontent.com/44535117/179418778-795afb15-72c4-4d36-a828-7cafc1b0da5c.png"> <img width="330" alt="Screenshot 2022-07-17 at 08 55 56 PM" src="https://user-images.githubusercontent.com/44535117/179418679-c76fa3ac-a055-4da6-a8bb-516e33c59ea0.png">

Station without location value:

<img width="332" alt="Screenshot 2022-07-17 at 09 03 42 PM" src="https://user-images.githubusercontent.com/44535117/179418927-c48e75cb-7d7e-41ca-9758-8ad2a4d244a1.png">



# Filter Selection Page
We reach this page via using the filter icon that is on the right navigation bar button item in stations page. We can select multiple filters in this page all of the buttons and titles are localized in this page. Also we need to press filter button to activate selected filters in our stations page if not the stations will not be filtered. If we presss clear button the filters will be cleared and after this when we press the filter button the filters will be cleared in the station page. After pressing filter button if there is any filter value the right bar button item in the station page will be green color and we will see the filter options in the stations page (inside the collectionview) also we can alter the filters via cancel button that is inside the filter buttons if we remove all of the filters from the station page the right bar filter button's color will be reset and when we return from our station page to filtering page the changed filters will be affected here as well I mean deleted filters button will be deactivated. Also for the searching by station name in the stations will be doing inside the filtered stations only. This page supports swipe to back page option.

## Filter Selection Page ScreenShots
<img width="315" alt="Screenshot 2022-07-17 at 09 16 08 PM" src="https://user-images.githubusercontent.com/44535117/179419344-f0eb7b52-1450-4a6b-bd98-4a4e78676fc7.png"> <img width="332" alt="Screenshot 2022-07-17 at 09 17 21 PM" src="https://user-images.githubusercontent.com/44535117/179419352-1e3b152f-161f-47e5-994f-7195316cd8c9.png">


<img width="335" alt="Screenshot 2022-07-17 at 09 10 57 PM" src="https://user-images.githubusercontent.com/44535117/179419163-4cdc31d1-d150-42da-8cca-26e95e7cd6eb.png"> <img width="342" alt="Screenshot 2022-07-17 at 09 11 43 PM" src="https://user-images.githubusercontent.com/44535117/179419187-0c1bccb4-f951-4949-b503-f5e9435fd139.png">

<img width="319" alt="Screenshot 2022-07-17 at 09 13 21 PM" src="https://user-images.githubusercontent.com/44535117/179419242-e9742cd9-120f-4b15-9df8-35c77a6542ff.png"> <img width="331" alt="Screenshot 2022-07-17 at 09 12 27 PM" src="https://user-images.githubusercontent.com/44535117/179419252-25123700-4154-452e-bcb6-1863729b174b.png">



# Date and Time Selection Page
We reach this page after selecting a station from the stations page. In the date picker the today's date will be selected. Date Picker will be independent from the appearance of the phone it will always have black background and white texts. Also in the date picker you are not allowed to selected later than 2022-12-31 (Even it is shown in the Datepicker, the later date after the maximum dates are disabled inside the datepicker.). Everytime when user select a new date from the date picker the sockets will be reloaded and the number of the sockets will be checked, according to that we will implement that view (The station may close socket 3 in the following date). The socket table's widths will be changed according to the width of the screen if there is only one socket it will completely cover the screen width if there are two sockets half of the screen otherwise each of them will be cover 30% of the screen if we select a old date or older time than now there will be custom popup and block to proceed next page from this page. We can choose the option "select today" via this option the date picker values will automatically set to today date. Also if the time slot is appointed before, it will be disabled. So user is not able to select that time. You can only select one socket and one time.  If the user has not been selected any time socket the confirm time and date button will be deactivated. This page supports swipe to back page option.

## Date and Time Selection ScreenShots
<img width="332" alt="Screenshot 2022-07-17 at 09 24 57 PM" src="https://user-images.githubusercontent.com/44535117/179419605-c85bfd87-ee82-4202-a97c-cad8395d0e4e.png"> <img width="330" alt="Screenshot 2022-07-17 at 09 23 13 PM" src="https://user-images.githubusercontent.com/44535117/179419609-640be711-485d-4b13-b267-608c69938fd4.png"> <img width="326" alt="Screenshot 2022-07-17 at 09 25 21 PM" src="https://user-images.githubusercontent.com/44535117/179419615-6515906a-4f96-49a4-8649-193230cef0e0.png">

Time Selection

<img width="346" alt="Screenshot 2022-07-17 at 09 38 53 PM" src="https://user-images.githubusercontent.com/44535117/179420140-e8dfaf4a-1ba9-4eda-92dd-8315b861e3be.png"> <img width="324" alt="Screenshot 2022-07-17 at 09 38 37 PM" src="https://user-images.githubusercontent.com/44535117/179420148-fd3e5ba7-ffaa-4a28-9a30-3d134a3b8403.png"> <img width="329" alt="Screenshot 2022-07-17 at 09 39 01 PM" src="https://user-images.githubusercontent.com/44535117/179420152-c2758f6d-2e71-4359-9f25-3c62ad46c8c6.png">


Date Picker

<img width="325" alt="Screenshot 2022-07-17 at 09 29 32 PM" src="https://user-images.githubusercontent.com/44535117/179419770-cff3a345-9476-44d5-a2f7-90cb67260f85.png"> <img width="330" alt="Screenshot 2022-07-17 at 09 27 27 PM" src="https://user-images.githubusercontent.com/44535117/179419704-d270b4f7-04eb-4d5c-9fe4-77cf4e9ea145.png">


Old Date Error

<img width="330" alt="Screenshot 2022-07-17 at 09 35 02 PM" src="https://user-images.githubusercontent.com/44535117/179419984-25054564-b93e-4650-8886-fe1fd30ff628.png"> <img width="336" alt="Screenshot 2022-07-17 at 09 35 07 PM" src="https://user-images.githubusercontent.com/44535117/179419991-ab6ca980-27fb-45c8-8dd6-d9c81d0bcc1c.png">




# Make Appointment Page
We reach this page after successfully processed from the date and time selection page. In this page we will able to see selected appointment infos.If the user not allowed the location permission distance cell will not be shown. In the last cell we can see get notified switch (its state is holded so when it gets redrawed it state will be the same) if we switch on this toggler we can ask to receive local notification from the app. After switching on  we can see a cell appears that we can select and open a picker view "that picker selection also independent from appearance of the phone" the time when we want to receive notification.( You don't have to select receive notification option) After selecting this options and pressed confirm appointment button the app will check if the user allowed notifications and remaining time for the notification according to time choice. If there is any error about notification set there will be custom error pop up this will only occurred when reeive notification switch turned on. If Notification not allowed we will show user an error popup. If there is not enough time to show notification it will show that error in the custom error popup. If everything goes successfully the required infos(date, time, stationId, socketId, notificationIdentifier, notificationtimeselection) (Actually there is an API bug here if it should have returned the appointmentID here we could only save that data and UserID inside our coreData ) will be saved in our coreData. NotificationIdentifier will be create uniquely so if we want to remove the appointment we can remove the notification using this notificationIdentifier. The notification subtitle and title set as localized string. After this page successfully processed the Appointments page will be loaded. The coreData saving process will be only implemented when user selected receive notification option. This coreData will be used to receive notification identifier and notification timer in our Appointments page. This page supports swipe to back page option.

## Make Appointment ScreenShots

<img width="337" alt="Screenshot 2022-07-17 at 09 55 08 PM" src="https://user-images.githubusercontent.com/44535117/179420739-a436791d-7f60-4343-91f5-ad5e16e920d0.png"> <img width="338" alt="Screenshot 2022-07-17 at 09 55 22 PM" src="https://user-images.githubusercontent.com/44535117/179420740-4e629fd8-c95e-4a2a-9a05-e8b803ae15d1.png">

<img width="339" alt="Screenshot 2022-07-17 at 09 55 52 PM" src="https://user-images.githubusercontent.com/44535117/179420743-aa229ee4-e404-40c8-93aa-4bdb40456521.png"> <img width="343" alt="Screenshot 2022-07-17 at 09 56 01 PM" src="https://user-images.githubusercontent.com/44535117/179420741-f9ecd455-4d00-4c49-b2c3-8de812ba2045.png">


<img width="336" alt="Screenshot 2022-07-17 at 09 56 22 PM" src="https://user-images.githubusercontent.com/44535117/179420754-d96a2efa-5932-41d2-850e-aae4d91688e1.png"> <img width="345" alt="Screenshot 2022-07-17 at 09 56 28 PM" src="https://user-images.githubusercontent.com/44535117/179420755-e897541b-d122-47b0-a2a5-0836f8f14d8a.png">

<img width="338" alt="Screenshot 2022-07-17 at 09 56 34 PM" src="https://user-images.githubusercontent.com/44535117/179420757-3d8006f2-82ae-4a30-94b3-259e38285d21.png"> <img width="332" alt="Screenshot 2022-07-17 at 09 56 41 PM" src="https://user-images.githubusercontent.com/44535117/179420759-a73761d6-c95f-4f40-8ff9-436f966155aa.png">

Wrong Notification Time Error


<img width="341" alt="Screenshot 2022-07-17 at 10 04 25 PM" src="https://user-images.githubusercontent.com/44535117/179421381-723c5956-6469-4d46-b39d-47a5739e0171.png"> <img width="339" alt="Screenshot 2022-07-17 at 10 04 30 PM" src="https://user-images.githubusercontent.com/44535117/179421385-1e8b6e96-9e4b-4aa7-838d-5ef8bc4ca080.png">



# Appointments Page (Non-Empty State)
In this page we will see the created appointments that are divided into 2 different parts as current and past appointments. This page supports pull to refresh action. You can only delete appointments from the current parts as the deletion button of the appointments only appear in the current appointments page. Also in the current appointment part you can see if there is any notification set for that specific appointment if there is no notification for that appointment this timer will be hidden and show the power label instead of the notification time. This notification time values received from our Coredata model so even after closing the app this values will persist. If the user wants to delete any appointment there will be custom popup appeared in the screen that has localized text. If the user confirm deletion of the appointment the appointment will be deleted, datas will be reloaded and the notification will be cancelled. Only 10 current appointments allowed. If you have 10 current appointments and press create appointment button you will see a custom error popup.

## Appointments Page (Non-Empty State) ScreenShots
<img width="329" alt="Screenshot 2022-07-17 at 10 25 27 PM" src="https://user-images.githubusercontent.com/44535117/179421799-c8a3ed3f-a30d-42e3-b314-f3e2c7492212.png"> <img width="336" alt="Screenshot 2022-07-17 at 10 25 43 PM" src="https://user-images.githubusercontent.com/44535117/179421803-86b2435a-70ba-4039-b5e1-58d846b4e19b.png"> <img width="336" alt="Screenshot 2022-07-17 at 10 28 05 PM" src="https://user-images.githubusercontent.com/44535117/179421808-86c30b85-f9b3-491b-a437-69b3e3e92e0a.png">

<img width="336" alt="Screenshot 2022-07-17 at 10 27 19 PM" src="https://user-images.githubusercontent.com/44535117/179421817-4cbb5d94-85a7-45e7-873d-ad46298f92c5.png"> <img width="334" alt="Screenshot 2022-07-17 at 10 27 25 PM" src="https://user-images.githubusercontent.com/44535117/179421819-6d0b30d9-2993-4efd-9856-2d495bab8880.png"> <img width="330" alt="Screenshot 2022-07-17 at 10 27 41 PM" src="https://user-images.githubusercontent.com/44535117/179421825-b740982f-8eed-412b-bfa2-c04c334ca894.png">



## Notification

![notificationeng](https://user-images.githubusercontent.com/44535117/179405313-9a77006d-5dad-48ef-80f9-ea9ea0c3fe11.png)
![notificationtrk](https://user-images.githubusercontent.com/44535117/179405316-23c7abcc-b086-4fd1-9b80-d7aeb9c49d54.png)

## Screen Recording


https://user-images.githubusercontent.com/44535117/199670390-3c62ba79-6bf3-43dd-a696-118a601d0a07.mp4



## Small Screen ScreenShots

<img width="304" alt="Screenshot 2022-07-17 at 10 32 13 PM" src="https://user-images.githubusercontent.com/44535117/179421996-55e73797-a775-4208-9cd3-62d88c7c0581.png"> <img width="299" alt="Screenshot 2022-07-17 at 10 32 31 PM" src="https://user-images.githubusercontent.com/44535117/179422008-9f9c4dbb-3b63-4fcb-8246-7910407db938.png"> <img width="294" alt="Screenshot 2022-07-17 at 10 32 45 PM" src="https://user-images.githubusercontent.com/44535117/179422013-217f6d24-9b12-4da9-a4e5-f9a0ca6f2571.png">
<img width="306" alt="Screenshot 2022-07-17 at 10 32 55 PM" src="https://user-images.githubusercontent.com/44535117/179422016-a86d90d1-d17f-49d4-9e39-e69e1a3afc4a.png"> <img width="300" alt="Screenshot 2022-07-17 at 10 33 07 PM" src="https://user-images.githubusercontent.com/44535117/179422022-03374865-cade-4b1c-943c-48c05e05ba22.png"> <img width="306" alt="Screenshot 2022-07-17 at 10 33 13 PM" src="https://user-images.githubusercontent.com/44535117/179422028-2bff2ffa-b5ce-41f2-a47a-af4b813537de.png">

<img width="305" alt="Screenshot 2022-07-17 at 10 33 34 PM" src="https://user-images.githubusercontent.com/44535117/179422038-8269f1be-b930-4e00-9fa8-925784449e7e.png"> <img width="315" alt="Screenshot 2022-07-17 at 10 33 49 PM" src="https://user-images.githubusercontent.com/44535117/179422041-44022996-86af-4a3b-ad22-6154f9019877.png">
