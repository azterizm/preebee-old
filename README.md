
## Overview

**Eros (inspired by Daraz)** is a comprehensive ERP (Enterprise Resource Planning) system designed to cater to various business needs through a suite of interconnected applications. Eros offers different URLs for distinct audiences, providing tailored access and management capabilities. Whether you're a buyer, seller, business owner, or delivery rider, Eros has a dedicated app to streamline your experience.

### Applications in Eros

1. **Marketplace:** The core of the Eros system, this app allows customers to browse and purchase products effortlessly.
2. **Seller Dashboard:** A dedicated portal for sellers to manage their products, inventory, and analytics.
3. **Owner Dashboard:** Provides root-level management, including audience management and seller verification.
4. **Rider Dashboard:** Enables individuals to sign up for delivery jobs and earn money by completing deliveries.

## Key Features

- **Modular System:** Separate URLs and apps for different users, ensuring a focused and efficient user experience.
- **Comprehensive Management:** From product listing to inventory control and order fulfillment, manage every aspect of your business.
- **Role-Based Access:** Each application is tailored to the needs of specific user groups, such as buyers, sellers, owners, and riders.
- **Advanced Analytics:** Gain insights into sales performance, stock levels, and more through the Seller Dashboard.
- **Flexible Delivery Options:** Riders can easily sign up and start earning by delivering orders.

## Technology Stack

Eros is built using a robust and modern technology stack to ensure performance, scalability, and a seamless user experience:

- **KitaJS**
- **HTMX**
- **AlpineJS**
- **FastifyJS**
- **DaisyUI**
- **RemixJS**

# Getting Started

## Setup Google App

Setting up Google authentication in an app involves several steps. Here's a step-by-step guide:

### Step 1: Create a Project on Google Cloud Console
1. **Go to the Google Cloud Console:**
   - Navigate to [Google Cloud Console](https://console.cloud.google.com/).
   - Sign in with your Google account.

2. **Create a New Project:**
   - Click on the project dropdown at the top.
   - Click on "New Project."
   - Give your project a name and click "Create."

3. **Enable the Google Identity API:**
   - Once your project is created, go to the "APIs & Services" section.
   - Click on "Library."
   - Search for "Google Identity Platform" or "OAuth 2.0 API" and click on it.
   - Click "Enable" to enable the API for your project.

### Step 2: Configure OAuth Consent Screen
1. **Navigate to the OAuth Consent Screen:**
   - Go to "APIs & Services" > "OAuth consent screen."
   - Choose whether your app is for internal (only available to your organization) or external (available to anyone) use.

2. **Configure the Consent Screen:**
   - Fill in the required fields, like App Name, User Support Email, and Developer Contact Information.
   - Add the required scopes if needed (you can start with basic scopes).
   - Save your changes.

### Step 3: Create OAuth 2.0 Credentials
1. **Create Credentials:**
   - Go to "APIs & Services" > "Credentials."
   - Click on "Create Credentials" and select "OAuth 2.0 Client IDs."

2. **Set Up the OAuth Client ID:**
   - Choose "Web application" as the Application Type.
   - Provide a name for the client ID (e.g., "My App Google Auth").
   - Add the appropriate **Authorized Redirect URIs** (e.g., `http://localhost:3000/auth/google/callback` if you're testing locally).

3. **Generate the Client ID and Client Secret:**
   - Once you’ve added the details, click "Create."
   - Google will provide you with a `CLIENT_ID` and `CLIENT_SECRET`.



## Setup Database

To set up a MySQL database in your app with the provided environment variable format (`DATABASE_URL`), follow these steps:

### Step 1: Install MySQL

1. **Install MySQL Server:**
   - On **Ubuntu/Linux**:
     ```bash
     sudo apt update
     sudo apt install mysql-server
     ```
   - On **macOS** (using Homebrew):
     ```bash
     brew install mysql
     ```
   - On **Windows**:
     - Download the MySQL installer from the [official MySQL website](https://dev.mysql.com/downloads/installer/).
     - Run the installer and follow the instructions to set up MySQL.

2. **Start MySQL Service:**
   - On **Ubuntu/Linux**:
     ```bash
     sudo systemctl start mysql
     ```
   - On **macOS**:
     ```bash
     brew services start mysql
     ```
   - On **Windows**, the MySQL service should start automatically after installation. If not, start it via the Services app.

### Step 2: Secure MySQL Installation

1. **Run the Secure Installation Script:**
   - This step is important to set a root password and secure your MySQL installation.
   - On **Ubuntu/Linux** and **macOS**:
     ```bash
     sudo mysql_secure_installation
     ```
   - On **Windows**, you can find the `mysql_secure_installation` command in the MySQL bin directory.

2. **Follow the prompts:**
   - Set a root password.
   - Remove anonymous users.
   - Disallow root login remotely.
   - Remove test databases.
   - Reload privilege tables.

### Step 3: Create a MySQL User and Database

1. **Log in to MySQL as Root:**
   ```bash
   mysql -u root -p
   ```
   - Enter the root password you set during the secure installation.

2. **Create a New Database:**
   ```sql
   CREATE DATABASE preebee;
   ```

3. **Create a New MySQL User:**
   ```sql
   CREATE USER 'abdiel'@'localhost' IDENTIFIED BY '0300';
   ```

4. **Grant Privileges to the User:**
   ```sql
   GRANT ALL PRIVILEGES ON preebee.* TO 'abdiel'@'localhost';
   ```

5. **Flush Privileges:**
   ```sql
   FLUSH PRIVILEGES;
   ```

6. **Exit MySQL:**
   ```sql
   EXIT;
   ```

## Setup Application

1. Clone
```bash
git clone https://github.com/azterizm/preebee-old eros-erp
cd eros-erp
git clone https://github.com/azterizm/preebee-beth marketplace
git clone https://github.com/azterizm/preebee-seller seller-dashboard
git clone https://github.com/azterizm/preebee-rider rider-dashboard
git clone https://github.com/azterizm/preebee-owner owner-dashboard
```

2. Install
```bash
npm i
cd marketplace
npm i
cd ../seller-dashboard
npm i
cd ../rider-dashboard
npm i
cd ../owner-dashboard
npm i
cd ..
```

3. copy `.env.example` to `.env` and setup database url if required (not required if database was setup from above instructions)
4. open marketplace folder and setup env
```
SESSION_SECRET='<random_string>'
GOOGLE_CLIENT_ID='<provide your google id here>'
GOOGLE_CLIENT_SECRET='<provide your google secret here>'
GOOGLE_CALLBACK_URL='http://localhost:5002/auth/google/callback'
```
5. open seller-dashboard folder and setup env the same way
6. same for rider-dashbord and owner-dashboard
7. setup database `npx prisma db push`
8. start apps by navigating to that folder and running `npm run dev`. Each app runnning will show port number. For example 5002 port signifies app running at `http://localhost:5002`.

## Contribution

Contributions to Eros are welcome! If you have improvements, features, or bug fixes, please fork the repository and submit a pull request. Follow the contribution guidelines to ensure consistency.

## Contact

For inquiries, support, or feedback, please reach out or open an issue on the GitHub repository.
