Tools voor het maken van diverse bestanden
==========================================

Symbol in QGIS maken van code
-----------------------------

\- Layer_from_symbollayer_file.py

De puntsymbolen zijn in de SLD als WellKnownNames benoemd. Voor de viewer moeten
deze symbolen als png’s in een spritemap gezet worden. De definitie achter de
WellKnownName is in de code van QGIS opgeslagen. Met dit pythinscript kunnen de
symbolen als polygoon neergezet worden waarna ze als svg opgeslagen kunnen
worden.

Van SLD een html maken (symbolenbibliotheek)
--------------------------------------------

\- SLD10-HTML.xsl

De SLD is in XML formaat welke moeilijk te interpreteren is zonder extra
software. Deze transformatie maakt van een SLD een HTML pagina met de juiste
kleuren en patronen om de stijl die bij een symboolcode hoort te kunnen zien.

Van SLD een stylesheet maken voor de waardelijst (symbolisatietabellen)
-----------------------------------------------------------------------

\- SLD10-Waardelijst_CSS.xslt

De IMOW waardelijst wordt in een aantal formaten beschikbaar gesteld, geen van
deze formaten geven de kleuren en patronen weer van de symboolcodes die bij de
items in de lijst staan. Deze tool maakt een CSS en door in de XML versie van de
waardelijst een verwijzing naar deze CSS op te nemen en te openen in een browser
worden bij de symboolcodes de kleuren en patronen weergegeven.

Van svg’s png’s maken
---------------------

\- to_png.bat

Een batch verwerking van een set svg’s naar png’s in verschillende resoluties
met Inkscape.

Let op: bij deze omzetting wordt altijd antialiasing gebruikt wat niet in de
oorspronkelijk png’s het geval was. Het is in een batchverwerking niet mogelijk
gebleken om de antialiasing uit te zetten.

\- batch-svg-png.scm

Een batchverwerking van een set svg’s naar png’s in verschillende resoluties met
Gimp.

In deze verwerking wordt geprobeerd om de antialiasing te omzeilen wat in veel
gevallen lukt, maar niet overal.

TODO: een batchverwerking die correct alle svg’s omzet naat png’s zonder
antialiasing.
