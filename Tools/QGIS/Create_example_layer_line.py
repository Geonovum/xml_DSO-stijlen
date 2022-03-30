import qgis.core

# Specify the geometry type
layer = QgsVectorLayer('LineString?crs=epsg:28992&field=symbol:string(10)', 'line' , 'memory')

# Set the provider to accept the data source
prov = layer.dataProvider()

# 646.36 308975.28 276050.82 636456.31

v = 0
fts = ["lt0","lm0","ls0","lth0","lmh0","lsh0"]
while v < len(fts):
    h = 0
    while h < 55:
        x = 646 + (h * 3000)
        y = 636356 - (v * 1000)
        #points = [QgsPointXY(x,y),QgsPointXY(x + 2000,y),QgsPointXY(x + 2000,y - 1000),QgsPointXY(x,y - 1000),QgsPointXY(x,y)] 
        points = [QgsPointXY(x,y),QgsPointXY(x + 2000,y)]
        # Add a new feature and assign the geometry
        feat = QgsFeature()
        feat.setGeometry(QgsGeometry.fromPolylineXY(points))
        symboolcode = '{0}{1}{2}'.format(fts[v],'0'[len(str(h))-1:2],str(h))
        feat.setAttributes([symboolcode])
        prov.addFeatures([feat])
        h += 1
    v += 1
 
# Update extent of the layer
layer.updateExtents()
 
# Add the layer to the Layers panel
QgsProject.instance().addMapLayers([layer])