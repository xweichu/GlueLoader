from __future__ import absolute_import, division, print_function
from glue.config import data_factory
# from glue.core import Data
from glue.core import DataCollection, Data
from skimage.io import imread
import yt

"""Declare any extra link functions like this"""
# @link_function(info='translates A to B', output_labels=['b'])
# def a_to_b(a):
#    return a * 3

def is_jpeg(filename, **kwargs):
    return filename.endswith('.jpeg')

@data_factory('3D image loader', is_jpeg)
def read_jpeg(file_name):
    im = imread(file_name)
    return Data(cube=im)

@data_factory('YT')
def read_yt(i):
    ds=yt.load('~/Desktop/smallplt00000/smallplt00000/')
    ad=ds.all_data()
    df = ad.to_glue(['density'])
    return df

@data_factory('YT2')
def read_yt2(i):
    ds=yt.load('~/Desktop/smallplt00000/smallplt00000/')
    # ad=ds.all_data()
    gs = ds.index.select_grids(ds.index.max_level)
    g2 = gs[0]
    gdata = g2["density"][:,:,0]

    v, c = ds.find_max("density")
    sl = ds.slice(2, c[0])
    # print (sl["index", "x"])
    # gdata = Data(label='yt')
    # gdata.add_component(ad['gas', 'density'], "component_name_1") 
    # gdata.add_component(ad['boxlib', 'cell_volume'],"component_name_2")
    return sl["index", "x"]


# @data_factory('YT3')
# def to_glue(ts):
#     fields=['gas','density']
#     gdata = Data(label='yt') 
#     for component_name in fields:
#         gdata.add_component(self[component_name], component_name) 

#     dc = DataCollection([gdata])

#     return dc

"""Data factories take a filename as input and return a Data object"""
# @data_factory('JPEG Image')
# def jpeg_reader(file_name):
#    ...
#    return data


"""Extra qt clients"""
# qt_client(ClientClass)
