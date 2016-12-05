### 1 Punctuation

Example | Example | Example
----------|------------|-------------------------------------------
*`*(backtick)|It is PowerShell’s escape character. It removes the special meaning of any character that follows it.|c:\Program' Files |
*~*(tilde)|It is used as part of a path, this represents the current user’s home directory.||
*()*(parentheses)|they define an order of execution. they also enclose the parameters of a method.|Get-Service -computerName(Get-Content c:\computernames.txt).|
`[]`(square brackets)|they contain the index number when you want to refer to a single object within an array or collection.| $services[2].|
`{}` (curly brackets)|They contain blocks of executable code, also When a variable name contains spaces or other characters normally illegal in a variable name, braces must surround the name| Get-Service `|` Where-Object { $_.Status -eq 'Running' }. ${My Variable}.| 
' '(single quotation marks)| contain string values. PowerShell doesn’t look for the escape character, nor does it look for variables, inside single.
" "(double quotation marks)| they contain string values.| $two = "Hello $one `n"|
$(dollar sign)| it tells the shell that the following characters, up to the next white space, represent a variable name.||
%(percent sign)|it is an alias for the ForEach-Object cmdlet. It’s also the modulus operator, returning the remainder from a division operation.||
?(question mark)| it is an alias for the Where-Object cmdlet.||
>(right angle bracket)|This is a sort of alias for the Out-File cmdlet.|dir > files.txt.|
`+ - * / %` (math operators)|These function as standard arithmetic operators. Note that + is also used for string concatenation.||
-(dash or hyphen)|This precedes both parameter names and many operators,such as -computerName or -eq. It also separates the verb and noun components of a cmdlet name|Get-Content, -Name|
&(ampersand)|This is PowerShell’s invocation operator, instructing the shell to treat something as a command and to run it.| $a = "Dir", Then & $a will run the Dir command.|
;(semicolon)|This is used to separate two independent PowerShell commands that are included on a single line| Dir ; Get-Process will run Dir and then Get-Process.|
#(hash mark)|This is used as a comment character. Any characters following #, to the next carriage return, are ignored.||
=(equal sign)|This is the assignment operator, used to assign a value to a variable|$one = 1. It isn’t used for quality comparisons; use -eq instead.||
`|`(pipe)|The pipe is used to convey the output of one cmdlet to the input of another. The second cmdlet (the one receiving the output) uses pipeline parameter binding to determine which parameter or parameters will receive the piped-in objects.|Get-Process `|` Get-Member|
\ or /(backslash or forward slash)|either the forward slash or backslash can be used as a path separator in file paths|C:\Windows is the same as C:/Windows.|
.(period)|It’s used to indicate that you want to access a member, such as a property or
method, or an object| $_.Status will access the Status property of whatever
object is in the $_ placeholder|
.(period)|It’s used to dot source a script, meaning that the script will be run within thecurrent scope, and anything defined by that script will remain defined after the script completes: . c:\myscript.ps1|
,(comma)|the comma separates the items in a list or array. It can also be used to pass multiple static values to a parameter that can accept them||
!(exclamation point)|This is an alias for the -not Boolean operator.||

  
### 2 Comparison Operators 
Purpose | Operator | Example
--------|------------|--------------
 Equal, not equal   | -eq, -ne  |
 Greater than, greater than or equal to  | -gt, -ge  |
 Less than, less than or equal to  |-lt, -le  |
 changes the specified elements of a value  | -replace  |

### Handige Commando's
```Powershell
#Toont alles drives op het systeem
gdr -PSProvider 'FileSystem'

#Zet de keyboardlayout naar Azerty
Set-WinUserLanguageList -LanguageList nl-BE
