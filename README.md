# comp_group15
LINUX SYSTEM ADMINISTRATION DASHBOARD Group 15 Final Project Report 
Team Members: 
Tolulope Ogunbiyi (2024/13720) - Project Lead 
Popoola Abdulroqeeb D. (2024/13198) - Contributor 
Ikegwuonu Promise Chukwuemelie (2024/13734) - Contributor 
Dada Oluwasemilore Joseph (2024/13672) - Contributor 
Olaoluwakitan Lawal (2024/13636) - Contributor

Project Overview 
The Admin Dashboard project is a secure, modular, Linux-based system administration tool designed 
for managing core system operations directly from a terminal interface. The dashboard includes 
authentication, logging, error handling, and a menu-based navigation structure. Users must log in with 
system credentials before accessing any administrative functionality. 
The dashboard is designed with modular scripts for each subsystem, promoting reusability, testing, 
and maintenance. All sensitive operations are logged for auditing purposes. 
Core technologies used include Bash scripting, Linux utilities, process/service/user/network 
management tools, and standard log/backup mechanisms. 
Key Features 
- Secure authentication using system usernames 
- Modular scripts for each administrative task - Input validation and error handling 
- Centralized logging system 
- Backup and restore functionality 
- Real-time log monitoring and system update tools 
Modules Implemented 
1. System Information 2. Process Management 
3. Service Management 
4. User Management 
5. Network Information 6. Log Analysis 
7. Backup Utility 
8. System Update

Utilities 
- helpers.sh for input validation - logger.sh for action/error logging 
Folder Structure comp_group15/ 
    admin_dashboard.sh 
    modules/ 
        system_info.sh 
        process_management.sh         service_management.sh 
        user_management.sh 
        network_info.sh 
        log_management.sh         backup_management.sh 
        update_management.sh 
    utils/ 
        helpers.sh         logger.sh 
    logs/ 
    backups/ 
How to Run 
$ cd comp_group15 $ sudo ./admin_dashboard.sh 
Future Improvements 
- Authorization  
- Remote log syncing 
