#$hostsname = "192.168.217.216"
#$p="Wipro@123"
#$u="Administrator"
# Encrypting Password
#$pw = convertto-securestring $p -AsPlainText -Force 
# Getting remote session 
#$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist #"$u",$pw
#$sessions = new-pssession -computername ${hostsname} -credential $cred  

#Invoke-Command -Session $sessions -ScriptBlock{

Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>VMInfo:`</p`>`</b`>
Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>VMname:LocalHost`</p`>`</b`>
#Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>CPU_Count:${vCPU}`</p`>`</b`>
#Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>Memory:${vmMemorySize}`</p`>`</b`>
Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>Logs:`</p`>`</b`>
Add-Content -Path "C:\powershell Scripts\powershell.txt" -value `<p`>------------------------------------------------------------------------------------------------------------------------------`</p`>
for($i=10; $i -gt 0; $i--){

$threshold = "90"
$proc = get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 10 -ComputerName "Localhost"
$proc = get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName "Localhost"
$cpu = ($proc.readings -split ":")[-1]
$cpuint=[int]$cpu
$datetime = get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName "Localhost" | Select-Object timestamp
If($cpuint -gt $threshold)
{
        Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<p`>$datetime" "[WARN]" "Processor" "Threshold" "above" "$threshold%" "Current_CPU_utilization=`<b`>$cpu%`</b`>" "waiting" "for" "the" "next" "run" "`</p`>
		
#start Get top 10 Process Percentage
	
		$TopCPUutil = Get-WmiObject Win32_PerfFormattedData_PerfProc_Process | where-object{ $_.Name -ne "_Total" -and $_.Name -ne "Idle"} | Sort-Object PercentProcessorTime -Descending | select -First 10 |  Select Name,IDProcess,PercentProcessorTime
		Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>$datetime`</p`>`</b`>
		Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<b`>`<p`>Top" "CPU" "Utilization" "Processes" "[Info]:`</p`>`</b`>
  	add-content -path "C:\powershell Scripts\powershell.txt" -value $TopCPUutil
		
	
#Stop Get top 10 Process Percentage
    }
 


            If($cpuint -le $threshold)
            {
            Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<p`>$datetime" "[INFO]" "Processor" "Threshold" "below" "$threshold%" "Current_cpu_utilization=`<b`>$cpu%`</b`>" "testing" "stability" "waiting" "for" "the" "next" "run`</p`>
#start Get top 10 Process Percentage

	
#Stop Get top 10 Process Percentage
                 for($i=$i;$i -gt 0;$i--)
                 {
                 for($j=$i+1;$j -gt 0;$j--)
                 {
                   # Write-Host "running inner for loop"
				   $proc = get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 10 -ComputerName "localhost"
                    $proc =get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName "localhost" 
                    $datetime =  get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName "localhost" | Select-Object timestamp
                    $cpu=($proc.readings -split ":")[-1]
                    $cpuint=[int]$cpu 
                            if($cpuint -gt $threshold){break} 
                    Add-Content -Path "C:\powershell Scripts\powershell.txt" -Value `<p`>$datetime" "[INFO]" "Processor" "Threshold" "below" "$threshold%" "Current_cpu_utilization=`<b`>$cpu%`</b`>" "testing" "stability" "waiting" "for" "the" "next" "run`</p`>
#start Get top 10 Process Percentage

	
#Stop Get top 10 Process Percentage
                            if($cpuint -gt $threshold){break}
            } 
            
        if($cpuint -gt $threshold){break}
            
        }             
    }

}
Add-Content -Path "C:\Program Files\procusage_${entityId}.txt" -value `<p`>------------------------------------------------------------------------------------------------------------------------------`</p`>

#Invoke Commands brackets close

#Invoke-Command -session $sessions -ScriptBlock{
$proc =get-counter -Counter "\Processor(_Total)\% Processor Time" -SampleInterval 2 -ComputerName "localhost"    #getting the final value of CPU Utilization.
$cpu=($proc.readings -split ":")[-1]
set-Content -Path "C:\powershell Scripts\powershell.txt" -Value $cpu
#}
#invoke commands brackets close
#Remove-PSSession -Session $sessions
