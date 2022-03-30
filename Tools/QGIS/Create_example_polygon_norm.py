import qgis.core

# Specify the geometry type
layer = QgsVectorLayer('Polygon?crs=epsg:28992&field=symbol:string(10)', 'polygon' , 'memory')
 
# Set the provider to accept the data source
prov = layer.dataProvider()

# 646.36 308975.28 276050.82 636456.31

v = 0
fts = ["vsgt2","vsgt3","vsgt4","vsgt5","vsgt6","nsg01","nsg02","nsg03","nsg04","nsg05","nsg06","nsg07","nsg08","nsg09","nsg10","nsg11","nsg12","nsg13","nsg14","nsg15","nsg16","nsg17","nsg18","nsg19","nsg20"]
while v < len(fts):
    h = 0
    while h < 33:
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