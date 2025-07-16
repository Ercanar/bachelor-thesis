#align(top + right, image("img/Universitaet_Logo_RGB.svg"))
#place(horizon + center, dy: -6em, text(size: 30pt)[
  *Arctic Amplification and \
  Feedback Separation in a \
  Simple Global Climate Model*
])

#place(horizon + center, line(length: 100%))

#place(horizon + center, dy: 3em, text(size: 20pt)[
  BSc. Physics - Thesis \
  Hannes Wendt
])

#place(bottom + center, text(size: 15pt)[
  Advisors: \
  Dr. rer. nat. Sebastian Bathiany \
  Prof. Dr. Katharina Krischer
])

#pagebreak()
#set page(numbering: "I")
#counter(page).update(2)

// SaaSified Equation numbering & referencing
#set math.equation(numbering: "(1)")
#show ref: it => {
  let eq = math.equation
  let el = it.element

  if el != none and el.func() == eq {
    $#numbering(
      el.numbering,
      ..counter(eq).at(el.location()))$
  } else { it }
}

#set math.accent(size: 150%)

#set par(justify: true)

#outline()
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#set heading(numbering: "1.1")

= Preface
In this study the Monash simple climate model will be investigated.
Specifically, its ability to simulate arctic amplification will be tested.
Furthermore, a feedback separation will be done.
The findings will be compared to values of bigger, more complex models.



= The Monash simple climate model
The Monash Simple Climate Model (MSCM) is based on the globally resolved energy balance (GREB) model.
It was created by Dietmar Dommenget and Janine Flöter in 2011 and released alongside a paper in the journal "Climate Dynamics".
This paper "Conceptual understanding of climate change with a globally resolved energy balance model" aimed to test
how simple of a climate model one can use to still understand core concepts of climate change.
They succeeded with that task, creating a model with severe limitations,
which is still able to predict the temperature change that the IPCC model simulation results showed. @Dommenget2011

In 2013 Dommenget created an interactive website of the model with the help of his colleagues.
The website allows one to easily disassemble the climate into parts, leading to a good understanding of the processes.
The data is pregenerated and not simulated directly, therefore making it impossible to use the website to conduct experiments other than those already on there.


== Functionality
The MSCM simulates several different processes of the climate and contains several feedbacks.
These are: solar radiation, thermal radiation, a hydrological cycle, sensible heat, advection, diffusion, sea ice and a deep ocean.
Furthermore, a heat flux correction is performed to more closely match more accurate models.
The feedback mechanisms that are simulated include: temperature feedback, water vapor feedback and albedo feedback. @monash

The model has a temporal resolution of 12 hours, therefore rendering it unable to compute processes that occur on an hourly timescale.
The spacial resolution is 3.75° x 3.75°, which is approximately 420km x 420km.
A consequence being that rather local climate elements cannot be simulated accurately, if at all. @mscm-code

The MSCM model has a one layer atmosphere, but applies a temperature flux correction to account for the weaknesses of the atmosphere model.
This is realized by the subroutine called "qflux_correction", which changes the infrared emissivity from one to approximately $epsilon = 0.8$.
The qflux corrections take topography into account and depend on humidity, CO2 and cloud cover.
For further understanding of how the model works, I suggest using the open source code of the model. See @mscm-code.

#pagebreak()

= Theory
In this section, the relevant processes and equations used in @results will be explained.

== Climate sensitivity
Climate sensitivity is the change in surface temperature of the earth when a doubling of the CO2 is introduced and a new steady state is reached.
It includes all processes of the climate system like land surface, sea surface, ice, vegetation, ocean, atmosphere, clouds etc.
Climate models aim to approximate that value by simulating the climate system with varying complexity.
The first approximation of the value was done by Arrhenius in 1896 by only considering energy balance factors, estimating it to be 1.5K. @Arrhenius

The Intergovernmental Panel on Climate Change (IPCC) compiled the results of numerous climate models in 2021 in their sixth assessment report.
The best estimate of that report gave a climate sensitivity of 2.5K to 4K. @IPCC_2023


== Feedbacks
Feedbacks are processes whose reactions to a given state influence the state itself,
leading to an altered state and therefore an altered reaction to that new state.
This can lead to self-amplifying processes which also happened in the past (e.g. snowball earth).

=== Feedback types and arctic amplification
Climate feedbacks include, but are not limited to: Planck feedback, albedo feedback, cloud feedback, water vapor feedback and lapse rate feedback.
These are the feedback mechanisms most commonly found within climate models.
Additional feedbacks like vegetation feedbacks are not simulated in the MSCM and therefore not mentioned further.

The Planck feedback is the first feedback considered when dealing with climate and is part of every model.
It describes the increase in black body radiation when the surface temperature increases,
therefore cooling the surface because infrared radiation is emitted.

