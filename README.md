# DL4FLI
Deep Learning for Fluorescence Lifetime Imaging (FLI)

--------------------------------------------------------------

This GitHub contains relevant script, data and instructions for:
1. FLI data simulation workflow (**MATLAB**)

  * FLIM ['/TPSFsimulation_FLIM'](https://github.com/jasontsmith2718/DL4FLI/tree/master/TPSFsimulation_FLIM)

  * Basic MFLI ['/TPSFsimulation_basic'](https://github.com/jasontsmith2718/DL4FLI/tree/master/TPSFsimulation_basic)
  
  * Monte-Carlo (via [__MCX__](http://mcx.space/)) modeling of fluorescence decays [through turbid media](https://github.com/jasontsmith2718/DL4FLI/tree/master/TPSFsimulation_MCX). _**THIS WORK IS ONGOING**_.

2. **FLI-Net** (neural network) training (**python**, [_Tensorflow & Keras_]).

  * 3D-CNN for MFLI and FLIM analysis ['/FLINET_ex'](https://github.com/jasontsmith2718/DL4FLI/tree/master/FLINET_ex)
  
3. SPCImage export and analysis [instructions](https://github.com/jasontsmith2718/DL4FLI/blob/master/SPCImage_ExportAndAnalyze/SPCImageExportAndAnalyze_slideShow.pptm?raw=true) (general) along with example data. ['/SPCImage_ExportAndAnalyze'](https://github.com/jasontsmith2718/DL4FLI/tree/master/SPCImage_ExportAndAnalyze)

__Authors__: [Jason T. Smith](https://www.researchgate.net/profile/Jason_Smith96), [Dr. Ruoyang Yao](https://www.researchgate.net/profile/Ruoyang_Yao), [Nathan Un](https://www.linkedin.com/in/nathanjohnun/), [Dr. Pingkun Yan](https://www.researchgate.net/profile/Pingkun_Yan)

__Research Group__: [Functional & Molecular Optical Imaging Laboratory](http://intes-lab.bme.rpi.edu/) (RPI)

--------------------------------------------------------------

### Relevant Data files:

#### MFLI Data:

1. Time-series MFLI for pharmacokinetic monitoring _in vivo_ [control](https://figshare.com/s/f216de0f63a352cd5c44) & [FRET-induced](https://figshare.com/s/db8dbc19455ea5fa82f3)

2. [NIR-FRET well-plate (**AF700 & AF750**)](https://figshare.com/s/841b13c73a1a35cc4e63)

3. [_In vivo_ matrigel ROIs](https://figshare.com/s/d3f1375e2fd6d10bc30f) for NIR FRET quantification (**AF700 & AF750**)

4. MFLI acquisitions of [well-plates containing serial dilutions of **ATTO 740 & HITCI**](https://figshare.com/s/af59c3fe4fc8479efffa) (methodology detailed here __(REFERENCE)__)

5. [Serial dilution of AF750](https://figshare.com/s/3ca9941b2c6e50f500eb) imaged at 25mW & 75mW laser power for performance assessment at low photon-counts

#### Visible FLIM Data

1. [Visible FRET-FLIM](https://figshare.com/s/541c3112813cbd417957) (**AF488 & AF555**, T47D breast cancer cells)

2. [Visible Metabolic NAD(P)H FLIM](https://figshare.com/s/0a78e95f917b142e53fc) pre & post exposure to sodium cyanide. The breast cancer cell lines used include the following:

  * MCF10a
  * AU565
  * T47D
  * MDA-MB 231

#### NIR FLIM Data

1. [NIR FRET-FLIM](https://figshare.com/s/d4d21918f719a8233f4a) (**AF700 & AF750**, T47D breast cancer cells)

#### _In Silico_ Data

1. Data simulated across three photon count thresholds [(25-100, 100-250 & 250-500)](https://figshare.com/s/e84c4d612654df989208)

--------------------------------------------------------------

## Related Publications/Presentations:

#### [PNAS Manuscript](https://www.pnas.org/content/early/2019/11/11/1912707116) & [Supplementary Information](https://www.pnas.org/content/pnas/suppl/2019/11/11/1912707116.DCSupplemental/pnas.1912707116.sapp.pdf)
1) Smith JT, Yao R, Sinsuebphon N, Rudkouskaya A, Un N, Mazurkiewicz J, Barroso M, Yan P, Intes X. _Fast fit-free analysis of fluorescence lifetime imaging via deep learning_. Proceedings of the National Academy of Sciences. 2019 Nov 12.

#### [Original preprint](https://www.biorxiv.org/content/10.1101/523928v1)
2) Smith JT, Yao R, Sinsuebphon N, Rudkouskaya A, Mazurkiewicz J, Barroso M, Yan P, Intes X. _Ultra-fast fit-free analysis of complex fluorescence lifetime imaging via deep learning_. bioRxiv. 2019 Jan 1:523928.

#### [OSA Proceeding](https://www.osapublishing.org/abstract.cfm?uri=NTM-2019-NM3C.4)
3) Smith JT, Un N, Yao R, Sinsuebphon N, Rudkouskaya A, Mazurkiewicz J, Barroso M, Yan P, Intes X. _Fluorescent Lifetime Imaging improved via Deep Learning_. InNovel Techniques in Microscopy 2019 Apr 14 (pp. NM3C-4). Optical Society of America.

#### [SPIE Presentation](https://www.spiedigitallibrary.org/conference-proceedings-of-spie/10871/108710J/Deep-learning-for-quantitative-bi-exponential-fluorescence-lifetime-imaging-Conference/10.1117/12.2509857.short)
4) Smith JT, Yao R, Chen SJ, Sinsuebphon N, Rudkouskaya A, Barroso M, Yan P, Intes X. _Deep learning for quantitative bi-exponential fluorescence lifetime imaging (Conference Presentation)_. InMultimodal Biomedical Imaging XIV 2019 Mar 4 (Vol. 10871, p. 108710J). International Society for Optics and Photonics.


--------------------------------------------------------------

