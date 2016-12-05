
#Windows Powershell
------------------

Net zoals in de culinaire wereld , kunnen we de uitdrukking “less is more” ook
toepassen op de IT-Wereld. System Administrators willen steeds minder zelf doen
maar wel nog dezelfde resultaten bereiken. Dagelijkse taken worden meer en meer
geautomatiseerd. Een van de krachtigste tools die de systeembeheerder hier voor
heeft is Windows Powershell. In windows omgevingen wel te verstaan.

1. Help
-------

help fuctie geeft de omschrijving , syntaxen, parameters, voorbeelden , ... van
een cmdlet, functies, workflows, providers, aliasen en scripts. Help kunt u
gebruiken door “Get-Help” gevolgd door een commando in te geven. \>Get-help
Get-Process.

“Man” en “help” zijn de aliasen die u voor Get-Help kan gebruiken.  
U kunt de help library updaten met het ingeven van de commando.  
\>Update-Help

Met het help cmdlet kunt u ook commandos opzoeken.  
Alle commands die eindigen met “log” in hun naam bevatten:  
\>help \*log

Alle commands zoeken die met “write” beginnen:  
\>help write\*

\-Full parameter toont het volledige help pagina van een commando met de bij
hoorende voorbeelden.  
\>help Get-Process –Full

\-Online parameter zoeken we de online help pagina op om meer informatie.  
\>help Get-Process –Online

\-ShowWindow parameter toont de help pagina in een andere tekst pagina.  
\>help Get-Process – ShowWindow

2. Objects
----------

De data in powershell wordt aan de hand van objecten weergeven. De reden waarom
powershell hiervoor objecten gebruikt is omdat windows en de meeste softwares
die op windows besturingssysteem draaien object oriented zijn. Een tweede reden
is dat objecten erg flexible en krachtig zijn.