Surface albedo feedback describes the influence of the reflectivity of surfaces on the temperature.
When ice melts due to warmer climate the reflectivity will decrease, leading to a further warming, leading to more ice melting.

Cloud feedback is the main contributor to the uncertainty of climate sensitivity in the IPCC report,
which shows positive and negative values in the results of general circulation models (GCMs). @IPCC_2023 \
If warmer climate produces more low-altitude clouds, the feedback may be negative (cooling)
since more incoming short wave radiation is reflected.
But a warmer climate could also change clouds in a way that the effect is positive.
A more in-depth discussion on that is found in @Stephens2005.

The water vapor feedback is a strongly positive one.
Water vapor is the most impactful greenhouse gas as found in @Schmidt2010 in 2010.
Warmer air can also contain more water vapor, leading to a stronger greenhouse effect.

Lapse rate feedback describes the influence of the coupling between surface air and the top of the atmosphere (TOA).
This coupling leads to different resulting behaviors depending on the latitude.
In the tropics, the high convection creates a very strong coupling,
leading to a steepening of the moist adiabatic lapse rate.
Therefore, more latent heat is released into the atmosphere,
resulting in a smaller increase in surface temperature to balance out a given TOA imbalance. @Pithan2014

The lapse rate feedback is therefore negative in the tropics.
In the arctics, the surface air is colder and dense; there is almost no convection,
coupling the surface air to the TOA.
Therefore, radiation is the primary coupling mechanism, resulting in a higher surface temperature difference
to balance out a given TOA imbalance.
The lapse rate feedback is positive in the arctics. @Pithan2014

Arctic amplification is the tendency of the higher latitudes of the globe to respond more to a given forcing than regions around the equator.
@Pithan2014 describes that phenomenon in more detail. The authors outline the main contributors of arctic amplification as albedo feedback and lapse rate feedback.

== Feedback separation and analysis
To do the feedback separation, the methodology of @Dufresne2008, @Langen2012 and @Mauritsen2013 will be followed.
A climate system in equilibrium is disturbed at the TOA by an initial forcing $F$.
That forcing will offset the radiation balance by $Delta R$,
which induces a change in surface temperature until a new steady state is reached.
That problem can be linearized to $ Delta R = F + lambda Delta T $ <linear>
with $lambda$ being the feedback factor.
$lambda$ is then decomposed into several additive, mutually independent feedback factors,
each representing a different feedback mechanism.
$ lambda = lambda_"temperature" + lambda_"albedo" + lambda_"clouds" + lambda_"water vapor" $ <lambda>
$lambda$ must be negative to yield a stable climate system.
The value of $lambda_"temperature"$ can be obtained by a simulation with no other feedbacks active.
$ lambda_"temperature" = - F/(Delta T_F) $ <lambdaT> with $Delta T_F$ being the change in surface temperature. @Mauritsen2013

In the MSCM, the Planck feedback and the lapse rate feedback are not separated,
instead being compounded: $lambda_"temperature" = lambda_"Planck" + lambda_"lapse rate"$.

=== Imposed feedbacks
In a system where one feedback is imposed while the other feedbacks are not,
that imposed feedback can be considered a kind of forcing.
Because it is acting alongside the temperature feedback, the following equation is satisfied:
$ lambda_"feedback" dot Delta T = - lambda_"temperature" dot Delta T_"feedback" $
with $Delta T$ being the surface temperature difference between a 1xCO2 and 2xCO2 run with all feedbacks unmodified.
From that equation, the feedback factor $lambda_"feedback"$ can be isolated:
$ lambda_"feedback" = - lambda_"temperature" (Delta T_"feedback")/(Delta T) $ <feedbackim>

=== Locked feedbacks
In a system where one or two feedbacks are locked to a control state, they can be viewed as a forcing.
Like with the imposed feedbacks, a $accent(lambda, ~)$ can be derived for these experiments.
When e.g. water vapor and cloud feedback are locked, one can obtain an estimation for
$ accent(lambda, ~)_"albedo" = - (lambda_"temperature" + F/(Delta accent(T, ~)_"albedo")) $ <feedbacklo>
When only one feedback is locked, the $accent(lambda, ~)$ for two feedbacks can be obtained with the same formula.
This $accent(lambda, ~)$ represents the factor of both feedbacks acting at the same time.

=== Feedback synergy
With the different factors of feedbacks and their combinations obtained with locking feedbacks,
one can observe that the factor of two feedbacks is not the same as the sum of the individual feedback factors.
This difference is known as feedback synergy and is defined as:
$ S("feedback1", "feedback2") = accent(lambda, ~)_"feedback1, feedback2" - (accent(lambda, ~)_"feedback1" + accent(lambda, ~)_"feedback2") $ <synergy>



= Experimental setup
As mentioned in the introduction, the data from the interactive website is not usable for a full feedback separation.
Therefore, the open source code from @mscm-code was used and modified to compute the relevant simulations.


