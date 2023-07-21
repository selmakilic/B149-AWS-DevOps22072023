# Remove Previous Role
## Remove File Server

- Go to Server Manager on FS01 machine
- Click Manage
- click Remove Roles and Features
- Select role-basad ...
- select a server from server pool ... fs01
- from server roles deselect files server and file server manager
- click next
- click remove

# Install Web Server (IIS)
## Install Internet Information Services

- Go to Server Manager on FS01 machine
- Click Manage
- click Add Roles and Features
- Select role-basad ...
- select a server from server pool ... fs01
- from server roles select Web Server (IIS)
- select features and Add
- click Install

## Configure IIS

* prepare a simple web page
- Use File Explorer to browse drive C: and find folder inetpub/wwwroot
- inside wwwroot folder create a textfile by right clicking
- double click the file
- type the following in the file:

```html
<html>
<body>
<h1>This is our simple page</h1>
<h3>Batch146 149</h3>
<body>
</html>
```
- click save as
- file name: index.html
- save as type: All Files
- Encoding: Unicode
- click Save to save the file


* configure web server
- Open Server Manager
- click Tools
- click Internet Information Services (IIS) Manager
- on Connections pane on the left click FS01 to expand
- right click on Sites and click Add Website
- site name: mysite
- physical path: browse to c:\inetpob\wwwroot
- leave other settings default (type: http, port: 80)
- Click Ok
- Click on Defaul Web Site and on the Actions pane on the right click Stop
- click on mysite and click start on the right side
- click Browse *:80 (http) to view your web page in the Internet Explorer window
