

# Conference Application

EZConference is a conference application that allow users to register to the conference through the mobile application. This project was developed for the Mobile and Ubiquitous Computing - ISB 26603 course at the Universiti Kuala Lumpur.

## License

The source code has been published on GitHub Repository under  _MIT License_.  
Please visit  [`LICENSE`](https://github.com/iamashraff/EZConference-Application/blob/main/LICENSE)  file to read the details about the license.

## About the project

Languages :
- Dart

Framework:
- Flutter

Database:
- SQLite


## Project Requirements

List of specialization available to register :
- Artificial Intelligence
- Data Mining
- Computer Security
- Internet of Things
- Software Engineering

Basic information required for registration purposes:
- Name
- Email
- Phone number
- Role (Participant, Presenter, Reviewer, Judges)

Validation
- User are not allowed to leave input form empty.
- If the form is empty, an alert message will be shown.

User Account
- A new user need to register their username and password.
- Existing user able to login with their existing login credentials.
- Existing user able to view, edit and/or delete their conference registration details.

Database
- Need to have three (3) tables which are `conference_info`, `specialize_area` and `login`.



## Database

<img src="https://raw.githubusercontent.com/iamashraff/Conference-Application/main/img/database2.jpg" width=700>

## Application Flow

<img src="https://raw.githubusercontent.com/iamashraff/Conference-Application/main/img/flowchart2.jpg" width=300>

## Demonstration Video


https://user-images.githubusercontent.com/65198559/218250206-f70d7f5b-a7a0-4c50-9425-9257b8f4a91a.mp4?width=200&height=200

## User Interface

 <img src="https://raw.githubusercontent.com/iamashraff/EZConference-Application/main/img/login.gif" width=250> <img src="https://raw.githubusercontent.com/iamashraff/EZConference-Application/main/img/events.gif" width=250> <img src="https://raw.githubusercontent.com/iamashraff/EZConference-Application/main/img/participate.gif" width=250>

### Notes

By default, when the mobile application is running on the first time it will check either if the database tables named `conference_info`, `specialize_area` and `login` already exists. If some or non of the database table is exists, it will automatically create the database tables in SQLite.

These tables will be created with the following command;

> CREATE TABLE users (<br>
id INTEGER PRIMARY KEY AUTOINCREMENT,<br>
username TEXT NOT NULL,<br>
password TEXT NOT NULL<br>
)<br>

> CREATE TABLE specialize_area (<br>
id INTEGER PRIMARY KEY AUTOINCREMENT,<br>
area TEXT NOT NULL,<br>
description TEXT NULL,<br>
imageUrl TEXT NULL<br>
)<br>

>CREATE TABLE conference_info (<br>
id INTEGER PRIMARY KEY AUTOINCREMENT,<br>
name TEXT NOT NULL,<br>
email TEXT NOT NULL,<br>
phone INTEGER NOT NULL,<br>
role TEXT NOT NULL,<br>
specialize INTEGER NOT NULL,<br>
user INTEGER NOT NULL,<br>
FOREIGN KEY(specialize) REFERENCES specialize_area(id),<br>
FOREIGN KEY(user) REFERENCES users(id)<br>
)<br>

Also, a default user account will be created with the following login credentials;
> ID : 1<br> 
Username : test<br> 
Password : test<br> 

More details can be found in the `DatabaseHelper` class at [`dbhelper.dart`](https://github.com/iamashraff/EZConference-Application/blob/main/lib/services/dbhelper.dart) 

## References

Katz, M., Moore, K. D., Ngo, V., & Guzzi, V. (2021).  _Flutter Apprentice (Second Edition): Learn to Build Cross-Platform Apps_. Razeware LLC.

## Credit

**Developed by :**  
_Muhamad Ashraff Othman_  
© 2022 All rights reserved.