-   Collection: Als u “Get-Process” ingeeft krijgt u een tabel terug. Deze tabel
    bestaat uit meerdere objecten en properties. Deze set van objecten noemen we
    een Collection.  
    

    ![Collection](<https://i.gyazo.com/fcba6bb68bb589fe721fbe49175ce15d.png>)

-   Object: een rij in dat tabel is een object. bijvoorbeeld één proces of één
    service.

-   Property: een kolom in dat tabel. Het geeft wat informatie over een object.
    Process Name, processID, service status.  
    

-   Method: een actie dat een object kan doen. Starten van een service of
    stoppen van een process.

Om alle propreties, methodes, ... van een object weer te geven, pipelinen we dat
object met het command “Get-Member” met de alias “Gm”.  
hier pipelinen we alle processen van Get-Process naar Get-Member.  
\>Get-process \| Get-Member

![get-member](<https://i.gyazo.com/35b167c8fcd304ddc00dd818650caa54.png>)

In deze voorbeeld gaan we de propreties name,ID,VM,PM van de proces Skype
weergeven.  
\>gps -Name Skype \|Select-Object -Property Name,Id,Vm,pm

![skype](<https://i.gyazo.com/05ad52ce167a8da89628856c55b72f9c.png>)

3. Pipelines
------------

### 3.1 The Pipeline: Getting Connected & Extending the shell

 

### What’s the pipeline and what does it do?

The pipe character\` \`that is located at AltGr + 1 key, connects cmdlets to
produce better results. example:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PS C:\> Get-Service | Select-Object name, status | Sort Object name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Voert eerst Get-Service uit, daarna Select-Object name, status en daarna Sort
Object name.

Kan ook in meerdere lijnen worden onderbroken om leesbaarheid te bevorderen vb:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PS C:\> Get-Service |
>> Select-Object name, status |
>> Sort-Object name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Export to CSV

Je kan exporteren naar CSV bestanden door na de Pipe export-csv -Path [path] te
plaatsen. Dit creëert een CSV bestand op het opgegeven path.

Vb:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
PS C:\> get-process | export - CSV -Path c:\service.csv
PS c:\> notepad c:\> c:\service.csv
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dit creëert eerst een CSV file op het opgegeven Path en vervolgens openen we het
CSV bestand in notepad.

### Import from CSV

Analoog aan export-csv bestaat er ook `import-csv -Path c:\service.csv`

 

### Export to Command Line XML

Het commando `Export-Clixml -Path c:\good.xml` komt na een pipe ( \| ) character
en zorgt ervoor dat je een machine kan snapshotten.

-   Stel nu dat er malware of iets anders begint te runnen (in dit voorbeeld
    runnen we notepad en calculator)

-   Dan kan je de genomen snapshot vergelijken met de huidige status met het
    volgende commando:

-   `Compare-Object -ReferenceObject $(import-clixml C:\good.xml)
    -DifferenceObject $(Get-Process) -Property name`

### Other files and printers

Er is meer dan enkel het exporteren naar CSV en XML bestanden. Soms wil je een
ouput recht in een xml file krijgen. Bijvoorbeeld de lijst van de services

`get-service | out-file -FilePath c:\test.txt`

Hoe halen we dat hier nu uit? Simpel, gebruik de help functie: `get-help
*content*` . We krijgen nu een lijst met mogelijke cmdlets en functions die het
woord content bevatten. In die lijst staat ook Get-Content, laten we deze dus
gebruiken.

`PS C:\> get-content c:\test.txt`

Verolvens krijgen we een een lijst van dat text bestand met alle services die we
daarnet geëxporteerd hadden.

 

#### Out naar de printer

We zoeken in de help naar een lijst van dingen die je kan outputten `get-help
*out*` Out-Printer is hier een van. Zo kan je via de help functie opvragen wat
Ou-Printer doet en hiermee verder aan de slag gaan.

 

### Making a webpage of information

Ook simpele html pagina’s kunnen worden gegenereerd. Hiervoor kunnen we het
commande

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get-service | ConvertTo-HTML -Property name,status 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dit zorgt voor een output in je Powershell window met allemaal html tags. Om det
te voorkomen zetten we gewoon:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get-service | ConvertTo-HTML -Property name,status | out-file c:\test.htm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Dit kunnen we weergeven met `C:\test.htm`

 

### Cmdlets that kill

MAJOR LIFE SAVER: Parameter `-whatif`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   als je enige twijfel hebt over what een commando jusit zal doen. Gebruik
    `-whatiff`

-   Dit toont wat de uitvoer van dit commando zal zijn zonder het exact uit
    te voeren.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
get-service - DisPlayName *bi* | stop-service -whatif
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Zorgt ervoor dat je een lijst krijgt met de services die bi in hun naam hebben
en dan vraagt hij per service of je deze wil stoppen.

 

Ook de parameter `-confirm` kan handig zijn, geeft per service een
confirmatievraag of je deze wil stoppen.

 

### Extending the shell

Het idee is dat powershell kan uitgebreid worden met cmdlets voor specifieke
programma’s. Maar als je het programma niet hebt geïnstalleerd dan heb je ook de
cmdlets niet. Die worden met het programma zelf meegegeven.

Overzicht krijgen van de modules die beschikbaar zijn:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-Module -ListAvailable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En om te zien welke actief zijn gewoon `Get-Module`

 

### 3.2 The Pipeline: Deeper

 

### How the pipeline really works - The 4 step solution

Om te zorgen dat de pipeline werkt moet het ontvangende cmdlet in staat zijn om
het type object te ontvangen die over de pipeline wordt verstuurd door de
eerdere cmdlet. Om te gaan controleren kunnen we nagaan welke er allemaal
bestaan door het eerste cmdlet te pipen naar Get-Member (gm)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-Service | gm
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Je krijgt vervolgens te zien wat de TypeName is, in dit geval een
ServiceController.

Vervolgens ga je in de help kijken van het cmdlet waar je naar toe wil om te
zien ofdat het in staat is om dit type object te ontvangen.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-Help Stop-Service -full
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Bij de parameters kan je nu per parameter zien of Accept pipeline input true of
false is. Parameter `-DisplayName` staat op false en kan dus niet gebruikt
worden. `-Name` accepteert het wel, op 2 manieren (ByPropertyName en ByValue).

 

#### ByValue

In de help van stop-service zien we dat de parameter `-InputObject` een
\<ServiceController[]\> moet meekrijgen. Aangezien `Get-Service` van het type
ServiceController is zal deze automatisch ‘gevangen’ worden door parameter
`-InputObject` omdat het TypeName ServiceController exact hetzelfde geschreven
is. Dit noemt men ByValue.

Het kan natuurlijk zijn dat het niet mogelijk is om via ByValue een pipeline
connectie te leggen, dit is bijvoorbeeld het geval bij

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-Service | Stop-Process
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In de help van `Stop-Process` staat nergens dat het mogelijk is om een
ServiceController object te vangen, dus ByValue zal niet werken.

 

#### ByPropertyName

Indien ByValue niet werkt kan er misschien op een andere manier een connectie
worden gemaakt. We zien bijvoorbeeld in de help van `Stop-Process` dat de
parameter `-Name` pipeline input aanvaardt ByPropertyName. Als de eerste cmdlet
dus een property `-Name` bevat (en dus exact hetzelfde gespeld) zal het werken
via ByPropertyName. Het zal slechts zelden voorkomen dat een Service net
dezelfde naam heeft als een proces. Hou er dus rekening mee dat er niet altijd
een nuttige verbinding kan gevormd worden tussen cmdlets van een verschillend
type.

 

#### What if my property doesn’t match? Customize it!

Om dit mogelijk te maken wordt er met aliasen gewerkt: Name staat eigenlijk voor
ServiceName bij `Get-Service` terwijl bij `Get-ADComputer` Name staat voor
ComputerName. `Get-Service` verwacht dus een ServiceName, terwijl je een
ComputerName ingeeft. Dit gaat niet werken.

Toch is er bij `Get-Service` een parameter `-ComputerName`, we moeten dus de
`-Name` property van `Get-ADComputer` aanpassen naar `-ComputerName` zodat deze
hetzelfde gespeld zijn en dus overeenkomen:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-ADComputer -filter * | Select -Property name, @{name='ComputerName';expression={$_.name}}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Nu zal het wel werken om te pipen naar `Get-Service`.

 

#### The Parenthetical - when all else fails

Wat als er geen parameter is dat Pipeline input accepteert?

Get-WmiObject is zo’n cmdlet. We zien wel dat het als parameter `-ComputerName`
heeft, dus als we de namen van de computers uit het ADComputer object kunnen
halen en vervolgens in een String stoppen, zou het wel mogelijk zijn. Dit kan
met:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-ADComputer -filter * | Select -ExpandProperty name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Het commando wordt dus:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-WmiObject -class win32_bios -ComputerName (Get-ADComputer -filter * | Select -ExpandProperty name)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

Dit kan vanaf Powershell 3.0 verkort worden tot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-WmiObject -class win32_bios -ComputerName (Get-ADComputer -filter *).name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En zelfs nog makkelijker op deze manier

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-ADComputer -filter * | Get-WmiObject win32_bios -ComputerName {$_.name}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Gebruik deze manier enkel als al de andere niet werken, het is je laatste
reddingsmiddel.

 

4. Remoting
-----------

De remote functies van PowerShell maken gebruik van de Windows Remote Management
(WinRM) service. Vanaf Windows 7 is WinRM 2.0 of hoger standaard geïnstalleerd.
Op eerdere versies moet dit handmatig geïnstalleerd worden. Alle commando's
moeten uitgevoerd worden als Administrator.

Aangezien de WinRM service manueel gestart wordt, moet deze eerst op automatisch
overgeschakeld worden. Verifeer of de service draait.

-   get-service winrm

Vervolgens kan remoting met PowerShell geconfigureerd worden. (Op zowel de
machine van waar we connectie maken als de host waar we naar verbinden.)

-   enable-psremoting -force

Normaal gezien zouden nu andere hosts remote beschikbaar moeten zijn, zelfs in
een ander domein. Indien dit domein untrusted is, echter, zal de authenticatie
waarschijnlijk niet slagen. Dit kan verholpen worden door de host toe te voegen
aan de lijst met trusted hosts.

-   winrm s winrm/config/client '\@{TrustedHost="HOSTNAME"}'

Ook moet de WinRM service actief zijn op de host.

-   test-wsman HOSTNAME

Indien de host nog steeds niet beschikbaar is, herconfigureer de WinRM service
op de host.

-   winrm quickconfig

Nu zouden we commando's remote moeten kunnen uitvoeren. Meerdere hosts worden
gescheiden met een comma en een spatie.

-   invoke-command -computername HOSTNAME -scriptblock { COMMAND } -credential
    USERNAME

Ook kunnen we scripts remote gaan uitvoeren.

-   invoke-command -computername HOSTNAME -filepath c:\path\to\script.ps1

Evenals kan een remote sessie gestart woden.

-   enter-pssession -computername HOSTNAME -credential USERNAME

5. Scripting
------------

Nu kan je wel alles kennen van powershell en weten hoe je computers aanpast via
powershell. Als je deze handelingen dag na dag weer moet herhalen breng dit
tijdverlies met zich mee. Hier komen scripts kijken. Powershell scripts stellen
je in staat een bepaal proces van commandos bij te houden en met één klik
dezelfde aanpassingen te maken maar dan automatisch. “Automatisch” , We begonnen
deze samenvatting met het feit dat powershell een tool is dat je in staat brengt
dagelijkse taken te automatiseren. Scripting speelt hier een zeer belangrijke
rol in.

Het zal alvast beter zijn om direct naar een script te kijken, zo zullen we
sneller de structuur en opbouw van scripts begrijpen.

De bedoeling van dit script is het weergeven van de services die lopen op de
localhost en loopback en dit terwijl ze gesorteerd zijn

>   \$args = "localhost","loopback"

In vele scripts word er begonnen met declareren van variabelen. In Powershell
begint een variabele met een dollarteken $. >foreach ($i in \$args)

Dit is een foreach lus , de code hieronder zal voor elk element in de variabele
apart worden uitgevoerd  
\>{Write-Host "Testing" \$i "..."  
\>Get-WmiObject -computer \$args -class win32\_service \|  
Select-Object -property name, state, startmode, startname \|  
Sort-Object -property startmode, state, name \|  
Format-Table \*}

Ten slotte is dit de uitvoer aan de hand van commandlets word de informatie
opgehaald en gesorteerd waarna deze word wegeschreven naar de host

In het vorige script werd er al gebruik gemaakt van variabelen. Variabelen maken
een belangrijk deel uit van scripts. Ze houden namelijk informatie bij dit kan
gaan van getallen , letters/woorden en objecten.

Er zijn ook een groot aantal speciale variabelen in Powershell. Deze vind je
hieronder uitgelegd.

![vars](<http://imgur.com/xEgG1T3.png>)

Net zoals in andere programmeer/scripting talen kunnen er aan variabelen
datatypes worden gegeven.

![vars](<http://imgur.com/Gann3ti.png>)

######The While Loop  
Een bepaalde actie zal blijven uitgevoerd worden tot de conditie niet niet meer
geldig is 
```Powershell
$i = 0 
$fileContents = Get-Content -path C:\fso\testfile.txt 
While( $i -le $fileContents.length )  
{ 
$fileContents[$i]
$i++
}
```
######Do loop
```Powershell
   i = 0  
   ary = Array(1,2,3,4,5)  
   Do While i \< 5  
    WScript.Echo ary(i)  
    i = i + 1  
   Loop
```
For Each Voor elke object in de variabele zal de actie 1 keer worden uitgevoerd
```Powershell
ary = Array(1,2,3,4,5)
For Each i In ary  
    If i = 3 Then Exit For  
    WScript.Echo i  
Next  
WScript.Echo "Statement following Next"
```
### 5.1 Functions

Powershell heeft standaard veel functies die je kan gebruiken. Maar je kan
altijd steeds ook je eigen functies schrijven die je dan later kan hergebruiken.
Stel je hebt schrijft een script waar er vaak een conversie van meter naar Miles
moet gebeuren. dan kan je een functie ConvertMToMiles schrijven en steeds deze
gebruiken in plaats van de berekening steeds te moeten doen

Het creeren van eeen functie heeft de volgende structuur. 
```Powershell
          function [<scope:>]<name> [([type]$parameter1[,[type]$parameter2])]  
          {
              param([type]$parameter1 [,[type]$parameter2])

              dynamicparam {<statement list>}
  
              begin {<statement list>}
              process {<statement list>}
              end {<statement list>}
          }
```

### 5.2 Modules

Modules zijn verzamelingen van verschillende powershell commando's. Zoals
cmdltes, functions, variables, aliases, providers. Powershell gebruikers kunnen
aan de hand van modules snel functies en variabelen delen met elkaar.

Een lijst weergeven van alle geimporteerd modules in the huidige sessie
>Get-Module

Een lijst van alle geinstalleerde modules die kunnen geimporteerd worden in de
huidige sessie 
>Get-Module -ListAvailable

Zoeken van commando's in een module gaat als volgt. 
>Get-Command -Module

Importeren van nieuwe modules 
>import-module

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Opzoeken van uitleg kan met Get-Help :

    Get-Help <command-name> 

je kan ook online help gebruiken:  

    Get-Help <command-name> -Online 
    

om help files te installeren voor een bepaalde module type:

    Update-Help –Module <module-name>  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Modules worden opgeslagen als psm1 files. Hieronder een eenvoudige module

```Powershell
##
##    PowerShell module to output hello worlds!
##

#requires -Version 2.0
function Write-HelloWorld { 
    Write-Host "Hello world!" -Foreground Green
<#
.Synopsis
    Outputs Hello World!
    
.Example
    Write-HelloWorld    
#>
}

Export-ModuleMember Write-HelloWorld
```


### 6 Multitasking

Meestal worden powershell commando’s synchroon uitgevoerd, maar door taken in de
background uit te voeren kunnen we de shell voor andere taken gebruiken. Om de
juiste werking van de commando’s te testen voeren we de commando’s synchronisch
uit, pas wanneer we zeker weten dat onze code goed werkt worden de commando’s
asynchroon uitgevoerd

#### Synchronous versus asynchronous

-   Tijdens het synchronisch uitvoeren van taken hebben we de mogelijkheid om
    direct een antwoord te geven op de input requests. Indien er zich input
    requests tijdens de synchronische uitvoering van de commando’s voordoen,
    stopt de taak onmiddellijk.

-   Commando’s kunnen ook soms error messages genereren. Bij een synchronische
    uitvoer worden die messages meteen getoond, bij een asynchronische uitvoer
    kan er ook een error message gegenereerd worden, maar deze worden niet
    onmiddelijk getoond.

-   Indien we de taken synchronisch uitvoeren krijgen we bij gebrek aan een
    verplichte parameter een passende melding. Bij een asynchronische uitvoer
    wordt daarentegen geen melding gegeven en het commando faalt.

-   De resultaten van een synchronisch uitgevoerde taak worden getoond zodra ze
    beschikbaar zijn, terwijl tijdens een asynchronische uitvoer we de output
    pas weergegeven wordt wanneer het commando volledig voltooid is.

om een taak in background uit te voeren maakt u gebruik van het commando
"Start-Job". binnen de parameter -scriptblock komen de instructies, u kunt ook
een -FilePath meegeven. \> Start-Job -ScriptBlock {dir}

![start-job](<https://i.gyazo.com/e42da4d13a43ae223ce0ad780aeacb11.png>)

Om een taak in background uit te voeren maakt u gebruik van het commando
"Start-Job". Binnen de parameter -scriptblock komen de instructies, u kunt ook
een -FilePath meegeven.

>   get-job -id 1 \| format-list \*

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
State : Completed  
HasMoreData : True  
StatusMessage :  
Location : l ocalhost  
Command : dir  
JobStateInfo : Completed  
Finished : System.Threading.ManualResetEvent  
InstanceId : e1ddde9e-81e7-4b18-93c4-4c1d2a5c372c  
Id : 1  
Name : Job1  
ChildJobs : {Job2}  
Output : {}  
Error : {}  
Progress : {}  
Verbose : {}  
Debug : {}  
Warning : {}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
