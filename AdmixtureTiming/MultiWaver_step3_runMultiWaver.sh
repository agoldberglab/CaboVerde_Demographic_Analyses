#!/bin/bash
#SBATCH --mem=20GB
cd /datacommons/noor/klk37/CV/NewReseqData/Multiwaver

# Run MultiWaver with default parameters and 100 bootstraps

MultiWaveInfer-2.0/bin/MultiWaveInfer2 -i MultiwaverInp_Santiago.txt -o MultiwaverOut_Santiago -b 100
MultiWaveInfer-2.0/bin/MultiWaveInfer2 -i MultiwaverInp_Fogo.txt -o MultiwaverOut_Fogo -b 100
MultiWaveInfer-2.0/bin/MultiWaveInfer2 -i MultiwaverInp_NWcluster.txt -o MultiwaverOut_NWcluster -b 100
MultiWaveInfer-2.0/bin/MultiWaveInfer2 -i MultiwaverInp_BoaVista.txt -o MultiwaverOut_BoaVista -b 100
