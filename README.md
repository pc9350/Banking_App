# Monster Rewards 🎮💰

**Monster Rewards** is a cutting-edge iOS banking application that integrates traditional financial management with captivating gaming elements. This app aims to revolutionize personal finance, making it both educational and fun, by encouraging users to interact with their financial accounts through an immersive gaming experience.

## 🌟 Description

Monster Rewards offers a fresh approach to personal banking by combining essential banking functionalities—such as viewing account balances and transferring funds—with a gamified system of experience points (XP) and levels. As users engage in financial activities, they earn rewards and level up, making the routine task of managing finances more interactive and fun.

### 🚀 Features

- **Account Management**: View checking and savings account balances.
- **Fund Transfers**: Utilize features like Zelle for seamless money transfers.
- **Gaming Integration**: Earn XP points and level up by participating in financial activities.
- **Reward System**: Accumulate various rewards, including Capital One miles, Walmart credits, Amazon credits, and Target credits.
- **Interactive User Interface**: Experience a user-friendly interface that turns banking into an engaging game.

## 🛠 Getting Started

### Prerequisites

- Designed for iOS and built with SwiftUI.
- Backend functionalities are simulated in Node.js. (Note: Real banking APIs are not integrated in this version).

### 📲 Installing and Running

1. **Clone the repository**:
   ```bash
   git clone https://github.com/pc9350/Banking_App.git
2. Open the project in **Xcode**.
3. Run the app using the **iOS simulator**.

### Screenshots

![Image of login page](/Assets/login_page)
![Image of landing page](./Assets/landing_page)
![Image of monsters page](./Assets/monsters_page)
![Image of rewards page](./Assets/rewards_page)
![Image of Account page](./Assets/account_page)
![Image of Cards page](./Assets/card_page)

### 💡 Usage
Once you launch Monster Rewards:
- Sign in using the mock credentials:
  - Username: user1@gmail.com
  - Password: password1
- Explore the various banking features available.
- Engage in activities to earn XP and level up.
- Monitor and redeem your rewards as you progress.

- ### 💡 Installing and Running the Backend 
- cd into backend folder
 ``` npm install```
- ### Set up MongoDB Atlas

Create a MongoDB Atlas account (if not already).
Create a cluster and get the connection URI.
Replace the uri variable in the code with your MongoDB Atlas connection URI.

### Start the application
```node app.js```

### Access the API
The application will run on http://localhost:3000 by default.
Use tools like Postman or cURL to interact with the API endpoints.
Example:
- Endpoint: POST /api/account/createRandomAccount
- Request Body:
```json
{
  "name": "John Doe",
  "password": "your-password"
}
```
Change XP
- Endpoint: POST /api/account/changeXP
- Request Body:
```
{
  "accountNumber": "account-number",
  "password": "your-password",
  "xpAmount": 100
}
```
(For full API documentation contact us!)


### 📬 Contact
- Project Link: [Monster Rewards on GitHub](https://github.com/pc9350/Banking_App)

#### Contributors
- **Pranav Chhabra** - pchhabra2@wisc.edu
- **Vibhansh Saini** - vsaini@wisc.edu
- **Mickey Chen** - cchen657@wisc.edu
- **Izzy Bogot** - bogot@wisc.edu
- **Aditya Roy** - roy35@wisc.edu
- **Aslam Mohammad Sayeeduddin** - sayeeduddin@wisc.edu

- ### 👥 Mentors

We are grateful for the guidance and support provided by our mentors from Capital One and our professor at the University of Wisconsin-Madison throughout this project.

#### Capital One Mentors
- Peter Daly
- Garret Huibregtse
- Jillian Genova
- Tyler Luedtke
- Nolan Smith

#### University of Wisconsin-Madison
- Professor Amber Field
