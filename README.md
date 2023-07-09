## Assignment From ITmedicus Solutions

This documentation provides an overview of the completed project for **ITmedicus Solutions**, including the implementation details and features. 

## Quick look

![]((https://github.com/eshromanch/ITmedicus-Solutions/blob/main/ezgif.com-video-to-gif.gif))

## Installation and Usage

1. Clone the Repository: Clone the project repository from the GitHub repository using the following command:

   ```
   git clone https://github.com/eshromanch/ITmedicus-Solutions.git
   ```

2. Navigate to Project Directory: Change the current directory to the project directory using the following command:

   ```
   cd
   ```

3. Install Dependencies: Run the following command to install the project dependencies:

   ```
   flutter pub get
   ```

4. Run the Application: Use the following command to run the application on an emulator or connected device:

   ```
   flutter run
   ```

### App overview

The app has two screens:

- The home screen displays a carousel slider of images.
- The search screen allows users to search for images by title, subtitle, or date.

### Home screen

The home screen displays a carousel slider of images. The images are stored in a database, and the app loads the images from the database when the app starts. The user can swipe left or right to view the next or previous image.

### Search screen

The search screen allows users to search for images by title, subtitle, or date. The user can enter a search term in the search bar, and the app will display a list of images that match the search term. The user can tap on an image to view it in full screen.

### Testing

The app has been tested on the following devices:

- Pixel 4 
- Realme c25s

### Important Note: Internet Connectivity

To ensure proper functionality of the application, it's crucial to have an active internet connection. The application retrieves images for the sliding banner and product list from the provided URLs. Without internet connectivity, the images may not load correctly, impacting the overall user experience.
