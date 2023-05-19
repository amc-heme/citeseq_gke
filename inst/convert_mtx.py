import anndata as ad
import sys

print("Reading matrix")
adata = ad.read_mtx(sys.argv[1])
print("Writing h5ad")
adata.write_h5ad(str(sys.argv[2]))
print("Done!")