== Problems with the model
This section dives deeper into the problem the code base presented when modifying the model to make the experiments possible.
The code of the MSCM model is written in a very loose style and standard.
It is written in Fortran (specifically the Fortran 90 dialect), which is a programming language that provides
an optional framework for enforcing a certain grade of type safety (i.e. the "implicit none" statement),
which was however not used by the model code.
To help development of the code base, various important subroutines were outfitted
with data type annotations describing the shape of used variables.
Furthermore, the use of the "intent" functionality helped with understanding the flow of data within the model
by categorizing values into function input or output parameters or internal temporaries.
Those structural improvements to the model increased code quality and made it easier to understand.
As mentioned before, the model does not have the functionality to conduct experiments that were not intended by the creators when writing the model.
For said experiments, the model had to be able to do two distinct things:

- Chaining simulation runs, i.e. the final state of the first run is used as the initial state of the next run
- Being able to save a given state of the model into a file and later loading it as an initial state of a new run

To achieve those goals, the initialization of the model simulation was separated from the main simulation loop itself.
The initialization defines the first state of a given run and separating it makes it possible to chain runs as needed.
Secondly, the model was modified to contain a whole new subsection named "mo_state".
This section contains all variables that define the state of the model at any given time.
After introducing a separate control program written in C, it was made possible to save the state of a running model,
as well as loading that state as the initial state of a new run.

The code of this thesis is stored in a private GitHub repository.
If you would like access to the code, send me an email at
#link("mailto:hanneswendt22@gmail.com") contaning your GitHub account name.


== Experiments
The experiments mostly followed the methodology of @Mauritsen2013,
since they also conducted a feedback separation but on a much larger and more accurate model.

=== Preparation
The first preparation needed are the values of the feedbacks for the imposing and locking later on.
To accomplish that, a pre-industrial run with a run time of 50 years is simulated to reach a steady state.
From that point, two separate runs are performed for 75 years each, with their whole state recorded and saved.
These two runs feature all feedbacks enabled and not tampered with.
One run is a pre-industrial run (340 ppm CO2) named "CTRL" and the other is a 2xCO2 run (680 ppm) named "2xCO2".

Their only purpose is the gathering of the values used later on.
The second preparation needed is a state from which all the runs to be analyzed are started.
To achieve such a state, @Mauritsen2013 will be followed again.

First, a 50 years pre-industrial run is done, followed by a 15 years run named "spinup" with the feedbacks locked to the CTRL run values.
This achieves a steady state from which the feedback separation can be properly performed.
The final state of the spin-up run is then saved and used as a starting point for all further runs.

=== Feedback separation and arctic amplification
The runs that will be analyzed are launched from the same initial state.
They include every possible combination of 1xCO2 with feedbacks either locked, imposed or free;
the same also applies for 2xCO2.
The naming scheme consists of chained expressions which describe the state of the feedbacks.
For example `X1-A0-V1-C2` refers to the run where CO2 is pre-industrial (`X1`),
albedo feedback is enabled and free (`A0`), water vapor feedback is imposed or locked to CTRL (`V1`)
and cloud feedback is imposed or locked to 2xCO2 (`C2`).
For more information on which runs were done, use @feedback_runs in the appendix.



= Results <results>
The results were obtained using Python scripts to analyze the output of the model.
#figure(
  image("img/some-runs.svg", width: 97%),
  caption: [Some distinct runs are plotted with surface temperature in °C over time in years.]
)


== Feedback separation
To obtain the values of $Delta T_"feedback"$, the mean temperature of a given run (e.g. `X1-A1-V1-C1`)
needs to be subtracted from the mean temperature of a run with a feedback imposed (e.g. `X1-A2-V1-C1`).
In the example, this difference would yield one value of $Delta T_"albedo"$.
Other runs also yield one value, so e.g. `X1-A1-V2-C1` subtracted from `X1-A2-V2-C1`.
The raw temperature values will be listed in their entirety in the appendix, see @feedback_runs.

=== Imposed feedbacks
To calculate the feedback factors using equation @feedbackim, $lambda_"temperature"$ (in short $lambda_T$) is needed
and can be obtained using equation @lambdaT. We therefore need to calculate the value of the initial forcing $F$.
According to @Dommenget2011 and @Dommenget_lecture, the formula used in the MSCM for determining the initial TOA forcing is:
$ F = Delta Q approx Delta epsilon_"atmos" dot sigma dot (0.84 T_"surface")^4 $ <forcing>
with $Delta epsilon_"atmos" approx 0.024$ being the change in the atmosphere emissivity due to the added CO2 and $sigma$ being the Stefan-Boltzmann-constant.
With a $T_"surface" = 286.959$ $K$ the forcing comes out to $F = 4.594$ $W m^(-2)$.
Lastly, one needs the total surface temperature change with all feedbacks active: $Delta T = 2.498$ $K$.
The following table contains the average $Delta T_i$ for each feedback taken from @feedback_runs in the appendix
as well as the calculated values of the feedback factors according to equations @lambdaT and @feedbackim.
#figure(
  table(
    columns: 7,
    table.header(
      [], [Temperature], [Albedo], [Cloud], [Water Vapor], [Sum], [Measured $Delta T$ [K]]
    ),
    [$Delta T_i$ [K]            ], [  0.316], [0.084], [-0.269], [ 2.056], [ 2.187], [2.498],
    [$lambda_i [W m^(-2)K^(-1)]$], [-14.529], [0.487], [-1.565], [11.958], [-3.649], [     ],
  ),
  caption: [Values of temperature composition and feedback factors with imposed feedback.
            The temperature values are averages taken from @feedback_runs.]
) <imposed_table>


