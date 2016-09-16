HTTPListener is a simple web service written in Powershell that executes Powershell commands. 
Be careful when running the this service, authentication has been disable so anyone could execute 
commands in the machine running the server. This server should only be used for testing purposes.



HOW TO INSTALL
Copy all files under the VistaPricingPlatform.PricingEngine.AcceptanceTests\HttpListener directory to 
	\\Server\Your_user\Documents\WindowsPowerShell\Modules\HTTPListener
for example
	C:\Users\Administrator\Documents\WindowsPowerShell\Modules\HTTPListener

	
	
HOW TO RUN
In a powershell console type:
	$> Import-Module HTTPListener
	$> Start-HTTPListener -Verbose
The server listens on port 8888
	

	
HOW TO EXECUTE COMMANDS
From a different powershell console 
	$> Invoke-RestMethod -Uri 'http://your_server:8888/?command={your command}'
for example
	$> Invoke-RestMethod -Uri 'http://localhost:8888/?command=iisreset'
	
	
	
HOW TO EXIT
From a different powershell console 
	$> Invoke-RestMethod -Uri 'http://your_server:8888/?command=exit'
for example
	$> Invoke-RestMethod -Uri 'http://localhost:8888/?command=exit'
