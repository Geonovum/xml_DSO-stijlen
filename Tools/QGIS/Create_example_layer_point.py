import qgis.core

# Specify the geometry type
layer = QgsVectorLayer('Point?crs=epsg:28992&field=symbol:string(10)', 'point' , 'memory')

# Set the provider to accept the data source
prov = layer.dataProvider()

# 646.36 308975.28 276050.82 636456.31

v = 0
fts = ["pk0","pk1","pk2","pv0","pv1","pv2","pc0","pc1","pc2","ps0","ps1","ps2","pd0","pd1","pd2","pr0","pr1","pr2","px0","px1","px2"]
while v < len(fts):
    h = 0
    while h < 55:
        x = 670 + (h * 3500)
        y = 636432 - (v * 3500)
        #points = [QgsPointXY(x,y),QgsPointXY(x + 2000,y),QgsPointXY(x + 2000,y - 1000),QgsPointXY(x,y - 1000),QgsPointXY(x,y)] 
        points = QgsPointXY(x,y)
        # Add a new feature and assign the geometry
        feat = QgsFeature()
        feat.setGeometry(QgsGeometry.fromPointXY(points))
        symboolcode = '{0}{1}{2}'.format(fts[v],'0'[len(str(h))-1:2],str(h))
        feat.setAttributes([symboolcode])
        prov.addFeatures([feat])
        h += 1
    v += 1
 
# Update extent of the layer
layer.updateExtents()
 
# Add the layer to the Layers panel
QgsProject.instance().addMapLayers([layer])