=== Locked feedbacks
The locked feedback factors $accent(lambda, ~)_i$ are calculated using equation @feedbacklo.
The values of $lambda_T$ and $F$ are taken from the previous section.
The values of $Delta accent(T, ~)_i$ are again averages taken from the respective parts of @feedback_locked in the appendix.
#figure(
  table(
    columns: 7,
    table.header(
      [], [Albedo], [Cloud], [Water Vapor], [Albedo-Cloud], [Albedo-Vapor], [Cloud-Vapor]
    ),
    [$Delta accent(T, ~)_i$ [K]            ], [0.363], [0.334], [ 2.191], [0.363], [ 2.461], [ 2.191],
    [$accent(lambda, ~)_i [W m^(-2)K^(-1)]$], [1.859], [0.754], [12.432], [1.859], [12.662], [12.432]
  ),
  caption: [
    Values of temperature composition and feedback factors with locked feedback.
    The temperature values are averages taken from @feedback_locked.
  ],
) <locked_table>

#figure(
  image("img/balkendiagrammgeneratorpythonskriptdingskramsoutputdatei.svg", width: 100%),
  caption: [
    The different values of the temperature contributions and sums are shown.
    The values over/under the bars are the averages of the bars.
    The x axis gives information which $Delta T_i$ is shown.
    The values are taken from @feedback_runs and @feedback_locked.
  ]
)



=== Arctic amplification
The results concerning arctic amplification are obtained the same way as imposed feedbacks with the only change being
that the tropics (30° S - 30° N) and the polar regions (60° - 90° S and 60° - 90° N) are done separately.
Therefore the following values are calculated:
$T_"surface, polar" = 259.707$ $K$; $F_"polar" = 3.082$ $W m^(-2)$;
$T_"surface, equatorial" = 297.215$ $K$; $F_"equatorial" = 5.287$ $W m^(-2)$.
#figure(
  table(
    columns: 7,
    table.header(
      [], [Temperature], [Albedo], [Cloud], [Water Vapor], [Sum], [$Delta T$ [K]]
    ),
    [$Delta T_i$, polar [K]                    ], [  0.747], [0.289], [-0.103], [ 1.957], [ 2.890], [3.049],
    [$Delta T_i$, equatorial [K]               ], [  0.199], [0.004], [-0.477], [ 1.978], [ 1.703], [2.210],
    [$lambda_i , "polar" [W m^(-2)K^(-1)]$     ], [ -4.128], [0.391], [-0.139], [ 2.649], [-1.227], [     ],
    [$lambda_i , "equatorial" [W m^(-2)K^(-1)]$], [-26.621], [0.045], [-5.748], [23.823], [-8.501], [     ]
  ),
  caption: [
    Values of temperature composition and feedback factors with imposed feedback, separated into polar regions and tropics.
    The temperature values are averages taken from @feedback_runs.
  ],
) <arctic_table>


== Feedback synergy
The feedback synergy is computed via equation @synergy.
It has to be noted that the feedbacks used in that equation can also be a combination of two feedbacks.
So e.g. $S(A, "CV") = accent(lambda, ~)_"ACV" - (accent(lambda, ~)_A + accent(lambda, ~)_"CV")$.
@locked_table indicates that $Delta T_"ACV"$ was not measured and therefore $accent(lambda, ~)_"ACV"$ cannot be obtained via equation @synergy.
For that reason we extract it from two values that come from previous sections:
$ accent(lambda, ~)_"ACV" = sum_i lambda_i - lambda_T = 10.880 " " W m^(-2) K^(-1) $
The other synergy values are displayed in @sixegg.
#figure(
    image("img/synergy.svg", width: 50%),
    caption: [
      Within the circles, the feedbacks with their factors are displayed.
      The blue numbers on the outside are the values of the synergies.
      All values have [$W m^(-2) K^(-1)$]. Inspired by @Mauritsen2013.
    ],
) <sixegg>



= Discussion
In this section, the results will be explained and compared to the results in @Dufresne2008, @Langen2012 and @Mauritsen2013.


