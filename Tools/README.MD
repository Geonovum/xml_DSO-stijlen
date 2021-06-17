Tools voor het maken van diverse bestanden
==========================================

Symbol in QGIS maken van code
-----------------------------

\- Layer_from_symbollayer_file.py

Om puntsymbolen die in de symbolenbibliotheek van het DSO zijn gebruikt voor de
viewer als png’s op een spritemap moet de definitie voor die symbolen zoals die
in de code van QGIS opgeslagen ligt omgezet worden in een polygoon.

Deze kan daarna als svg opgeslagen worden.

Van SLD een html maken (symbolenbibliotheek)
--------------------------------------------

\- SLD10-HTML.xsl

Van SLD een stylesheet maken voor de waardelijst (symbolisatietabellen)
-----------------------------------------------------------------------

\- SLD10-Waardelijst_CSS.xslt

Naar de CSS die met deze transformatie wordt gemaakt kan in waardelijst naar
verwezen worden.

Als deze waardelijst in Google Chrome geopend wordt dan worden de symbolen bij
de groepen die een symboolcode hebben getoond in de juiste kleuren en vorm.

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
