#!/bin/bash

# Simple Bash Script to configure the sqlite database
# NOTE: sqlite3 does not have a datatype for booleans. We're using INT with (0,1) allowed instead

dbPath="./system.db"		# Script assumes the db file is in your CWD
dbPath="$(realpath $dbPath)"	# Find full path to db file


# Make sure db file exists
if ! [ -f $dbPath ]; then
	echo "Could not find $dbPath"
	exit 1
fi

# Make sure sqlite3 is installed so we can avoid errors
if ! [ $(which sqlite3) ]; then 
	echo "Please install sqlite"
	exit 1
fi

# Create the daemons table
sqlite3 $dbPath "CREATE TABLE IF NOT EXISTS daemons (daemon_id INT PRIMARY KEY NOT NULL, daemon_name VARCHAR(100), daemon_provided_by_rpm VARCHAR(255), daemon_run_as_use VARCHAR(50), daemon_enabled INT(0,1), daemon_running INT(0,1) );"

# Create the rpms table
sqlite3 $dbPath "CREATE TABLE IF NOT EXISTS rpms (rpm_id INT PRIMARY KEY NOT NULL, rpm_name VARCHAR(255), rpm_version VARCHAR(100), repo_installed_from VARCHAR(50) );"

# Create the repos table
sqlite3 $dbPath "CREATE TABLE IF NOT EXISTS repos (repo_int_id INT PRIMARY KEY NOT NULL, rpm_name_id VARCHAR(50), repo_file VARCHAR(255), repo_enabled INT(0,1) );"

# Create the users table
sqlite3 $dbPath "CREATE TABLE IF NOT EXISTS users (user_id INT PRIMARY KEY NOT NULL, user_name VARCHAR(50), user_shell VARCHAR(255), user_groups VARCHAR(255), user_home VARCHAR(255), encrypted_passwd VARCHAR(255), group_id INT, full_name VARCHAR(255)  );"

# Create the selinux table
sqlite3 $dbPath "CREATE TABLE IF NOT EXISTS selinux (id INT PRIMARY KEY NOT NULL, is_enforcing INT(0,1), is_enabled INT(0,1), is_targeted INT(0,1) );"