== Feedback separation <feedback-separation>
The values of the feedback factors as well as the $Delta T_i$ from @imposed_table
suggest that the climate simulated within the model is stable.
Reason being, that the $lambda$ of the system is negative:
$ lambda = sum_i lambda_i = -3.649 " " W m^(-2) K^(-1) $
Compared to the values of the aforementioned studies, $-1.24$ $W m^(-2) K^(-1)$ from @Mauritsen2013,
$-1.27$ $W m^(-2) K^(-1)$ from @Dufresne2008 and $-2.0$ $W m^(-2) K^(-1)$ from @Langen2012,
the value of the MSCM is rather low. That indicates a much more stable climate than in bigger models.
Another notable thing to mention is the difference between the measured climate sensitivity
and the sum of the $Delta T_i$, being $Delta (Delta T) = 0.3111$ $K$.
The measured climate sensitivity is the greater of the two values.
The reason behind that difference will be mentioned further in @arctic-amplification and @feedback-synergy.

The temperature feedback has a highly negative value of $lambda_T = -15.651$ $W m^(-2) K^(-1)$,
meaning a small temperature change is necessary to balance out a TOA imbalance when only looking at that feedback.
It is almost four times the feedback factors in the other papers ($-3.45$ $W m^(-2) K^(-1)$, $-4.04$ $W m^(-2) K^(-1)$ and $-4.20$ $W m^(-2) K^(-1)$).
That means that the Planck feedback and/or the lapse rate feedback is severely stronger than it should be.
The forcing $F$ with which $lambda_T$ is calculated (see @forcing) depends on the surface temperature and the change of atmospheric emissivity.
With clear sky conditions, the emissivity of the atmosphere at TOA can lie between $epsilon = 0.756$ and $epsilon = 0.838$,
with a global mean of $epsilon = 0.796$. @Pandey1995

These values are a higher boundary to the mean global emissivity because only clear sky conditions are accounted for.
According to @Nakanishi2025 the atmospheric emissivity will be lowered by the presence of clouds when a warming occurs.
With those facts it is clear that at least the Planck feedback is stronger within the MSCM
compared to other models that use a more realistic emissivity of the atmosphere.
To verify the correctness of the lapse rate feedback, either the code has to be analyzed
or a separation of the temperature feedback into Planck and lapse rate feedback has to be performed.
The MSCM does simulate diffusion and advection, but the code is the most complex, convoluted and long part of the whole model.
A separation of the temperature feedback will be done in @arctic-amplification.
The other feedback factors scale with $lambda_T$, so the following sections will not necessarily be analyzed or compared using $lambda_i$ but rather $Delta T_i$.

The cloud feedback has a negative value, suggesting that clouds cool the climate system and making it more stable.
If compared to the mostly positive or neutral values of the other models ($0.23$ $W m^(-2) K^(-1)$, $0.69$ $W m^(-2) K^(-1)$ and $0.088$ $W m^(-2) K^(-1)$)
a clear discrepancy can be seen.
The cloud model of the MSCM is a very strongly simplified one.
It takes its values mostly from a database of recorded fields of cloud coverage and assigns every cloud a constant albedo.
According to @Stephens2005, "[...] a number of cloud properties, including cloud amount,
cloud height and vertical profile, optical depth, liquid and ice water contents,
and particle sizes affect the radiation budget of earth and are all potentially relevant to the cloud feedback problem."
Most of these properties are not considered in the MSCM, leading to great differences in feedback factors compared to the other models.
More in depth discussion on the cloud model will be done in @feedback-synergy.

The main contributor to warming is the water vapor feedback with a value of $lambda_V = 11.958$ $W m^(-2) K^(-1)$ and a warming of $Delta T_V = 2.056 K$.
If compared to the other models ($1.57 K$, $1.7 K$ and $1.67 K$) it is about 25% higher.
For such a simple model that is quite reasonable and does not point to any big shortcomings with a high certainty.

The albedo feedback is slightly positive. With a warming effect of $Delta T_A = 0.084 K$,
it is near the range of $Delta T_A approx 0.15 K$ to $Delta T_A = 0.3 K$
provided by the papers @Dufresne2008 and @Mauritsen2013.
The MSCM assigns a specific albedo value to all clouds and all ice-covered points ($alpha = 0.35$) and a separate value to all other points ($alpha = 0.1$).
Bigger models, e.g. the ECHAM6 used by @Mauritsen2013, contain some kind of vegetation model, leading to a more detailed and accurate albedo simulation. @ECHAM6

As well as not containing a vegetation model, the MSCM has a rather simple sea ice model, possibly leading to a further lowering of the albedo feedback impact.


== Arctic amplification <arctic-amplification>
When analyzing the spatial differences of the feedback factors, it is clear that some kind of arctic amplification happens within the simulation.
The climate sensitivity of the polar regions is approximately 38% higher than in the tropics and 22% higher than the global mean.

