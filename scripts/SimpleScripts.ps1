$process = "notepad"
Get-Process -name $Process -erroraction silentlycontinue | 
Stop-Process -passthru |  
ForEach-Object { $_.name + ' with process ID: ' +  $_.ID + ' was stopped.'}


While

$i = 0 
$fileContents = Get-Content -path C:\fso\testfile.txt
While ( $i -le $fileContents.length )  
{   $fileContents[$i]   $i++  }

Simpele Do loop

i = 0 
ary = Array(1,2,3,4,5) 
Do While i < 5  
WScript.Echo ary(i)  
i = i + 1 
Loop

Simpele For Each

ary = Array(1,2,3,4,5) 
For Each i In ary  
If i = 3 Then Exit For 
WScript.Echo i 
Next 
WScript.Echo "Statement following Next"

Eigen functies maken

Function Get-Doc($path) 
{ 
Get-ChildItem -Path $path -include *.doc,*.docx,*.dot -recurse 
} #end Get-Doc  

Filter LargeFiles($size)
{   
$_ |   
Where-Object { $_.length -ge $size } 
} #end LargeFiles 






