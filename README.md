
# Tarification par Monte Carlo d'une Option Put européenne de type Up-and-Out



[![Project Status](https://www.repostatus.org/badges/latest/active.svg?color=green)](https://github.com/runifsubset/MC_UpAnd_Down_Put) 

---
Marcel Héritier K.
2023-12-21"
---



Dans ce tutoriel, nous voyons comment utiliser la méthode de simulation de Monte Carlo pour évaluer les produits financiers dérivés. La notation mathématique et les exemples sont tirés du livre Implementing Derivatives Models de Les Clewlow et Chris Strickland.

Une option « knok-out » est un type d'option de barrière. Les options à barrière sont généralement classées comme knock-out ou knock-in. Une option knock-out cesse d'exister si l'actif sous-jacent atteint une barrière prédéterminée pendant sa durée de vie. Une option « knock-in » est en fait l'inverse de l'option « knock-out ». Dans ce cas, l'option n'est activée que si l'actif sous-jacent atteint une barrière de prix prédéterminée.

Les options knock-out sont considérées comme des options exotiques et sont principalement utilisées par les grandes institutions sur les marchés des matières premières et des devises. Elles peuvent également être négociées sur le marché de gré à gré (OTC).


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

[![\\ \begin{equation} \\ C_{T}=f(S_{T})=(K-S_{T})^{+}\times\mathbb{I}_{\left(\max\limits _{t\in\tau}S_{t}<H\right)} \\ \end{equation}](https://latex.codecogs.com/svg.latex?%5C%5C%20%5Cbegin%7Bequation%7D%20%5C%5C%20C_%7BT%7D%3Df(S_%7BT%7D)%3D(K-S_%7BT%7D)%5E%7B%2B%7D%5Ctimes%5Cmathbb%7BI%7D_%7B%5Cleft(%5Cmax%5Climits%20_%7Bt%5Cin%5Ctau%7DS_%7Bt%7D%3CH%5Cright)%7D%20%5C%5C%20%5Cend%7Bequation%7D)](#_)

Pour autant que, pour tout $m\in M$, 

  * Si $t\in\tau$ et $S_t\geq H$, alors $C_T = 0$
  * Sinon $t\notin\tau$ et $S_t < H$, alors $C_T = \max (0,\quad K-S_T)$