First of all, the temperature feedback factor is closer to zero than the global or equatorial mean.
This indicates a more unstable climate and a more pronounced warming relative to the equatorial region.
Compared to the values in @Langen2012, $lambda_(T, "polar") = -3.5$ $W m^(-2) K^(-1)$ and $lambda_(T, "equatorial") = -5.1$ $W m^(-2) K^(-1)$, the MSCM again makes the climate more stable.
The arctics have an 18% larger feedback factor while the tropics have an over 5 times larger value.
#pagebreak()
According to @Langen2012, one can estimate the Planck feedback with the equation $ lambda_0 approx - 4 epsilon sigma T_("surf")^3 $
With that, we can separate the temperature feedback factors in the respective regions.
Doing that yields values that are shown in @lapserate.
#figure(
  table(
    columns: 5,
    table.header(
      [], [every value $[W m^(-2) K^(-1)]$], [$lambda_T$], [$lambda_0$], [$lambda_"LR"$]
    ),
    table.cell(
      rowspan: 2,
      [MSCM]
    ),
    [polar     ], [ -4.128], [-3.274], [ -0.854],
    [equatorial], [-26.621], [-4.907], [-21.714],
    table.cell(
      rowspan: 2,
      [@Langen2012],
    ),
    [polar]     , [-3.5], [-3.0], [-0.54],
    [equatorial], [-5.1], [-3.5], [-1.6 ]
  ),
  caption: [Values for Planck and lapse rate feedback factors from the MSCM and @Langen2012.],
) <lapserate>

While the differences in Planck feedback are reasonably small,
the biggest discrepancy lies within the highly negative value of the MSCM equatorial lapse rate feedback factor.
It is roughly 13 times larger in magnitude than the corresponding value of the other model.
This points to a weakness of the MSCM's simplicity once again, likely some kind of wrong lapse rate model used within.
It also has to be noted that according to @Pithan2014 the lapse rate feedback should be one of the main contributors to arctic amplification
and therefore the feedback factor should be positive.

The cloud feedback has an effect, cooling the polar regions and the tropics.
The almost daily storms in the tropics are of such size and magnitude that they block a substantial amount of short wave radiation (SWR) from reaching the ground.
But we also know from the previous section that the cloud model of the MSCM is flawed.
Compared to the values of @Langen2012, $Delta T_C = 1.745 K$ for the arctic and $Delta T_C = 1.495 K$ for the tropics,
they are again different in both magnitude and sign.
This points to the same arguments mentioned within @feedback-separation and will be discussed more in @feedback-synergy.

The water vapor feedback is more interesting. It is weaker in the the polar regions than globally or equatorially.
But the equatorial regions themselves have weaker water vapor feedback than the global mean,
despite the more than 10 K higher temperature.
That does not match the theory and points to a inconsistency within the hydrological part of the MSCM.
That suspicion strengthens when the values are compared.
The other model suggest values of $Delta T_V = 2.622 K$ and $lambda_V = 1.8$ $W m^(-2) K^(-1)$ in the arctics
and $Delta T_V = 2.207 K$ and $lambda_V = 2.5$ $W m^(-2) K^(-1)$ in the tropics with a global mean between these values; see @Langen2012.
The source of the inconsistency can be most likely found within the simplicity of the hydrological model.
The logic in the code for that is only 12 lines long and takes real world measured static fields and averages,
leading to possible inconsistencies with the spatial distribution that then leads to the anomalous values of the feedback factors.

The albedo feedback is also strongest in the arctics, while being close to zero in the tropics.
The estimated temperature contribution in the arctics is about $Delta T_A = 0.75 K$.
In contrast stands @Hahn2021, which compares all CMIP5 and CMIP6 models
with regards to feedback temperature contribution in the arctics: $Delta T_A approx 3.8 K$.

This indicates that the MSCM underestimates the impact of the albedo feedback in the arctics.
That discrepancy could be attributed to the model underestimating the albedo of the ice
and overestimating the albedo of ice-free points.
Which would lead to a lower change in albedo, and a lower impact of the albedo feedback.
The average albedo of the MSCM lies between 0.1 and 0.35
while real world measurements reveal it to be close to $alpha = 0.43$. @Marcianesi2021
#pagebreak()
The total feedback factors are $lambda_"polar" = -1.227$ $W m^(-2) K^(-1)$ and $lambda_"equatorial" = -8.501$ $W m^(-2) K^(-1)$,
further strengthening the hypothesis that arctic amplification is a result of the simulation.
The polar region is much more unstable, reacting with a much stronger surface temperature increase to a given forcing
than any other region, especially when compared to the much more stable equatorial region.
Although the MSCM underestimates the effect of arctic amplification severely.

