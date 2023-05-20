import scanpy as sc
import sys

print("Reading matrix")
adata = sc.read_10x_mtx(sys.argv[1])
print("Writing h5ad")
adata.write_h5ad(str(sys.argv[2]))
print("Done!")