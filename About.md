# Simulating Random Encounters in Population

This app attempts to estimate the average number of encounters amongst a subset of a population given several parameters such as the total population, the area over which the population is spread, total elapsed time, range within which to detect encounters, and percentage of population moving each hour.

### Algorithm

The simulation starts by randomly distributing the population over a square space equal in size to the conference area. The algorithm then assigns unique IDs to the active personas. The app allows the user to select the percentage of population that are actively moving each hour. This number can range from 20% to 100%. For this selected percentage, the algorithm moves a randomly selected sample of the population each hour. This sample changes every hour, so a person might be moving on a given hour but not the following hour (unless if the user elects to move 100% of the population). The speed and direction of the motion for each person is drawn from two normal distributions, one in the X direction and one in the Y direction.  For each simulated hour, the algorithm calculates all of the distances between all active personas and stores, for each persona, the cumulative sum of the number of active personas that came within the selected beacon range.  This cumulative sum is displayed as a histogram.

To simulate the fact that all of the active personas will be starting from one location, the HP booth, initial positions of the active personas are distributed over a much smaller range, in X and Y, than those for the rest of the population. 

### Caveats

The algorithms used in the simulations don't take into account many higher order effects that will have an impact on the number we are trying to estiamte here, the average number of encounters. Thus, *__the values displayed here should be considered as lower limits. The actual expected number of encounters might indeed be much higher than the numbers presented here.__*

The algorithms we developed here __don't account__ for the following:

* Encounters which occur when personas are moving. For simpliciy, we only count encounters once every hour. If an encounter occurs between two personas while they are moving within the hour, that encounter won't be added. 
* The existance of subgroups within active personas, such as friends, colleagues, etc. who would tend to hang out together. This would have the effect of increasing the number of encounters.
* Clustering: we expect active personas to cluster in different places such as presentation rooms, coffe-break areas, food courts, booths, bathrooms, etc. This would have the effect of increasing the number of encounters.
* Conference might be on different levels. 
* Some personas might be active for part of the time and not the whole time. This would have the effect of decreasing the number of encounters.
* We are not accounting for encounters outside of the conference. This would have the effect of increasing the number of encounters.