Again there is a difference between the measured $Delta T$ and the sum of the $Delta T_i$.
This time being $Delta (Delta T) = 0.1589 K$ for the arctics and $Delta (Delta T) = 0.5072 K$ for the tropics.
That indicates that the effect on the sum is a process that warms the global climate, and doing so stronger in the tropics and weaker in the arctics.
This process could be another feedback that wasn't separated out or a possible correction within the model that was somehow not considered in the separation process.
@Mauritsen2013 implies that if $Delta (Delta T)$ gets substantially big, a meaningful feedback separation has not been achieved.

This leads to the natural conclusion that either the MSCM is incapable of having a meaningful feedback separation performed on it
or that some kind of error was done following the methodology of @Mauritsen2013 to try to do the feedback separation on the MSCM.


== Feedback synergy <feedback-synergy>
The feedback synergy values in @sixegg reveal a clear shortcoming of the MSCM model.
The cloud feedback seems to have no impact on feedback factors when acting alongside a different feedback.
This indicates a very simplified or nonexistent cloud feedback mechanism within the code base.
Apart from that abnormality, the other values also seem to behave rather curiously compared to other studies and papers.
All feedbacks seem to have a negative synergy with each other in every combination.
Every feedback is stronger on its own.
The fact that the synergy is not just zero implies that the feedbacks do interact with each other.
The values of the synergy of vapor and albedo are also the same.
This result stands in contradiction to results from more accurate models as seen in @Mauritsen2013.
The reason for the inaccuracy concerning synergy most likely comes from the cloud model once again
while also impacting the other values.
Therefore the MSCM is not suitable for locking feedback as well as calculating synergies between feedbacks.
Again this presents a shortcoming of the MSCM model and possible solutions will be discussed further in the next section.


== Possible corrections for the model
The first upgrade to the model that could be looked into is a better cloud model.
The current cloud model is not a feedback mechanism and therefore inhibits deeper analysis of e.g. feedback synergy.

The next correction that could be made is a modified lapse rate feedback part of the thermal model.
This allows the partial temperature contribution of the temperature feedback to reach realistic values.

These fixes may allow for the model to be suitable for a meaningful feedback separation if implemented correctly.



#pagebreak()
= Conclusion
The MSCM model is capable of simulating the climate rather accurately considering the sheer simplicity of the model.
Especially the global mean climate sensitivity and the corresponding total global feedback factor
match the values presented in papers that analyzed bigger models like @Dufresne2008 and @Mauritsen2013.
But the simplicity limits the depth of the correctness and the values deviate strongly the more they are analyzed.
The lapse rate feedback factor is way too strong in amplitude when compared to other models.
This leads to a unrealistic distribution and amplification of the different feedback factors.
Moreover, the feedback synergies all being negative indicates an overarching restriction of the model.
Finally, the cloud model that emulates a feedback clearly shows the cuts that were done when the model was created.

But the MSCM still fulfilled the intended role, being able to simulate core concepts of climate change
with very little computational power required and the whole model being simple enough
so that every change can be physically explained.
It is very likely that the feedback separation was not meaningful.
Therefore a further investigation into the topic using the MSCM should be done
to rule out any errors in following the correct methodology.
If there was no error, the MSCM is not suitable to perform a feedback separation on.
Corrections to the model to increase the accuracy of all values and principles investigated in this thesis,
while still maintaining the overall accuracy of the model, could be further researched in another thesis.



