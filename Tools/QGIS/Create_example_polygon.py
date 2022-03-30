import qgis.core

# Specify the geometry type
layer = QgsVectorLayer('Polygon?crs=epsg:28992&field=symbol:string(10)', 'polygon' , 'memory')
 
# Set the provider to accept the data source
prov = layer.dataProvider()

# 646.36 308975.28 276050.82 636456.31

v = 0
fts = ["vsg0","vsg1","vsgt0","vsgt1","vsh0","vsh1","vsht","vsht1","vsz0","vszt","vag0","vag1","vag2","vag3","vag4","vag5","vah0","vah1","vah2","vah3","vah4","vah5","vaz0","vaz1","vaz2","vaz3","vaz4","vaz5","vog0","voh0"]
while v < len(fts):
    h = 0
    while h < 55:
        x = 646 + (h * 3000)
        y = 636456 - (v * 2000)
        points = [QgsPointXY(x,y),QgsPointXY(x + 2000,y),QgsPointXY(x + 2000,y - 1000),QgsPointXY(x,y - 1000),QgsPointXY(x,y)] 
        #polygon= QgsGeometry.fromPolygon([points])

        # Add a new feature and assign the geometry
        feat = QgsFeature()
        feat.setGeometry(QgsGeometry.fromPolygonXY([points]))
        symboolcode = '{0}{1}{2}'.format(fts[v],'0'[len(str(h))-1:2],str(h))
        feat.setAttributes([symboolcode])
        prov.addFeatures([feat])
        h += 1
    v += 1
 
# Update extent of the layer
layer.updateExtents()
 
# Add the layer to the Layers panel
QgsProject.instance().addMapLayers([layer])