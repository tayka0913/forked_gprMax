from pathlib import Path

import gprMax

fn = Path(__file__)

title = gprMax.Title(name=fn.with_suffix('').name)
domain = gprMax.Domain(p1=(0.14,0.12,0.12))
dxdydz = gprMax.Discretisation(p1=(0.0008, 0.0008, 0.0008))
time_window = gprMax.TimeWindow(time=10e-9)

g_stl = gprMax.GeometryObjectsReadSTL(stl_file='data_LasoMax/Dubai.stl', mat_index=1, discretization=(0.0008,0.0008,0.0008) )

g_read = gprMax.GeometryObjectsRead(p1=(0.01 ,0.01,0.01), geofile=fn.with_suffix('.h5') , matfile= 'user_models/materials.txt')

gv = gprMax.GeometryView(p1=(0, 0, 0),
                         p2=(0.14, 0.12,0.12),
                         dl=(0.0008, 0.0008, 0.0008),
                         filename=fn.with_suffix('').name,
                         output_type='n')
                         
# create a scene
scene = gprMax.Scene()
# add the simulation objects to the scene
scene.add(title)
scene.add(domain)
scene.add(dxdydz)
scene.add(time_window)
scene.add(g_stl)
scene.add(g_read)
scene.add(gv)

# run the simulation
gprMax.run(scenes=[scene], geometry_only=True, n=1, outputfile=fn)