#pagebreak()
= Appendix
#set par(justify: false)
#figure(
  table(
    columns: 6,
    align: center,
    table.header(
      [],
      [Simulation 1],
      [Simulation 2],
      [Difference in gmean, global [K]],
      [Difference in gmean, polar [K]],
      [Difference in gmean, tropics [K]]
    ),
    [$Delta T$], [X2], [X1], [2.4980], [3.0485], [2.2100],
    table.cell(
      rowspan: 8,
      breakable: false,
      [$Delta T_F$],
    ),
    [X2-A1-V1-C1], [X1-A1-V1-C1], [0.33352], [0.76754], [0.21610],
    [X2-A1-V1-C2], [X1-A1-V1-C2], [0.32268], [0.75104], [0.20061],
    [X2-A1-V2-C1], [X1-A1-V2-C1], [0.30983], [0.74196], [0.19620],
    [X2-A1-V2-C2], [X1-A1-V2-C2], [0.29975], [0.72702], [0.18167],
    [X2-A2-V1-C1], [X1-A2-V1-C1], [0.33302], [0.76678], [0.21606],
    [X2-A2-V1-C2], [X1-A2-V1-C2], [0.32236], [0.75144], [0.20057],
    [X2-A2-V2-C1], [X1-A2-V2-C1], [0.30930], [0.74029], [0.19615],
    [X2-A2-V2-C2], [X1-A2-V2-C2], [0.29924], [0.72695], [0.18163],
    table.cell(
      rowspan: 8,
      breakable: false,
      [$Delta T_A$],
    ),
    [X1-A2-V1-C1], [X1-A1-V1-C1], [0.08629], [0.29433], [0.00396],
    [X1-A2-V1-C2], [X1-A1-V1-C2], [0.08534], [0.29245], [0.00390],
    [X1-A2-V2-C1], [X1-A1-V2-C1], [0.08246], [0.28521], [0.00361],
    [X1-A2-V2-C2], [X1-A1-V2-C2], [0.08206], [0.28525], [0.00354],
    [X2-A2-V1-C1], [X2-A1-V1-C1], [0.08579], [0.29357], [0.00392],
    [X2-A2-V1-C2], [X2-A1-V1-C2], [0.08503], [0.29284], [0.00386],
    [X2-A2-V2-C1], [X2-A1-V2-C1], [0.08193], [0.28353], [0.00356],
    [X2-A2-V2-C2], [X2-A1-V2-C2], [0.08155], [0.28518], [0.00350],
    table.cell(
      rowspan: 8,
      breakable: false,
      [$Delta T_V$],
    ),
    [X1-A1-V2-C1], [X1-A1-V1-C1], [2.06908], [1.98157], [1.98156],
    [X1-A1-V2-C2], [X1-A1-V1-C2], [2.06975], [1.96492], [1.99357],
    [X1-A2-V2-C1], [X1-A2-V1-C1], [2.06526], [1.97245], [1.98120],
    [X1-A2-V2-C2], [X1-A2-V1-C2], [2.06648], [1.95772], [1.99321],
    [X2-A1-V2-C1], [X2-A1-V1-C1], [2.04539], [1.95599], [1.96166],
    [X2-A1-V2-C2], [X2-A1-V1-C2], [2.04683], [1.94089], [1.97462],
    [X2-A2-V2-C1], [X2-A2-V1-C1], [2.04154], [1.94595], [1.96130],
    [X2-A2-V2-C2], [X2-A2-V1-C2], [2.04335], [1.93323], [1.97427],
    table.cell(
      rowspan: 8,
      breakable: false,
      [$Delta T_C$],
    ),
    [X1-A1-V1-C2], [X1-A1-V1-C1], [-0.26386], [-0.08628], [-0.47572],
    [X1-A1-V2-C2], [X1-A1-V2-C1], [-0.26319], [-0.10294], [-0.46371],
    [X1-A2-V1-C2], [X1-A2-V1-C1], [-0.26481], [-0.08816], [-0.47578],
    [X1-A2-V2-C2], [X1-A2-V2-C1], [-0.26359], [-0.10289], [-0.46377],
    [X2-A1-V1-C2], [X2-A1-V1-C1], [-0.27470], [-0.10278], [-0.49121],
    [X2-A1-V2-C2], [X2-A1-V2-C1], [-0.27326], [-0.11788], [-0.47824],
    [X2-A2-V1-C2], [X2-A2-V1-C1], [-0.27546], [-0.10351], [-0.49127],
    [X2-A2-V2-C2], [X2-A2-V2-C1], [-0.27365], [-0.11623], [-0.47829],
  ),
  caption: [
    The raw data values from the model,
    extracted from output files using a Python script.
    The different $Delta T_i$ refer to the changes in temperature;
    the differences in the last three columns are calculated via
    $Delta T_i = "gmean"("Simulation1") - "gmean"("Simulation2")$,
    where gmean is an internal function of the model.
  ],
) <feedback_runs>

#figure(
  table(
    columns: 6,
    table.header(
      [], [Simulation 1], [Simulation 2], [Difference in gmean, global [K]], [Difference in gmean, polar [K]], [Difference in gmean, tropics [K]]
    ),
    [$Delta accent(T, ~)_A$],    [X2-A0-V1-C1], [X1-A0-V1-C1], [0.36261], [0.87321], [0.21745],
    [$Delta accent(T, ~)_C$],    [X2-A1-V1-C0], [X1-A1-V1-C0], [0.33352], [0.76754], [0.21610],
    [$Delta accent(T, ~)_V$],    [X2-A1-V0-C1], [X1-A1-V0-C1], [2.19064], [2.29656], [2.09882],
    [$Delta accent(T, ~)_"AC"$], [X2-A0-V1-C0], [X1-A0-V1-C0], [0.36261], [0.87321], [0.21745],
    [$Delta accent(T, ~)_"AV"$], [X2-A0-V0-C1], [X1-A0-V0-C1], [2.46070], [3.00677], [2.18132],
    [$Delta accent(T, ~)_"CV"$], [X2-A1-V0-C0], [X1-A1-V0-C0], [2.19064], [2.29656], [2.09882],
  ),
  caption: [
    The raw data values from the model,
    extracted from output files using a Python script.
    The different $Delta accent(T, ~)_i$ refer to the changes in temperature;
    the differences in the last three columns are calculated via
    $Delta accent(T, ~)_i = "gmean"("Simulation1") - "gmean"("Simulation2")$,
    where gmean is an internal function of the model.
  ]
) <feedback_locked>



#pagebreak()
#bibliography("sources.bib", style: "ieee")
