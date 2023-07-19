# Apply Group Policy
* Applying Group Policy on the entire domain

- Go to File Manager
- Click Tools
- Click Group Policy Management
- Click Forest, then Domains, then techpro.com
- expand techpro.com
- click and expand Group Policy Objects
- find Default Domain Policy and right click on it and then click edit
- Group Policy Management Editor opens
- Under Computer Configuration
- Click Policies
- Click Windows Settings
- Click Security Settings
- Click Account Policies
- Click Account Lockout Policy, there are 3 settings for Account Lockout Policy
- Account lockout duration is in terms of minutes. It is the period of time the user will wait until he can re-enter password
- If this value is set to 0 then only an administrator can unlock it.
- Account lockout treshold is the number of tries before the account is locked.
- When finished close windows
- Open a command prompt and then update policy by gpupdate /force
- Now, on a client machine try entering user password incorrectly 3 times.
- Go to Active Directory Users and Computers
- Check the user account if unlock checkbox appeared.
- Clicking checkbox and pressing OK will unloack the account.

* apply policy to entire domain users

- when the Default Domain Policy is open on Group Policy Management Editor go under User Configuration
- Click Policies
- Click Administrative Templates
- Click Control Panel
- Click Personalization
- Find Screen saver timeout
- Double click
- Click enabled
- Set seconds to 30
- Close windows
- in command prompt type gpupdate /force

* apply a custom policy on specific users of specific OUs

- In Group Policy Management right click on one of regional OUs (Istanbul for example)
- Click Create GPO on this domain
- name New GPO as cmd-ban
- right click on newly created cmd-ban and edit to open Group Policy Management Editor
- Under User Configuration
- click Policies
- Click Administrative Template
- Click system
- Double click Prevent access to command prompt
- Select Enabled
- choose yes to Disable the command prompt script processing question
- Close windows
- in command prompt type gpupdate /force

* apply group policy on computers

let's show a startup message to all users
- first create OU for computers on AD users and computers  
- go to group policy management
- create a gpo
- edit gpo
- go to computer configuration/ Policies/ Windows Settings/ Security Settings/ Local Policies/ Security Options
- scroll down to interactive logon and find logon messages, edit message and title
title: kutlama message: İyi Bayramlar
- go to win10 machine
- open cmd
- gpupdate /force
- logoff
- try logging on as a user and see message