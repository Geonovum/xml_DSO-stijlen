Batch-svg-png.scm
=================

Dit script dient ertoe om in batch svg bestanden naar png bestanden te
converteren met GIMP, zonder dat er Anti-Aliasing wordt aangemaakt. Het werkt
niet in de Windows command-prompt. Dit om mysterieuze redenen.  
  
Het werkt wel in MINGW64 (een POSIX-shell die in Windows geïnstalleerd kan
worden. Deze wordt meegeleverd met de GIT-Desktop  
Hoe werkt het?  
Eerst het bestand plaatsen in de directory waar Gimp zoekt naar bestanden, deze
kan achterhaald worden door te kijken in Gimp -\> Edit -\> Preferences Nadat het
bestand in deze directory is geplaatst moet Gimp worden gevraagd om de scripts
te lezen. Dit gebeurd door Filters -\> Script-Fu -\> Scripts-Refresh  
Indien dit niet juist is gebeurd dan komen er foutmeldingen als de scripts
worden aangeroepen.  
Dan wordt het script aangeroepen op de MINGW prompt op deze wijze:  
  
/c/Program Files/GIMP 2/bin/gimp-console-2.10.exe -c -b '(batch-svg-png 228 144
144)' -b '(gimp-quit 0)'  
  
Er zijn 3 parameters bij het script Resolutie (px/inch), Width (px), Height (px)
