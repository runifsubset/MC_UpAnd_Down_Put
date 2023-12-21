# Tarification par Monte Carlo d'une Option Put européenne de type Up-and-Out

Dans ce tutoriel, nous voyons comment utiliser la méthode de simulation de Monte Carlo pour évaluer les produits financiers dérivés. La notation mathématique et les exemples sont tirés du livre Implementing Derivatives Models de Les Clewlow et Chris Strickland.

La valorisation des produits financiers dérivés par des simulations de Monte Carlo n'est possible qu'en utilisant les mathématiques financières de l'évaluation neutre du risque et en simulant des trajectoires d'actifs neutres du point de vue du risque. La formule de prix de l'espérance risque-neutre en temps continu est donnée par :

[![\\ \begin{equation}\LARGE \\ \frac{C_t}{B_t} = \mathbb{E}_{\mathbb{Q}}[\frac{C_T}{B_T}\mid F_t] \\ \end{equation}](https://latex.codecogs.com/svg.latex?%5C%5C%20%5Cbegin%7Bequation%7D%5CLARGE%20%5C%5C%20%5Cfrac%7BC_t%7D%7BB_t%7D%20%3D%20%5Cmathbb%7BE%7D_%7B%5Cmathbb%7BQ%7D%7D%5B%5Cfrac%7BC_T%7D%7BB_T%7D%5Cmid%20F_t%5D%20%5C%5C%20%5Cend%7Bequation%7D)](#_)
