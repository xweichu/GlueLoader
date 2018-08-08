from __future__ import absolute_import, division, print_function
from glue.config import data_factory
# from glue.core import Data
from glue.core import DataCollection, Data
from skimage.io import imread
from glue.config import importer
from qtpy.QtCore import Qt
from qtpy import QtWidgets
from glue.utils.qt import set_cursor_cm
import yt
# from __future__ import absolute_import, division, print_function

import os


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


def read_yt(dirname):
    import yt
    ds=yt.load(dirname)
    v, c = ds.find_max("density")
    sl = ds.slice(2, c[0])
    return sl["index", "x"]

@data_factory('YT_DS')
def get_data(i):
    client = Client('128.104.222.103:8786')
    i = 0
    ls = []
    for symbol in os.listdir('/mnt/cephfs/all_tar/'):
        dirname =  '/mnt/cephfs/all_tar/' + symbol
        dirname = dirname.split(',')
        #print(dirname)
        data = client.submit(read_yt, dirname[0])
        ls.append(data)
        if i>5:
            break
        i = i+1
    dc = DataCollection()
    for item in ls:
        dc.append(item.result())

@data_factory('YT')
def read_yt(i):
    ds=yt.load('~/Desktop/smallplt00000/smallplt00000/')
    ad=ds.all_data()
    # df = ad.to_glue(['density'])
    # print (ds.index.grid_left_edge)
    #all_data_level_0 = ds.covering_grid(level=0, left_edge=[0,0.0,0.0],dims=[64, 64, 64])
    # df = ad[('boxlib', 'density')]
    # sp = ds.sphere([0.5, 0.5, 0.5], (1, 'kpc'))
    df = ad['gas', 'z']
    df = ad['density']
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

@importer("Import from custom source")
def my_importer():
    import Tkinter
    import tkMessageBox
    tkMessageBox.showinfo("Title", "a Tk MessageBox")
    return []
#     while True:
#         gdd = GlueDataDialog()
#         try:
#             # result = gdd.load_data()
#             break
#         except Exception as e:
#             # decision = report_error(e, gdd.factory(), gdd._curfile)
#             # if not decision:
#             return []
#     return []
    # # Main code here
    # ds=yt.load('~/Desktop/smallplt00000/smallplt00000/')
    # ad=ds.all_data()
    # # df = ad.to_glue(['density'])
    # # print (ds.index.grid_left_edge)
    # #all_data_level_0 = ds.covering_grid(level=0, left_edge=[0,0.0,0.0],dims=[64, 64, 64])
    # # df = ad[('boxlib', 'density')]
    # # sp = ds.sphere([0.5, 0.5, 0.5], (1, 'kpc'))
    # df = ad['gas', 'z']
    # df = ad['density']
    # return df

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


# class GlueDataDialog(object):

    # def __init__(self, parent=None):
    #     self._fd = QtWidgets.QFileDialog(parent, directory=os.curdir)
    #     # from glue.config import data_factory
    #     # self.filters = [(f, self._filter(f))
    #     #                 for f in data_factory.members if not f.deprecated]
    #     # self.setNameFilter()
    #     self._fd.setFileMode(QtWidgets.QFileDialog.ExistingFiles)
    #     self._curfile = ''
    #     try:
    #         self._fd.setOption(
    #             QtWidgets.QFileDialog.Option.HideNameFilterDetails, True)
    #     except AttributeError:  # HideNameFilterDetails not present
    #         pass

    # def factory(self):
    #     fltr = self._fd.selectedNameFilter()
    #     for k, v in self.filters:
    #         if v.startswith(fltr):
    #             return k

    # def setNameFilter(self):
    #     fltr = ";;".join([flt for fac, flt in self.filters])
    #     self._fd.setNameFilter(fltr)

    # def _filter(self, factory):
    #     return "%s (*)" % factory.label

    # def paths(self):
    #     """
    #     Return all selected paths, as a list of unicode strings
    #     """
    #     return self._fd.selectedFiles()

    # def _get_paths_and_factory(self):
    #     """Show dialog to get a file path and data factory

    #     :rtype: tuple of (list-of-strings, func)
    #             giving the path and data factory.
    #             returns ([], None) if user cancels dialog
    #     """
    #     result = self._fd.exec_()
    #     if result == QtWidgets.QDialog.Rejected:
    #         return [], None
    #     # path = list(map(str, self.paths()))  # cast out of unicode
