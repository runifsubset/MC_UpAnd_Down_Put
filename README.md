# Tarification par Monte Carlo d'une Option Put européenne de type Up-and-Out

author: "Marcel Héritier K."
date: "2023-12-21"

Dans ce tutoriel, nous voyons comment utiliser la méthode de simulation de Monte Carlo pour évaluer les produits financiers dérivés. La notation mathématique et les exemples sont tirés du livre Implementing Derivatives Models de Les Clewlow et Chris Strickland.

La valorisation des produits financiers dérivés par des simulations de Monte Carlo n'est possible qu'en utilisant les mathématiques financières de l'évaluation neutre du risque et en simulant des trajectoires d'actifs neutres du point de vue du risque. La formule de prix de l'espérance risque-neutre en temps continu est donnée par :

[![\\ \begin{equation}\LARGE \\ \frac{C_t}{B_t} = \mathbb{E}_{\mathbb{Q}}[\frac{C_T}{B_T}\mid F_t] \\ \end{equation}](https://latex.codecogs.com/svg.latex?%5C%5C%20%5Cbegin%7Bequation%7D%5CLARGE%20%5C%5C%20%5Cfrac%7BC_t%7D%7BB_t%7D%20%3D%20%5Cmathbb%7BE%7D_%7B%5Cmathbb%7BQ%7D%7D%5B%5Cfrac%7BC_T%7D%7BB_T%7D%5Cmid%20F_t%5D%20%5C%5C%20%5Cend%7Bequation%7D)](#_)


# Dynamique d'un MBG

Ici, nous disposons d'un taux d'intérêt constant, le facteur d'actualisation est donc $\exp(-rt)$, et la dynamique des actions est modélisée par le mouvement brownien géométrique (GBM).

La solution suivante s'applique au prix de l'action S dans le cadre
d'une dynamique neutre à l'égard du risque :

$S_{t+\Delta t}=S_{t}\exp\left(\nu\Delta t+\sigma\sqrt{\Delta t}\epsilon_{i}\right)$ où $\nu=r-\frac{1}{2}\sigma^{2}$
 
 
## Particularités des options barrières
 
Lors de la détermination du prix d'options complexes ou exotiques dépendant d'un scénario, un produit très répandu est l'option à barrière. Il s'agit d'options européennes standard à expiration, mais elles cessent d'exister ou n'existent que si le prix du sous-jacent franchit une barrière prédéterminée. Ce niveau de barrière peut avoir un seuil de déclenchement continu ou discret $\tau$.


Pour une option _barrière_ du type *Up-and-out*, nous avons :
$C_{T}=f(S_{T})=(K-S_{T})^{+}\times\mathds{I}_{\left(\max\limits _{t\in\tau}S_{t}<H\right)}$
Pour autant que, pour tout $m\in M$, 

  * Si $t\in\tau$ et $S_t\geq H$, alors $C_T = 0$
  * Sinon $t\notin\tau$ et $S_t < H$, alors $C_T = \max (0,\quad K-S_T)$
