# D-EAPS Thesis template

This template aim to meet the formatting requirements for ETH D-EAPS BSc and MSc theses
(https://eaps.ethz.ch/studium/bachelor/arbeit/richtlinien-bachelor-arbeit.html).
Where no specific guidance for Master theses is given, the same guidance as for BSc theses 
is applied.

The class takes inspiration from the usiinfthesis class, but is a complete new implementation,
as many features from usiinf are not needed and introduce too much complexity into the imnplementation.


## Missing features

* Support hyperref properly (e.g. table of contents is tricky)
* Support for co-advisors from other universities. Currently, "ETH Zurich" is auto-generated.

## Usage

To use the class, you need the following files:

* eapsthesis.cls
* eaps-logo.png
* eth-log-pos.png

The class file and the images have to be in the same directory. For the easiest and thus recommended use case,
just drop these files in the top level directory of your thesis project, alongside your ```main.tex```
or similar. 

For more advanced use cases, you can install the template and PNGs in a directory that LaTeX searches
for class files. AI will know how to do this, so it's not documented here.