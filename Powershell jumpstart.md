Samenvatting PowerShell Jumpstart Getting Started with PowerShell v3.0
======================================================================

 

Chapter 1: Don’t fear the shell
-------------------------------

### Purpose to PowerShell

-   Improved management and automation

-   Manage real-time

-   Manage large scale

###  

### Customize the shell for comfort

Font size 16

Screen Buffer size

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Width: 120

Height: 3000
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Window size

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Width: 120

Height: 62
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 

### Getting familiar with the shell

cmdlets:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-   werken volgens principe van Verb-Noun

-   vertellen wat je wil doen

-   vb: Set-Location c:\\  -\> verandert

-   vb: Get-Alias -\> lijst van alle aliases die er zijn.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ook unix en windows commando’s als dir, ls en mkdir werken.

 

Chapter 2: The help system
--------------------------

 

Get-help parameters:

\-Detailed = detailed view met examples en uitleg over parameters

\-Full = volledige help

\-Examples = help met examples

\-ShowWindow = opent de help in apart venster waar je dan kan kiezen wat er
weergegeven wordt.

-   Parameters tussen [\#section](<#section>) zijn niet vereist.

-   Positionele parameters zijn niet vereist.

-   Gebruik de tab-toets om door cmdlets en parameters te navigeren. Shift + Tab
    om terug te keren naar vorige.

 

Chapter 3: The Pipeline: Getting Connected & Extending the shell
----------------------------------------------------------------

 

### What’s the pipeline and what does it doe?

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

 

Chapter 5: The Pipeline: Deeper
-------------------------------

 

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
