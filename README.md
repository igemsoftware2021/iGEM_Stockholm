# iGEM_Stockholm
**MatLab agent based model of skin microbial interaction during dysbiosis**

As part of the dry lab, we wanted a model that showed the interactions among different microbes living in normal skin, and to make a simple representation of dysbiosis.

During the summer we first spent time understanding and simplifying the complex skin microbial interactions by reading several research articles. Further, we used MATLAB to develop a model that plots the variation in skin microbial population distribution and respective metabolite concentration (1). We tried to model dysbiosis as being caused by deviations in crucial parameters such as microbial growth rates, death rates of metabolite production rates.

We made a 2D visualisation of dysbiosis using the agent-based model represented as a grid animation. The entire process of MATLAB modeling including the theory, methodology, and results has been explained below.

The microorganisms present on the skin can be divided into two categories, commensals and pathogens. Although there are several microorganisms living on our skin, in our model we only focused on three microbes: C. acnes, S. epidermidis and S. aureus.

C. acnes, a fundamental skin microbe, and S. epidermidis, also present in most parts of our skin, are considered commensal bacteria because they are harmless in healthy conditions. The second type is harmful and pathogenic microbes that colonize the skin and lead to infections and inflammation. S. aureus is one of the most predominant pathogenic bacteria in the skin. (2, 3)

In healthy skin microbiota, S. epidermidis and C. acnes interact with each other to protect against and prevent pathogens, as well as participate in skin equilibrium with the secretion of beneficial metabolites. Thus they keep each other's population in balance and prevent the growth of S. aureus. (3)

The various interactions can be summarised as follows:

1] C. acnes inhibits proliferation of S. epidermidis through hydrolyzing sebum triglycerides and release of **propionic acid**
2] C. acnes releases **coproporhyrin III** promoting S. aureus biofilm
3] S. epidermidis inhibits proliferation of C. acnes through succinic acid (2)
4] S. epidermidis can inhibit S. aureus biofilm formation with production of the serine protease **glutamyl endopeptidase (Esp)**. Moreover, when Esp-expressing S. epidermidis induces keratinocytes to produce antimicrobial peptides via immune cell signalling, S. aureus is effectively killed. (4)

An imbalance in skin microbiota distribution, also known as dysbiosis, leads to several skin problems. Sudden over-colonization of the pilosebaceous unit in the skin by C. acne can cause a loss of diversification, loss of metabolic balance, potentially causing acne. Research has also shown that a loss of microbial diversity and loss of balance between C. acnes phylotypes may lead to dysbiosis (3).

The interaction among the skin microbiome on either balanced skin or skin with dysbiosis have been depicted using a simple MATLAB Model.

**Assumptions of the Model**
The crucial assumptions made in the MATLAB model are as follows:

1] The skin is modelled through an agent based model consisting of a two-dimensional grid on MATLAB, representing a part of the skin which is known as the face & scalp sebaceous unit.

2] In balanced skin conditions the distribution of skin microbiota is assumed to be 70% C. acnes, 20% S. epidermidis, 1% S.aureus and 9% of other bacteria. (4)

3] The number of square units in the grid signifies the population density of the different bacteria where each colour is associated with one bacteria. The population density depends on the growth and death rate of each type of bacteria.

4] The growth and death rates are assumed to be proportional to the concentration of a certain corresponding metabolites secreted in the skin. The constants of proportionality have been assumed arbitrarily to fit the model and do not represent actual values.

5] The proportionality relationships that we assumed in the model are as follows:

  * Growth rate of C.acnes and S.epidermidis is constant

  * Death rate of C.acnes is proportional to the concentration of Succinic acid

  * Death rate of S.epidermidis is proportional to the concentration of Propionic acid

  * Growth rate of S.aureus is proportional to the concentration of coproporhyrin III

  * Death rate of S.aureus is proportional to the concentration of glutamyl endopeptidase (Esp)

6] During dysbiosis there is a change in the values of proportionality constants for the growth and death rates leading to imbalance in bacterial population density.

**References**

(1) MATLAB. version 9.10.0.1602886 (R2021a). Natick, Massachusetts: The MathWorks Inc.; 2021.

(2) Claudel JP, Auffret N, Leccia MT, Poli F, Corvec S, Dreno B. Staphylococcus epidermidis: a potential new player in the physiopathology of acne?. Dermatology. 2019 ; 235 (4) : 287 - 94.

(3) Fourniere M, Latire T, Souak D, Feuilloley MG, Bedoux G. Staphylococcus epidermidis and Cutibacterium acnes: two major sentinels of skin microbiota and the influence of cosmetics. Microorganisms. 2020 Nov ; 8 (11) : 1752.

(4) Byrd Allyson L, Yasmine B, Segre Julia A. The human skin microbiome [J]. Nat Rev Microbiol. 2018 ; 16 : 143 - 55.
