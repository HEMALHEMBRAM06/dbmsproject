# TourismDB - Tourism Management Database

## Overview
TourismDB is a MySQL-based database system for managing a tourism platform. It includes functionalities to store and manage data related to users, destinations, hotels, packages, and feedback. This system supports a wide variety of use cases for a tourism website, including managing hotels, destinations, feedback, and travel packages.

## Features
- **Users Table**: Stores information about the users, including their name, email, and password.
- **Destinations Table**: Stores details about travel destinations, including their name, location, and description.
- **Hotels Table**: Stores information about hotels available at each destination.
- **Packages Table**: Stores various travel packages available at different destinations.
- **Feedback Table**: Stores user feedback for destinations with ratings and comments.

## Database Schema

### Tables
- **Users**: Stores information about the users (name, email, password).
- **Destinations**: Stores details of travel destinations (name, location, description).
- **Hotels**: Stores details about hotels available at different destinations.
- **Packages**: Stores information about travel packages.
- **Feedback**: Stores user feedback on destinations, with ratings and comments.

### SQL Queries
The project includes several SQL queries for data retrieval, including:
1. Listing all users who gave feedback with a rating of 5.
2. Displaying destinations with more than one hotel.
3. Calculating average hotel ratings for each destination.
4. Sorting travel packages by price.
5. Counting feedbacks for each destination.

## Installation

To set up the database on your local system:

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/TourismDB.git
   cd TourismDB
