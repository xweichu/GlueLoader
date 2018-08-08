from dask import  delayed
from glob import glob
import os
from dask.distributed import Client



def read_yt(dirname):
    import yt
    ds=yt.load(dirname)
    v, c = ds.find_max("density")
    sl = ds.slice(2, c[0])
    return sl["index", "x"]


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
    for item in ls:
        print(item.result())