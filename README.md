# windows-otp-logon
This script is a custom workaround to have OTP implementation for your Windows device. It changes the password on every new logon and sends it to a custom email. Please note this is designed for use on devices which you have admin privileges to.

## Features

- Checks for connection with smtp server before execution.
- Generates a random 16-character password using secure methods.
- Automatically updates the password for a specified user account.
- Easily integrates into Windows Task Scheduler for automated execution.


## Usage
- Download or clone this repository to your local system.
- Place the script (change-pass.ps1) in a secure directory, ensuring only authorized users have access.
- Open the script in a text editor.
- Replace the placeholders in the file e.g. the $username variable with the username of the account whose password will be changed.
- Run the script manually using PowerShell:

```bash
powershell.exe -File "C:\Path\To\change-pass.ps1"
```
    
## Automating Execution on Logon

To configure the script to run automatically during each system logon, we will be using the Windows Task Scheduler:


### Steps to Set Up Task Scheduler
Open Task Scheduler:
    
    Press Win + S, type Task Scheduler, and open it with admin rights.

Create a New Task:

    Click Action > Create Task.

General Tab:

    Enter a name for the task (e.g., Run PowerShell Script).
    Check Run with highest privileges.
    Check Run only when user is logged on.
    Select the appropriate operating system in the Configure for dropdown.

Triggers Tab:

    Click New.
    Set the trigger to At log on and click OK.

Actions Tab:

    Click New.
    In the Action dropdown, select Start a program.
    In the Program/script field, type: powershell.exe
    In the Add arguments field, type: -WindowStyle Hidden -File "C:\Path\To\change-pass.ps1"
    
    Replace C:\Path\To\change-pass.ps1 with the full path to your script.

Conditions and Settings Tab:

    Adjust settings as needed, e.g., uncheck Start the task only if the computer is on AC power for laptops.

Save and Test:

Click OK to save the task.

    To test, right-click the task and select Run.
## Troubleshooting
#### Script fails to execute: 
- Ensure the script path is correct in Task Scheduler. Verify the user account running the task has the necessary permissions.

#### Password not updating:

- Check that all the custom variables are correctly defined. 
- Make sure the user exists by running the 'net user' command and checking the list of users in the system.
- Make sure SMPT credentials are correct.

#### Task does not trigger:

- Confirm that the task is correctly configured to run at startup and enabled.
