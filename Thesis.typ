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

#pagebreak()

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
  Advisor: Dr. rer. nat. Sebastian Bathiany \
  First Examiner: Prof. Dr. Katharina Krischer \
  Second Examiner: Prof. Dr. Niklas Boers \ \
  Submission Date: 28.07.2025 // TODO letzter change (vlt 27.07)
])

#pagebreak()
#set page(numbering: "I")
#counter(page).update(3)


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

// TODO SAßIFIZIEREN!!!

= Preface
In this thesis, the Monash simple climate model will be examined.
A feedback separation will be done with the imposed feedback method
to obtain the partial temperature contributions of the feedback mechanisms.
A spatial analysis of these values will then be done to investigate how well the model simulates arctic amplification.
Furthermore, an analysis of synergy between the different feedbacks will be done.
Lastly, the shortcomings of the model will be analyzed and possible improvements are presented.



= Introduction
== Climate system and climate sensitivity
The Earth's climate system is an interconnected ensemble of the five subsystems:
atmosphere, hydrosphere, cryosphere, lithosphere and biosphere.
They all influence each other and their whole state is characterized as the climate system.
To quantify the complex reaction of the climate system to relevant scenarios,
e.g. the warming induced by man-made climate change, the term "climate sensitivity" was created.
Climate sensitivity is the change in surface temperature of the earth
when a doubling of the $"CO"_2$ is introduced and a new steady state is reached.
To better understand the response of the climate system, research turned to simulating increasingly complex climate models.

== Climate models
The most simple climate model is a zero dimensional energy balance model.
It only considers shortwave radiation from the sun hitting the earth, and the earth emitting black body radiation back out.
Additions to such a model could entail a spatial difference of the surface temperature, an atmosphere, oceans etc.

Eventually the models got more and more complex alongside the innovation of computational technology,
culminating in the highly complex earth system models (ESMs) of today.

One of the main purposes of climate models is to investigate what the value of the climate sensitivity is.
The first approximation of the value was done by Arrhenius in 1896
by only considering energy balance factors, estimating it to be 1.5 K @Arrhenius.

The Intergovernmental Panel on Climate Change (IPCC) is the United Nations body for assessing the science related to climate change.
The objective of the IPCC is to provide governments with scientific information that they can use to develop climate policies.
The IPCC does not conduct their own scientific research but rather compiles the information into assessment reports.
This is done by experts volunteering their time to complete parts of these reports. @IPCC

Since a lot of different models are parts of the reports, a better estimate for the climate sensitivity can be made.
In the first assessment report of the IPCC the climate sensitivity is estimated to be between 1.5 K and 4.5 K @IPCC1992.

In 2021, the sixth assessment report (AR6) was published.
The best estimate of that report gave a climate sensitivity of 2.5 K to 4 K @IPCC_2023.


== The Monash simple climate model
The Monash Simple Climate Model (MSCM) is based on the globally resolved energy balance (GREB) model.
It was created by Dietmar Dommenget and Janine Flöter in 2011 and released alongside a paper in the journal "Climate Dynamics".
This paper "Conceptual understanding of climate change with a globally resolved energy balance model" aimed to test
how simple of a climate model one can use to still understand core concepts of climate change.
They succeeded with that task, creating a model with severe limitations,
which is still able to predict the temperature change that the IPCC model simulation results showed @Dommenget2011.

In 2013 Dommenget created an interactive website of the model with the help of his colleagues.
The website allows one to easily disassemble the climate into parts, leading to a good understanding of the processes.

The MSCM simulates several different processes of the climate and contains several feedbacks.
These are: solar radiation, thermal radiation, a hydrological cycle, sensible heat, advection, diffusion, sea ice and a deep ocean.
Furthermore, a heat flux correction is performed to more closely match more accurate models.
The feedback mechanisms that are simulated include: temperature feedback, water vapor feedback and albedo feedback @monash.

The model has a temporal resolution of 12 hours, therefore rendering it unable to compute processes that occur on an hourly timescale.
The spatial resolution is 3.75° x 3.75°, which is approximately 420km x 420km.
A consequence being that rather local climate elements cannot be simulated accurately, if at all @mscm-code.

The MSCM model has a one-layer atmosphere, but applies a temperature flux correction to account for the weaknesses of the atmosphere model.
This is realized by the subroutine called `qflux_correction`, which changes the infrared emissivity from one to approximately $epsilon = 0.8$.
The qflux corrections take topography into account and depend on humidity, $"CO"_2$ and cloud cover.
For further understanding of how the model works, I suggest using the open source code of the model. See @mscm-code.
#figure(
  image("img/MSCM-sample.png", width: 89%),
  caption: [The surface temperature map depicting the yearly mean temperature of an pre-industrial steady state.
            The image clearly shows the temperature differences in latitudes, with -52°C in Antarctica and up to 32°C in the tropical regions.
            The colder temperatures within high mountain ranges, e.g. Cordilleras and Himalayas, can also be seen.
            The data used was the raw output of the model and was processed by a self-made Python script.]
)



#pagebreak()
= Theory and methodology
In this section, the relevant processes and equations used in @results will be explained.

== Feedbacks
Feedbacks are processes whose reactions to a given state influence the state itself,
leading to an altered state and therefore an altered reaction to that new state.

#figure(
  image("img/7_10.png", width: 100%),
  caption: ["Global mean climate feedbacks estimated in abrupt 4x$"CO"_2$ simulations
            of 29 CMIP5 models (light blue) and 49 CMIP6 models (orange),
            compared with those assessed in this Report (red).
            The white line, black box and vertical line indicate the mean,
            66% and 90% ranges, respectively." \ Image and caption directly from @IPCC_AR6.
            ]
) <feedback-factors>

Climate feedbacks include, but are not limited to:
Planck feedback, albedo feedback, cloud feedback, water vapor feedback and lapse rate feedback.
These are the feedback mechanisms most commonly found within climate models.
Additional feedbacks like vegetation feedbacks are not simulated in the MSCM and therefore not mentioned further.
The values of the feedback factors from the IPCC are shown in @feedback-factors.
The temperature contributions of the feedbacks will be explained further.

The Planck feedback is the first feedback considered when dealing with climate and is part of every model.
It describes the increase in black body radiation when the surface temperature increases,
therefore cooling the surface because infrared radiation is emitted.

Surface albedo feedback describes the influence of the reflectivity of surfaces on the temperature.
When ice melts due to warmer climate the reflectivity will decrease, leading to a further warming, leading to more ice melting.
According to @IPCC_AR6 the albedo feedback warms the climate by $Delta T_A = 0.77 K$ when the $"CO"_2$ quadruples.

Cloud feedback is the main contributor to the uncertainty of climate sensitivity in the IPCC report,
which shows positive and negative values in the results of general circulation models (GCMs) @IPCC_2023.

According to @IPCC_AR6 the cloud feedback warms the climate by $Delta T_C = 0.64 K$ when the $"CO"_2$ quadruples.
If warmer climate produces more low-altitude clouds, the feedback may be negative (cooling)
since more incoming shortwave radiation is reflected.
But a warmer climate could also change clouds in a way that the effect is positive.
A more in-depth discussion on that is found in @Stephens2005.

The water vapor feedback is a strongly positive one.
Water vapor is the most impactful greenhouse gas as found in @Schmidt2010.
Warmer air can also contain more water vapor, leading to a stronger greenhouse effect.
According to @IPCC_AR6 the water vapor feedbacks warms the climate by $Delta T_V = 2.79 K$ when the $"CO"_2$ quadruples.

Lapse rate feedback describes the influence of the coupling between surface air and the top of the atmosphere (TOA).
This coupling leads to different resulting behaviors depending on the latitude.
In the tropical regions, the high convection creates a very strong coupling,
leading to a steepening of the moist adiabatic lapse rate.
Therefore, more latent heat is released into the atmosphere,
resulting in a smaller increase in surface temperature to balance out a given TOA imbalance @Pithan2014.
The lapse rate feedback is therefore negative in the tropical regions.

In the polar regions, the surface air is colder and dense; there is almost no convection coupling the surface air to the TOA.
Therefore, radiation is the primary coupling mechanism, resulting in a higher surface temperature difference
to balance out a given TOA imbalance.
The lapse rate feedback is positive in the polar regions @Pithan2014.
According to @IPCC_AR6 the water vapor feedbacks cools the climate by $Delta T_V = 1.07 K$ when the $"CO"_2$ quadruples.

Arctic amplification is the tendency of the higher latitudes of the globe to respond more to a given forcing than regions around the equator.
@Pithan2014 describes that phenomenon in more detail.
The authors outline the main contributors of arctic amplification as albedo feedback and lapse rate feedback.

== Feedback separation and analysis
To do the feedback separation, the methodology of @Dufresne2008, @Langen2012 and @Mauritsen2013 will be followed.
A climate system in equilibrium is disturbed at the TOA by an initial forcing $F$.
That forcing will offset the radiation balance by $Delta R$,
which induces a change in surface temperature until a new steady state is reached.
That problem can be linearized to $ Delta R = F + lambda Delta T $ <linear>
with $lambda$ being the feedback factor.
This feedback factor can be estimated from the equilibrium response and the
strength of the forcing:
$ lambda = - F/(Delta T) $ <OG>
$lambda$ is then decomposed into several additive, mutually independent feedback factors,
each representing a different feedback mechanism.
$ lambda = lambda_"temperature" + lambda_"albedo" + lambda_"clouds" + lambda_"water vapor" $ <lambda>
$lambda$ must be negative to yield a stable climate system.
The value of $lambda_"temperature"$ can be obtained by a simulation with no other feedbacks active.
$ lambda_"temperature" = - F/(Delta T_F) $ <lambdaT> with $Delta T_F$ being the change in surface temperature. @Mauritsen2013

In the MSCM, the Planck feedback and the lapse rate feedback are not separated,
instead being compounded: $lambda_"temperature" = lambda_"Planck" + lambda_"lapse rate"$.

=== Imposed feedbacks
There are two control runs done, CTRL/1x$"CO"_2$ (340 ppm $"CO"_2$) and 2x$"CO"_2$ (680 ppm $"CO"_2$),
from which feedback values can be taken and inserted into new runs.
If the values of the feedbacks are now inserted into a run, the feedbacks do not act freely but predetermined.
These feedbacks are then called "imposed".
Each of the four feedbacks which are considered in the separation process
(temperature, albedo, cloud, water vapor)
can have their values imposed from either the CTRL or 2x$"CO"_2$ run
with none of them being free to act.
The resulting 16 combinations ($2^4$) are detailed in @all-runs.

These runs allow for the calculation of the partial temperature contributions of the different feedbacks.
In order to obtain the values of partial temperatures,
both a feedback and corresponding run are chosen
such that the feedback is imposed from the CTRL run
(e.g. `X1-A1-V1-C2` would be viable candidate for the albedo feedback).
The mean surface temperature of that run then needs to be subtracted from that of the run
where the chosen feedback is imposed from the 2x$"CO"_2$ run (e.g. `X1-A2-V1-C2`).
This would yield one of the eight values for the chosen feedback (e.g. $Delta T_A$).

When a feedback is imposed, it is acting alongside the temperature feedback and the following equation is satisfied:
$ lambda_"feedback" dot Delta T = - lambda_"temperature" dot Delta T_"feedback" $
with $Delta T$ being the surface temperature difference between a 1x$"CO"_2$ and 2x$"CO"_2$ run with all feedbacks unmodified.
From that equation, the feedback factor $lambda_"feedback"$ can be isolated:
$ lambda_"feedback" = - lambda_"temperature" (Delta T_"feedback")/(Delta T) $ <feedbackim>

To calculate the feedback factors using equation @feedbackim, $lambda_"temperature"$ (in short $lambda_T$) is needed
and can be obtained using equation @lambdaT. We therefore need to calculate the value of the initial forcing $F$.
According to @Dommenget2011 and @Dommenget_lecture, the formula used in the MSCM for determining the initial TOA forcing is:
$ F = Delta Q approx Delta epsilon_"atmos" dot sigma dot (0.84 T_"surface")^4 $ <forcing>
with $Delta epsilon_"atmos" approx 0.024$ being the change in the atmosphere emissivity
due to the added $"CO"_2$ and $sigma$ being the Stefan-Boltzmann-constant.
With a $T_"surface" = 286.959$ $K$ the forcing comes out to $F = 4.594$ $W m^(-2)$.
Lastly, one needs the total surface temperature change with all feedbacks active: $Delta T = 2.498$ $K$.

=== Locked feedbacks and feedback synergy
In a run with "locked" feedbacks, either one or two from the three feedbacks
(albedo, cloud, water vapor) are imposed from the CTRL run
while the other of the three are free to act.
The temperature is imposed from either the CTRL or the 2x$"CO"_2$ run.
This leads to 12 different runs, listed in the last part of @all-runs.

In a system where one or two feedbacks are locked to a control state, they can be viewed as a forcing.
Like with the imposed feedbacks, a $accent(lambda, ~)$ can be derived for these experiments.
When e.g. water vapor and cloud feedback are locked, one can obtain an estimation for
$ accent(lambda, ~)_"albedo" = - (lambda_"temperature" + F/(Delta accent(T, ~)_"albedo")) $ <feedbacklo>
When only one feedback is locked, the $accent(lambda, ~)$ for two feedbacks can be obtained with the same formula.
This $accent(lambda, ~)$ represents the factor of both feedbacks acting at the same time.

This method can give the partial temperature contributions of all but the temperature feedback as well as all combinations of those.
This implies that not all feedbacks are separated when locking is performed in that way.
The reason for that is the usage of the values. They are only used for calculating the feedback synergies.

One obtains values for the six different $accent(lambda, ~)_i$ out of the 12 runs:
$accent(lambda, ~)_A$, $accent(lambda, ~)_C$, $accent(lambda, ~)_V$,
$accent(lambda, ~)_"AC"$, $accent(lambda, ~)_"AV"$, $accent(lambda, ~)_"CV"$.

With the different factors of feedbacks and their combinations obtained,
one can observe that the factor of two feedbacks is not the same as the sum of the individual feedback factors.
This difference is known as feedback synergy and is defined as:
$ S("feedback1", "feedback2") = accent(lambda, ~)_"feedback1, feedback2" - (accent(lambda, ~)_"feedback1" + accent(lambda, ~)_"feedback2") $ <synergy>

If only albedo, cloud and water vapor feedback are considered,
the synergy between them represents the synergy of them each acting alongside
the temperature feedback as well as any other feedback that is active and not separated in the locked feedback separation process.

=== Other methods for feedback separation
There are other methods to approximate the contributions of the different feedbacks that were not used here.

The most popular method used to separate feedbacks is the partial radiation perturbation (PRP) method.
This method makes use of the radiation transfer sub-model to substitute one feedback from the 2x$"CO"_2$ run into the CTRL run
to estimate the impact of the feedback on the TOA flux.

One other possibility was presented in @Soden2008.
A method based on radiative kernels was implemented there to circumvent the problem of correlation that plagues other methods.
The correlation describes the impact of feedbacks on one another, making it hard to distinguish the effects of single feedbacks.
The radiative kernel method separates the effect on the TOA flux and the temperature change.
A radiative kernel is constructed by computing the TOA flux change from a small change to a feedback strength in the control climate.
The kernel is then multiplied by the small change of the feedback to give the change in TOA flux induced by the feedback @Thorsen.

One other possibility also was mentioned in @Soden2008.
Here, the sea surface temperature (SST) is fixed at two different levels.
This method is mainly used to estimate the cloud feedback by using the difference
between TOA net radiation for cloudy and clear sky.
Furthermore, the method is not accurate since a substantial part in cloud forcing
comes from the interactions with other feedbacks such as water vapor.



= Experimental setup
As mentioned in the introduction, the data from the interactive website is not usable for a full feedback separation.
Certain runs are required in order to follow the methodology of @Mauritsen2013.
However, it cannot be confirmed that these runs were performed using the correct initial state.
Therefore, the open source code from @mscm-code was used and modified to compute the relevant simulations.


== Problems with the model
This section dives deeper into the problem the code base presented when modifying the model to make the experiments possible.
The model is written in Fortran (specifically the Fortran 90 dialect), which is a programming language that provides
an optional framework for enforcing a certain grade of type safety (i.e. the `implicit none` statement),
which was however not used by the model code.
To help development of the code base, various important subroutines were outfitted
with data type annotations describing the shape of used variables.
Furthermore, the use of the `intent` functionality helped with understanding the flow of data within the model
by categorizing values into function input or output parameters or internal temporaries.
Those structural improvements to the model increased code quality and made it easier to understand.
As mentioned before, the model does not have the functionality to conduct experiments that were not intended
by the creators when writing the model.

For said experiments, the model had to be able to do two distinct things:

- Chaining simulation runs, i.e. the final state of the first run is used as the initial state of the next run
- Being able to save a given state of the model into a file and later loading it as an initial state of a new run

To achieve those goals, the initialization of the model simulation was separated from the main simulation loop itself.
The initialization defines the first state of a given run and separating it makes it possible to chain runs as needed.
Secondly, the model was modified to contain a whole new subsection named "mo_state".
This section contains all variables that define the state of the model at any given time.
After introducing a separate control program written in C, it was made possible to save the state of a running model,
as well as loading that state as the initial state of a new run.

The code of this thesis is stored in a GitHub repository for easy access:
https://github.com/Ercanar/bachelor-thesis


== Experiments
The experiments mostly followed the methodology of @Mauritsen2013,
since they also conducted a feedback separation but on a much larger and more accurate model.

=== Preparation
The first preparation needed are the values of the feedbacks for the imposing and locking later on.
To accomplish that, a pre-industrial run with a run time of 50 years is simulated to reach a steady state.
From that point, two separate runs are performed for 75 years each, with their whole state recorded and saved.
These two runs feature all feedbacks enabled and not tampered with.
One run is a pre-industrial run (340 ppm $"CO"_2$) named "CTRL" and the other is a 2x$"CO"_2$ run (680 ppm) named "2x$"CO"_2$".

Their only purpose is the gathering of the values used later on.
The second preparation needed is a state from which all the runs to be analyzed are started.
To achieve such a state, @Mauritsen2013 will be followed again.

First, a 50 years pre-industrial run is done, followed by a 15 years run named "spinup" with the feedbacks locked to the CTRL run values.
This achieves a steady state from which the feedback separation can be properly performed.
The final state of the spin-up run is then saved and used as a starting point for all further runs.

=== Feedback separation and arctic amplification
The runs that will be analyzed are launched from the same initial state.
They include every possible combination of 1x$"CO"_2$ with feedbacks either locked, imposed or free;
the same also applies for 2x$"CO"_2$.
The naming scheme consists of chained expressions which describe the state of the feedbacks.
For example `X1-A0-V1-C2` refers to the run where $"CO"_2$ is pre-industrial (`X1`),
albedo feedback is enabled and free (`A0`), water vapor feedback is imposed or locked to CTRL (`V1`)
and cloud feedback is imposed or locked to 2x$"CO"_2$ (`C2`).
For more information on which runs were done, use @all-runs below.
#figure(
  table(
    columns: 6,
    stroke: none,
    table.hline(),
    table.header(
      [Run name], [$"CO"_2$], [Albedo], [Water vapor], [Cloud], [Run length [years]],
    ),
    table.hline(stroke: 2pt),
    [CTRL$""^1$      ], [1], [ ], [ ], [ ], [75],
    [$"2xCO"_2$$""^1$], [2], [ ], [ ], [ ], [75],
    [spinup$""^1$    ], [1], [1], [1], [1], [15],
    table.hline(),
    [X1-A1-V1-C1], [1], [1], [1], [1], [50],
    [X1-A1-V1-C2], [1], [1], [1], [2], [50],
    [X1-A1-V2-C1], [1], [1], [2], [1], [50],
    [X1-A1-V2-C2], [1], [1], [2], [2], [50],
    [X1-A2-V1-C1], [1], [2], [1], [1], [50],
    [X1-A2-V1-C2], [1], [2], [1], [2], [50],
    [X1-A2-V2-C1], [1], [2], [2], [1], [50],
    [X1-A2-V2-C2], [1], [2], [2], [2], [50],
    [X2-A1-V1-C1], [2], [1], [1], [1], [50],
    [X2-A1-V1-C2], [2], [1], [1], [2], [50],
    [X2-A1-V2-C1], [2], [1], [2], [1], [50],
    [X2-A1-V2-C2], [2], [1], [2], [2], [50],
    [X2-A2-V1-C1], [2], [2], [1], [1], [50],
    [X2-A2-V1-C2], [2], [2], [1], [2], [50],
    [X2-A2-V2-C1], [2], [2], [2], [1], [50],
    [X2-A2-V2-C2], [2], [2], [2], [2], [50],
    table.hline(),
    [X1-A1-V1-C0], [1], [1], [1], [ ], [50],
    [X1-A1-V0-C1], [1], [1], [ ], [1], [50],
    [X1-A0-V1-C1], [1], [ ], [1], [1], [50],
    [X1-A1-V0-C0], [1], [1], [ ], [ ], [50],
    [X1-A0-V1-C0], [1], [ ], [1], [ ], [50],
    [X1-A0-V0-C1], [1], [ ], [ ], [1], [50],
    [X2-A1-V1-C0], [2], [1], [1], [ ], [50],
    [X2-A1-V0-C1], [2], [1], [ ], [1], [50],
    [X2-A0-V1-C1], [2], [ ], [1], [1], [50],
    [X2-A1-V0-C0], [2], [1], [ ], [ ], [50],
    [X2-A0-V1-C0], [2], [ ], [1], [ ], [50],
    [X2-A0-V0-C1], [2], [ ], [ ], [1], [50],
  ),
  caption: [This table shows all of the runs that are used in the imposed feedback separation.
            The first section displays the runs that were done to gather the data for imposing as well as the spinup run.
            The second section contains all runs that are used within the feedback separation and arctic amplification parts.
            The third and final section of the table contains all of the runs in the locked feedback sections.
            The output of these runs is then further processed into the partial temperature contributions,
            whose values are found in @feedback_runs for the feedback separation and @feedback_locked for the locked feedbacks.\
            $""^1$ These runs are directly preceded by a 50 year long pre-industrial run with all feedbacks free to act.
            All other runs start from the final state of the spinup run.
          ],
) <all-runs>



= Results <results>
The results were obtained using Python scripts to analyze the output of the model.
#figure(
  image("img/some-runs.svg", width: 97%),
  caption: [The image contains different graphs which are plotted with global yearly mean surface temperate in °C over time in years.
            The non-altered runs, i.e. 340 ppm and 680 ppm $"CO"_2$ runs, are plotted with thicker lines,
            as they represent the control runs. The spinup is also shown.
            The other runs are hand picked (dashed lines) from all of the different runs to not make the image too crowded,
            but still display the differences within the ensemble.
            One can clearly see a split within the hand picked runs.
            The runs with `V2` within their name follow the curvature 2x$"CO"_2$ control run,
            while the other five runs follow the 1x$"CO"_2$ control run.]
) <some-runs>
#figure(
  image("img/balkendiagrammgeneratorpythonskriptdingskramsoutputdatei.svg", width: 100%),
  caption: [
    The different values of the temperature contributions and sums are shown.
    The red bar represents the climate sensitivity, the dark red bar the sum of the different feedback contributions.
    In order, the next four bars show the temperature feedback, the albedo feedback, the water vapor feedback, and the cloud feedback.
    The last six bars show the values obtained by the locking of feedbacks,
    leading to albedo, cloud and water vapor values as well as the different possible sums of those.
    The values over/under the bars are the values or averages of the bars.
    The x axis displays which $Delta T_i$ is shown.
    For the $Delta T_i$ one can see the 8 different values that were extracted from the raw data.
    One can see that the vapor feedback is by far the main contributor to the climate sensitivity within the MSCM.
    The values are taken from @feedback_runs and @feedback_locked.]
) <balken>


== Feedback separation
To obtain the values of $Delta T_"feedback"$, the mean temperature of a given run (e.g. `X1-A1-V1-C1`)
needs to be subtracted from the mean temperature of a run with a feedback imposed (e.g. `X1-A2-V1-C1`).
In the example, this difference would yield one value of $Delta T_"albedo"$.
Other runs also yield one value, so e.g. `X1-A1-V2-C1` subtracted from `X1-A2-V2-C1`.
The raw temperature values will be listed in their entirety in the appendix, see @feedback_runs.
To better visualize the partial temperature contributions and their spatial distribution,
several figures will be shown in the following, also for later reference.
#figure(
  image("img/Delta T_F.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A1-V1-C1` and `X1-A1-V1-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta T_F$.
            The mean value of $Delta T_F$ in this figure is 0.334 K, the maximum is 1.107 K and the minimum is 0.065 K.
            One can clearly see that most of the warming happens in the polar regions and over Central Asia as well as the Sahara.
            Furthermore, more warming occurs over land than over the oceans.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_F>
#figure(
  image("img/Delta T_A.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X1-A2-V1-C1` and `X1-A1-V1-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta T_A$.
            The mean value of $Delta T_A$ in this figure is 0.086 K, the maximum is 1.119 K and the minimum is 0 K.
            The warming occurs mainly in the polar regions and within Central Asia and north America.
            There is almost no warming in the tropical regions and the non-arctic southern hemisphere.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_A>
#figure(
  image("img/Delta T_C.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X1-A1-V1-C2` and `X1-A1-V1-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta T_C$.
            The mean value of $Delta T_C$ in this figure is -0.2639 K, the maximum is 0.605 K and the minimum is -4.406 K.
            Most of the landmasses and equatorial oceans are experiencing a cooling with the strongest affected regions being
            the Sahara, Australia and Antarctica.
            A warming effect mainly occurs in the North Pacific, North Atlantic and Southern Ocean regions.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_C>
#figure(
  image("img/Delta T_V.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X1-A1-V2-C1` and `X1-A1-V1-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta T_V$.
            The mean value of $Delta T_V$ in this figure is 2.069 K, the maximum is 3.337 K and the minimum is 1.069 K.
            The warming happens all over the globe with the minimum over the Antarctic.
            The strongest warming happens within the Himalayas and the American Cordilleras as well as the North Pacific.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_V>
#figure(
  image("img/sum Delta T_i.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A2-V2-C2` and `X1-A1-V1-C1` is displayed.
            Meaning it is a spatial distribution of the sum of all feedback contributions $sum_i Delta T_i$.
            The mean value in this figure is 2.187 K, the maximum is 4.481 K and the minimum is -1.2 K.
            The strongest warming happens in Central Asia and the Arctic as well as the Southern Ocean.
            Exceptions from warming are Australia, South Africa and the Sahara region, where a cooling effect is observed.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-sum>
#figure(
  image("img/Control.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2` and `X1` is displayed.
            Meaning it is a spatial distribution of the climate sensitivity $Delta T$.
            The mean value of $Delta T$ in this figure is 2.498 K, the maximum is 4.771 K and the minimum is 1.809 K.
            The strongest warming occurs in Central Asia, the Arctic and the Southern Ocean as well as the Sahara region and Australia.
            The weakest warming happens over the equatorial regions, especially the oceans.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-control>



=== Imposed feedbacks <h>
#set par(justify: false)
#figure(
  table(
    columns: 7,
    table.header(
      [Source], [$Delta T_F$ [K]], [$Delta T_A$ [K]], [$Delta T_C$ [K]], [$Delta T_V$ [K]], [$sum_i Delta T_i$], [$Delta T$ [K]]
    ),
    [MSCM          ], [0.316], [0.084], [-0.269], [2.056    ], [2.187], [2.498],
    [@Mauritsen2013], [1.00 ], [0.17 ], [ 0.19 ], [1.57     ], [2.93 ], [2.91 ],
    [@Dufresne2008 ], [1.15 ], [0.16 ], [ 0.46 ], [0.6$""^1$], [1.96 ], [     ],
    [@IPCC_AR6     ], [     ], [     ], [      ], [         ], [     ], [3.78 ],
  ),
  caption: [Values of temperature composition of the different feedbacks $Delta T_i$
            as well as their sum $sum_i Delta T_i$ and the climate sensitivity $Delta T$.
            The table contains values from four different indicated sources, where the MSCM is the first one.
            The values were taken out of tables within the respective sources and the MSCM values come from @feedback_runs.
            E.g. the value for $Delta T_F$ is the average of the 8 values for $Delta T_F$ found within @feedback_runs;
            apply the same for all $Delta T_i$. The climate sensitivity of the MSCM is also listed in @feedback_runs.
            $""^1$ This value is $Delta T_V + Delta T_"lapse rate"$.]
) <imposed_temp>

#figure(
  table(
    columns: 6,
    table.header(
      [Source], [$lambda_T$], [$lambda_A$], [$lambda_C$], [$lambda_V$], [$lambda$]
    ),
    [MSCM          ], [-14.529  ], [0.487], [-1.565], [11.958  ], [-3.649],
    [@Mauritsen2013], [ -3.45   ], [0.20 ], [ 0.23 ], [ 1.86   ], [-1.16 ],
    [@Dufresne2008 ], [$-4.04^1$], [0.26 ], [ 0.69 ], [$1.80^2$], [-1.27 ],
    [@IPCC_AR6     ], [$-3.22^1$], [0.39 ], [ 0.49 ], [$1.25^2$], [-1.03 ],
  ),
  caption: [Values of the different feedback factors $lambda_i$ as well as their sum $lambda$.
            The table contains values from four different indicated sources, where the MSCM is the first one.
            The values were taken out of tables within the respective sources.
            The values of the MSCM were obtained using the respective values from @imposed_temp and Equations @lambdaT and @feedbackim. \
            $""^1$ This value only represents the Planck feedback factor, so $lambda_T - lambda_"lapse rate"$. \
            $""^2$ This value represents the sum of $lambda_V$ and $lambda_"lapse rate"$.]
) <imposed_delta>

#set par(justify: true)

The values of the feedback factors as well as the $Delta T_i$ from @imposed_temp
suggest that the climate simulated within the model is stable.
With a value of $lambda = -3.649$ it is a much more stable climate than in bigger models.

The temperature feedback has a highly negative value,
meaning a small temperature change is necessary to balance out a TOA imbalance when only looking at that feedback.
It is almost four times lower than the feedback factors in the other papers.
That means that the Planck feedback and/or the lapse rate feedback is severely stronger than it should be.
The forcing $F$ with which $lambda_T$ is calculated (see @forcing)
depends on the surface temperature and the change of atmospheric emissivity.
The MSCM assumes a value of $epsilon approx 0.800$ with a pre-industrial $"CO"_2$.
With clear sky conditions, the emissivity of the atmosphere at TOA can lie between $epsilon = 0.756$ and $epsilon = 0.838$,
with a global mean of $epsilon = 0.796$ currently @Pandey1995.

These values are a higher boundary to the mean global emissivity because only clear sky conditions are accounted for.
According to @Nakanishi2025 the atmospheric emissivity will be lowered by the presence of clouds when a warming occurs.
With those facts it is clear that at least the Planck feedback is stronger within the MSCM
compared to other models that use a more realistic emissivity of the atmosphere.
To verify the correctness of the lapse rate feedback, either the code has to be analyzed
or a separation of the temperature feedback into Planck and lapse rate feedback has to be performed.

The other feedback factors scale with $lambda_T$, so the following sections will not necessarily be analyzed
or compared using $lambda_i$ but rather $Delta T_i$.

The cloud feedback has a negative value, suggesting that clouds cool the climate system and making it more stable.
If compared to the mostly positive or neutral values of the other models a clear discrepancy can be seen.
The cloud model of the MSCM is a very strongly simplified one.
It takes its values mostly from a database of recorded fields of cloud coverage and assigns every cloud a constant albedo.
According to @Stephens2005, "[...] a number of cloud properties, including cloud amount,
cloud height and vertical profile, optical depth, liquid and ice water contents,
and particle sizes affect the radiation budget of earth and are all potentially relevant to the cloud feedback problem."
Most of these properties are not considered in the MSCM, leading to great differences in feedback strength compared to the other models.

The main contributor to warming is the water vapor feedback.
If compared to the other models it is about 25% higher when considering the $Delta T_V$.
For such a simple model that is quite reasonable and does not point to any big shortcomings with a high certainty.

The albedo feedback is slightly positive.
The MSCM assigns a specific albedo value to all clouds and all ice-covered points
($alpha = 0.35$) and a separate value to all other points ($alpha = 0.1$).
Bigger models, e.g. the ECHAM6 used by @Mauritsen2013, contain some kind of vegetation model,
leading to a more detailed and accurate albedo simulation @ECHAM6.
As well as not containing a vegetation model, the MSCM has a rather simple sea ice model,
possibly leading to a further lowering of the albedo feedback impact.

A visual representation of the partial temperature contributions from all feedbacks can be seen in the middle section of @balken.

=== Arctic amplification
The results concerning arctic amplification are obtained the same way as imposed feedbacks with the only change being
that the tropical regions (30° S - 30° N) and the polar regions (60° - 90° S and 60° - 90° N) are done separately.
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
    Values of temperature composition and feedback factors with imposed feedback, separated into polar regions and tropical regions.
    One can see that the polar regions experience a stronger warming than the tropical regions.
    The values of the temperature feedback factors in the tropical regions are anomalous, especially the temperature feedback factor.
    The temperature values are obtained like in @imposed_temp.
    The feedback factors are calculated using equations @lambdaT and @feedbackim.
  ],
) <arctic_table>

When analyzing the spatial differences of the feedback factors,
it is clear that some kind of arctic amplification happens within the simulation.
The climate sensitivity of the polar regions is approximately 38% higher than in the tropical regions and 22% higher than the global mean.
Since these values come from the same data as the visualization in @figure-control, one can perform a crosscheck.
And indeed there are clear signs of arctic amplification visible,
since especially the equatorial ocean regions warm way less than the rest of the globe.
Furthermore, the Southern Ocean and the arctic region seem to be warming faster than the average of the globe,
confirming the initial facts visually.

First of all, the polar temperature feedback factor is closer to zero than the global or equatorial mean.
This indicates a more unstable climate and a more pronounced warming relative to the equatorial region.
When crosschecked with @figure-T_F, this fact is clearly visible.
The polar regions have an 18% larger feedback factor while the tropical regions
have an over five times larger value than the values in @Langen2012, see @arctic_table.
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
      [@Langen2012$""^1$],
    ),
    [polar]     , [-3.5], [-3.0], [-0.54],
    [equatorial], [-5.1], [-3.5], [-1.6 ]
  ),
  caption: [Values for Planck and lapse rate feedback factors from the MSCM and @Langen2012.
            The main difference between the two models lies within the equatorial lapse rate,
            being more than 13 times more negative in the MSCM.
            $""^1$ The values of this source are for an aqua planet, not for a real world.],
) <lapserate>

While the differences in Planck feedback are reasonably small,
the biggest discrepancy lies within the highly negative value of the MSCM equatorial lapse rate feedback factor.
It is roughly 13 times larger in magnitude than the corresponding value of the other model.
This points to a weakness of the MSCM's simplicity once again, likely some kind of wrong lapse rate model used within.
It also has to be noted that according to @Pithan2014 the lapse rate feedback should be one of the main contributors to arctic amplification
and therefore the feedback factor should be positive.
Again from this point on the feedback factors of the other feedbacks will be disregarded,
because they scale with the much too magnitudal $lambda_T_i$.
Furthermore, feedback factors are normally only defined on a global scale,
meaning an accurate use of them cannot be guaranteed when not viewing the whole globe.
Therefore a new table for better comparisons is necessary.

#figure(
  table(
    columns: 7,
    table.header(
      [region], [source], [$Delta T_F$ [K]], [$Delta T_A$ [K]], [$Delta T_C$ [K]], [$Delta T_V$ [K]], [$sum_i Delta T_i$ [K]]
    ),
    table.cell(
      rowspan: 4,
      [polar]
    ),
    [MSCM                  ], [0.747], [0.289], [-0.103], [1.957], [2.890],
    [@Taylor2013, arctis   ], [1.35 ], [2.22 ], [ 0.54 ], [1.26 ], [3.73 ],
    [@Taylor2013, antarctis], [1.38 ], [1.44 ], [ 0.57 ], [0.84 ], [2.58 ],
    [@Langen2012$""^1$     ], [0.857], [     ], [ 1.745], [2.622], [5.224],
    table.cell(
      rowspan: 3,
      [tropical regions]
    ),
    [MSCM             ], [0.199], [ 0.004], [-0.477], [1.978], [1.703      ],
    [@Taylor2013      ], [0.87 ], [-0.06 ], [-0.09 ], [1.502], [1.142$""^2$],
    [@Langen2012$""^1$], [0.745], [      ], [ 1.495], [2.207], [4.447      ],
  ),
  caption: [Values of different $Delta T_i$ in both polar and tropical regions from the different indicated sources.
            Empty fields indicate that no values could be assigned to it
            due to the absence of that value or its composition within the source.
            The values of the MSCM are lower in every category than any other comparable value listed.
            $""^1$ The values of this source are for an aqua planet, not for a real world.
            $""^2$ The values contain more than the feedbacks listed, such as ocean feedback.],
) <arctic_temp>

The cloud feedback has the effect of cooling the polar regions and the tropical regions.
The main reason for that is the overly simple cloud model of the MSCM.
For a 2x$"CO"_2$ scenario it assumes a globally constant cloud coverage of 0.7.
Furthermore, only cloud albedo is taken into account as an impact of the clouds.
Since there is no coupling between clouds and other feedbacks and the cloud cover is constant and relatively high,
the strongest impact of the cloud model should be in places where there are normally not many clouds present.
These places include the Sahara region, Australia and Antarctica.
If crosschecked with @figure-T_C, that assumption seems to be confirmed,
since parts of the Sahara are cooled by the clouds by up to 4.4 K.
The other models suggest that the partial temperature contribution of clouds should be between 1.1 K and 1.75 K in both regions.
That points again to the fact that the cloud model of the MSCM is not sophisticated in spatial distribution
as well as in interactions with other feedbacks such as water vapor.

The water vapor feedback is more interesting. It is weaker in the the polar regions than globally or equatorially.
But the equatorial regions themselves have weaker water vapor feedback than the global mean,
despite the more than 10 K higher temperature.
If a crosscheck with @figure-T_V is done one can clearly see that Antarctica has the global minimum of the effect of the water vapor feedback.
Furthermore, a clear lowering of the feedback's impact can be seen over the tropical region.
Compared to @Taylor2013, the MSCM overestimated the impact of the water vapor feedback by between 30% and 85% depending on the region.
All of those facts point towards an inconsistency within the hydrological part of the MSCM.

The albedo feedback is also strongest in the polar regions, while being close to zero in the tropical regions.
The crosscheck with @figure-T_A confirms that quite well visually.
Compared again to @Taylor2013, the MSCM gets the albedo feedback of the tropical regions quite well,
but falters at the polar regions. The impact of albedo feedback is more than six times larger
within @Taylor2013.
This indicates that the MSCM underestimates the impact of the albedo,
which would lead to a lower change in albedo, and a lower impact of the albedo feedback.
The average albedo of the MSCM lies between 0.1 and 0.35
while real world measurements reveal it to be close to $alpha = 0.43$ @Marcianesi2021.

The total feedback factors are $Delta T_"polar" = 3.049 K$ and $Delta T_"equatorial" = 2.21 K$,
further strengthening the hypothesis that arctic amplification is a result of the simulation.
The polar region is much more unstable, reacting with a much stronger surface temperature increase to a given forcing
than any other region, especially when compared to the much more stable equatorial region.

=== Discrepancy of temperature differences
Within the feedback separation with imposed feedbacks, and subsequently also in the arctic amplification,
a discrepancy between $Delta T$ and $sum_i Delta T_i$ can be found.
This discrepancy, denoted $Delta (Delta T)$, assumes different values for the different regions.
The global mean presents $Delta (Delta T) = 0.311$ $K$, while the polar regions and the tropical regions give 0.159 K and 0.507 K respectively.
This discrepancy can be visually confirmed by comparing @figure-sum with @figure-control.
That indicates that the effect on the sum is a process that warms the global climate,
and does so stronger in the tropical regions and weaker in the polar regions.
This process could be another feedback that wasn't separated out
or a possible correction within the model that was somehow not considered in the separation process.
Due to the time constraints of this thesis, the exact reason for this should be investigated in a follow up thesis
that implements all of the recommended upgrades to the model as well as more detailed and more extensive methodology.

#pagebreak()
@Mauritsen2013 implies that if $Delta (Delta T)$ gets substantially big, a meaningful feedback separation has not been achieved.
The reason for that implication lies within the assumptions that were made within the theory section.
Equation @linear implies that the problem can be linearized.
Therefore, when equations @feedbackim and @lambdaT are inserted into equation @OG, the following correlation emerges:
$ Delta T = sum_i Delta T_i = Delta T_F + Delta T_A + Delta T_V + Delta T_C $
The results from the imposed feedback separation do not follow this correlation.
This leads to the natural conclusion that either the MSCM is incapable of having a meaningful feedback separation performed on it
or that some kind of error was done following the methodology of @Mauritsen2013 to try to do the feedback separation on the MSCM.


== Locked feedbacks and feedback synergy
The maps of the temperature difference distributions for the locked feedbacks,
similar to the ones used in @h, can be found in the appendix.

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
    The water vapor feedback factors are very high compared to the other ones due to the anomalous values in the temperature feedback factor.
    The values for "Albedo" and "Albedo-Cloud" are the same; the values for "Water Vapor" and "Cloud-Vapor" are the same.
    The temperature values are taken from @feedback_locked, while the feedback factors are obtained using equation @feedbacklo.
  ],
) <locked_table>

A visual representation of the partial temperature contributions from all feedbacks can again be seen in the rightmost section of @balken.

The feedback synergy is computed via equation @synergy.
It has to be noted that the feedbacks used in that equation can also be a combination of two feedbacks.
So e.g. $S(A, "CV") = accent(lambda, ~)_"ACV" - (accent(lambda, ~)_A + accent(lambda, ~)_"CV")$.
@locked_table indicates that $Delta T_"ACV"$ was not measured
and therefore $accent(lambda, ~)_"ACV"$ cannot be obtained via equation @synergy.
For that reason we extract it from two values that come from previous sections:
$ accent(lambda, ~)_"ACV" = sum_i lambda_i - lambda_T = 10.880 " " W m^(-2) K^(-1) $
The other synergy values are displayed in @sixegg.

The feedback synergy values in @sixegg reveal a clear shortcoming of the MSCM model.
The cloud feedback seems to have no impact on feedback factors when acting alongside a different feedback.
This indicates a very simplified or non-existent cloud feedback mechanism within the code base.
Apart from that abnormality, the other values also seem to behave rather curiously compared to other studies and papers.
All feedbacks seem to have a negative synergy with each other in every combination.
Every feedback is stronger on its own.
The values of the synergy of vapor and albedo are also the same.
This result stands in contradiction to results from more accurate models as seen in @Mauritsen2013.
The reason for the inaccuracy concerning synergy most likely comes from the cloud model once again
while also impacting the other values.
Therefore the MSCM is not suitable for locking feedbacks as well as calculating synergies between feedbacks.

#figure(
    image("img/synergy.svg", width: 50%),
    caption: [
      Within the circles, the feedbacks with their factors are displayed.
      The blue numbers on the outside are the values of the synergies.
      The gray circles are the fundamental feedbacks: albedo (A), cloud (C) and water vapor (V).
      The white circles are compositions according to the connections to the gray circles.
      E.g. "AV" is connected by the lines to "A" and "V", meaning it is the state where albedo and water vapor are acting freely.
      All of the synergy values are negative.
      All values have [$W m^(-2) K^(-1)$]. Inspired by @Mauritsen2013.],
) <sixegg>



= Discussion
In this section the anomalies of the results will be analyzed further and the roots and implications will be looked into.


== Lapse rate
Since the MSCM is a one-layer atmosphere model, the effects of lapse rate cannot be simulated but only approximated.
These approximations are done using other parts of the model as well as real world measurements,
all influencing the air temperature.
Details of this can be found within the subroutine `LWradiation`,
where the atmospheric emissivity is calculated as well as the variable `LWair_down`.
The latter depends on the emissivity, the air temperature and the constant `dTrad`,
which is defined as $"dTrad" = -0.16 dot "Tclim" -5$, where `Tclim` is the real world surface temperature measured between 1948 and 2007.
The air temperature itself depends on corrections made with the radiation models as well as the hydrological model.
Since the sub-models of the MSCM are also simplified, the overall accuracy of the lapse rate model is rather low.
As found in the results section, this leads to a lapse rate feedback that is negative all over the globe, even in the polar regions.

If the lapse rate feedback factor was that negative in the real world and nothing else would change,
many things would be different.
First of all there would have to be some kind of new mixing of lower level air with the TOA in the polar regions,
to substantiate the negative lapse rate feedback.
That would lead to lapse rate feedback damping and not amplifying arctic warming.
Furthermore, the lower feedback factor would lead to a higher environmental lapse rate which,
like today in the tropical regions, would massively promote cloud formation all over the world.
There would be more high and low altitude clouds forming in many parts of the world,
leading to a substantial cooling of the surface, not only because of the stronger lapse rate,
but also because of more clouds reflecting more light.
Because the definition of the tropopause is dependent on the lapse rate, it would also be higher all over the globe,
leading to higher thunderstorms being possible that block even more light from hitting the ground.
The transport of moist air from water vapor rich regions to others would also be reduced, due to the quicker formation of clouds.
This leads to much more amplified weather patterns:
- more droughts in regions where there is low humidity/water coverage
- more rain in regions with high humidity/over the ocean
- more extreme weather events like hurricanes due to the speedup in formation
Despite the extremes being more severe, the climate sensitivity will go down, meaning a more stable climate will be established.


== Albedo
As seen in @arctic_temp, the MSCM drastically underestimates the impact of the albedo feedback.
The model sets the albedo for all ice and clouds to 0.35 and the rest to 0.1.
Furthermore, the temperature range of the different albedo types is set as
-10 to 0 °C for land snow-albedo and -7 to -1.7 °C for ocean ice-albedo.
The albedo of the points is then altered in every time step of the model as follows:
- below the minimum temperature the albedo is set  to 0.35
- above the maximum temperature the albedo is set to 0.1
- within the temperature range, the albedo grows linearly with the surface temperature from 0.1 to 0.35
The model also uses a real world glacier map as an initial state, to account for land ice.
The model then modifies the shortwave radiation flux with the planetary albedo
$a_"planet" = a_"surface" + a_"atmos" - a_"surface" dot a_"atmos"$.
The main problem with this approach is that the albedo of ice lies more within the range of 0.5 to 0.7 and snow as high as 0.9 @NASA.
This points to a underestimation within the MSCM of the albedo, leading to a way smaller change in surface albedo if the ice melts.

If the albedo would suddenly behave like the model does in the real world, a few drastic changes will happen.
The clouds having their albedo decreased from approximately 0.7 to 0.35 @Albedo
would lead to much more shortwave radiation reaching the ground or being absorbed within the atmosphere.
This alone would lead to a warming effect.
Regions with sand would also have their albedo decreased from 0.35 to 0.1 and would subsequently also warm up @Albedo.
Especially the ice and snow covered regions would warm up significantly due to the change of albedo from around 0.7 to 0.35 @NASA.

Oceans would not have a relevant change in albedo.
Dense forests have a lower albedo than 0.1, so they would subsequently cool down slightly.
The albedo feedback factor would be smaller after the sudden change because every change in albedo after would be way smaller than today.
So in conclusion, the planet would warm drastically first but then would be more stable, since the feedback factor would be rather small.


== Clouds
The last and biggest discrepancy within the MSCM is the cloud model as seen in @figure-T_C.
The clouds themselves are initially read from a database containing a real world measured spatial and temporal distribution of clouds.
If the $"CO"_2$ is set to 680 ppm, the cloud cover becomes constant all over the world at 70% coverage.
Other than that, the cloud value is not altered at all, meaning that there is no feedback loop within the cloud model.
Only the albedo and the emissivity of the clouds is used within the model,
leading to a strongly simplified cloud model that is almost useless when considering feedbacks.
This model leads to an inaccurate impact of clouds, especially in regions where there are typically none, like in the Sahara.

#pagebreak()
The scenario that would happen if the clouds would be homogeneously distributed at 0.7 coverage
whenever there is 680 ppm $"CO"_2$ in the atmosphere has some interesting implications.
First there would be much more clouds which already cool the planet massively within the MSCM,
but the real world impact would be even stronger since the albedo of clouds is upwards of 0.6 instead of 0.35 @Albedo.
Especially regions with few clouds in the current climate are impacted the strongest.
For clouds to be that well distributed, all important factors for cloud formation need to be present all over the globe.
That implies either a very high humidity everywhere or a very fast transport of moisture within the atmosphere.
This could be made possible by broader and more frequent atmospheric rivers as well as low level jets,
which transport the majority of moisture within the atmosphere @AR.

There will be much more precipitation in most parts of the world because of the presence of the factors to form clouds in the first place.
There also is not variation over the year within cloud cover, meaning climate phenomena like monsoon are not possible within this scenario.
Assuming that the kinds of clouds also don't vary from one another,
it stands to reason that the lapse rate must be equally as strong in most places of the world.
As this is a global mean, the tropical regions would have fewer clouds than today, leading to less extreme weather phenomena like hurricanes.
The lower lapse rate in the tropical regions leads to a stronger warming effect of that feedback, while in the polar regions the opposite happens.
All in all the globe would cool off significantly in such a scenario, while the feedbacks effects are rather dampened than amplified.
This leads to a more homogeneous warming of the globe and a weakening of the arctic amplification.


== Possible corrections for the model
As said in the last sections, there are a few improvements that could be made to the model to yield a more realistic simulation.

=== Lapse rate model <correction-lapse>
Separation of the lapse rate from the planck feedback would be a good starting point.
This allows a better feedback separation to be performed without the need of approximations.
Furthermore, the lapse rate model needs to be more realistic to give positive values in the polar regions
and more realistic values in the rest of the world.
To achieve this, the atmosphere needs to be more complex than one layer. The implementation of a more complex atmosphere model,
e.g. a multi layer gray radiation atmosphere model would benefit the accuracy of the lapse rate feedback model.
This atmosphere model is still considered to be elementary and can be implemented rather simply
as shown in the `climlab` climate model @climlab.
Implementing a more realistic lapse rate model is possible when using a multi layer atmosphere, leading to, // KING 🫴 👑
with the right tuning, a comparable feedback factor for lapse rate.
A simple lapse rate model could be something like presented in @matlab.

=== Albedo model
The albedo model would be another part of the model that could be upgraded.
A correct albedo model would allow the model to more accurately predict the warming in the polar regions, i.e. arctic amplification.
This could be achieved by implementing the correct value for snow and ice covered regions as well as clouds.
Moreover, an real-world map for the spatial distribution of the albedo could be used to improve the albedo model.
E.g. the Sahara would mostly have an albedo of approximately 0.35, the rain forest between 0.07 and 0.15 etc.
Several different real world maps like this are already used within the MSCM like:
- zonal and meridional winds
- atmospheric humidity and soil moisture
- cloud cover
- topography and solar radiation
Because the model already uses these external resources it would be rather simple to implement the more accurate albedo map.
It is important though to still change the albedo values if needed,
so that the albedo still stays a feedback and is not predetermined all the time as e.g. the cloud model.

=== Cloud model
The cloud model also needs some upgrades. First of all there is a need to make the cloud an actual feedback mechanism.
To do that, a model for cloud formation needs to be implemented.
A simple cloud formation model based on humidity and lapse rate would be enough to achieve that,
leading to interactions with two other feedback mechanisms.
After implementing a simple cloud formation model, more characteristics than albedo and
long wave emissivity need to be implemented to better account for the many properties of clouds.
Important cloud properties are e.g. the altitude as well as the composition of the clouds.
Higher clouds generally have a lower emissivity, leading to a stronger greenhouse effect @IPCC_AR6.
With the multi layer atmosphere proposed in @correction-lapse, the altitude could be simulated.
The composition shifts towards more water droplets in warmer climate @IPCC_AR6,
meaning a temperature dependency could be enough for that part of the cloud model.
Water droplets within clouds also have a higher albedo, leading to a cooling effect.
The clouds in the MSCM also do not interact with the hydrological model directly.
Instead, a real-world map is again used to determine the influence of rain on the hydrological cycle.
Since this interaction is important for the interactions between feedbacks,
a model that can approximate precipitation with a given cloud distribution is required.


#pagebreak()
= Conclusion
The MSCM model is capable of simulating the climate rather accurately considering the sheer simplicity of the model.
Especially the global mean climate sensitivity and the corresponding total global feedback factor
match the values presented in papers that analyzed bigger models like @Dufresne2008 and @Mauritsen2013.
But the simplicity limits the depth of the correctness and the values deviate strongly the more they are analyzed.

The limitations of the lapse rate model, the albedo model and especially the cloud model of the MSCM
are the main takeaways of the feedback separation.
The clouds not being a feedback was the main cause of the synergy not being able to be calculated correctly.

In order to get more realistic values out of the MSCM, these sub-models have to be upgraded.
More layers within the atmosphere, a more accurate albedo as well as making clouds a feedback are the most pressing ones of those.
Such upgrades to the model could be investigated in another study to refine the MSCM,
while trying to still minimize the computing power needed for the model.

There are a few concerns with the results of this thesis. The existence of a non-negligible $Delta (Delta T)$ implies
that the feedback separation was unsuccessful. To remedy this, a redo of the experiments with enhancements is recommended.
First, the lapse rate and Planck feedback should be separated, then also other possible feedbacks should be separated out,
e.g. ocean feedback.
That way it should be possible for the $Delta (Delta T)$ to become negligible and for a feedback separation to be successfully performed.

It would be beneficial for further studies to implement other methods of feedback separation into the MSCM
e.g. the radiative kernel method of @Soden2008 in combination with the SST method;
or the PRP method which would be easy to implement due to the one layer atmosphere of the MSCM.
However, the radiative kernel method can't be used to compute cloud feedbacks directly,
while the SST method instead specialises in exactly that.

Implementing those methods would result in a different feedback separation that could be compared to the values found within this thesis.
Furthermore, performing multiple feedback separation methods simultaneously adds a layer of redundancy.
In the case that one of the three methods is performed incorrectly, there would still be two sets of correct values to compare to other models.



#pagebreak()
= Appendix
#set par(justify: false)
#figure(
  image("img/Delta T_A locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A0-V1-C1` and `X1-A0-V1-C1` is displayed.
            Meaning it is a spatial distribution of $Delta accent(T, ~)_A$.
            The mean value in this figure is 0.363 K, the maximum is 1.389 K and the minimum is 0.065 K.
            The warming occurs mainly in the polar regions and within Central Asia and North America as well as the Sahara region.
            There is almost no warming in the tropical regions and the non-arctic southern hemisphere.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_A-lo>
#figure(
  image("img/Delta T_V locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A1-V0-C1` and `X1-A1-V0-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta accent(T, ~)_V$.
            The mean value in this figure is 2.191 K, the maximum is 3.77 K and the minimum is 1.715 K.
            The strongest warming occurs in the Himalayas, the Sahara region and the American Cordilleras as well as Australia.
            The weakest warming happens over the equatorial oceans.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_V-lo>
#figure(
  image("img/Delta T_C locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A1-V1-C0` and `X1-A1-V1-C0` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta accent(T, ~)_F$.
            The mean value in this figure is 0.334 K, the maximum is 1.107 K and the minimum is 0.065 K.
            One can clearly see that most of the warming happens in the polar regions and over Central Asia as well as the Sahara.
            Furthermore, more warming occurs over land than over the oceans.
            It is worth noting that there is no difference between this figure and @figure-T_F.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_C-lo>
#figure(
  image("img/Delta T_AC locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A0-V1-C0` and `X1-A0-V1-C0` is displayed.
            Meaning it is a spatial distribution of $Delta accent(T, ~)_"AC"$.
            The mean value in this figure is 0.363 K, the maximum is 1.389 K and the minimum is 0.065 K.
            The warming occurs mainly in the polar regions and within Central Asia and North America as well as the Sahara region.
            There is almost no warming in the tropical regions and the non-arctic southern hemisphere.
            It is worth noting that there is no difference between this figure and @figure-T_A-lo.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_AC-lo>
#figure(
  image("img/Delta T_AV locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A0-V0-C1` and `X1-A0-V0-C1` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta accent(T, ~)_"AV"$.
            The mean value in this figure is 2.461 K, the maximum is 4.745 K and the minimum is 1.79 K.
            The strongest warming occurs in the Himalayas, the Sahara region,
            the Arctic and the American Cordilleras as well as Australia and the Southern Ocean.
            The weakest warming happens over the equatorial oceans.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_AV-lo>
#figure(
  image("img/Delta T_CV locked.png", width: 100%),
  caption: [In this figure, the temperature difference between the runs `X2-A1-V0-C0` and `X1-A1-V0-C0` is displayed.
            Meaning it is a spatial distribution of one of the eight values of $Delta accent(T, ~)_"CV"$.
            The mean value in this figure is 2.191 K, the maximum is 3.77 K and the minimum is 1.715 K.
            The strongest warming occurs in the Himalayas, the Sahara region and the American Cordilleras as well as Australia.
            The weakest warming happens over the equatorial oceans.
            It is worth noting that there is no difference between this figure and @figure-T_V-lo.
            The data comes from the output binary files of the models and the outlines of the geography comes from @topo.]
) <figure-T_CV-lo>
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
      [Difference in gmean, tropical [K]]
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
    where gmean is an internal function of the model.],
) <feedback_runs>

#figure(
  table(
    columns: 6,
    table.header(
      [], [Simulation 1], [Simulation 2], [Difference in gmean, global [K]], [Difference in gmean, polar [K]], [Difference in gmean, tropical [K]]
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
    where gmean is an internal function of the model.]
) <feedback_locked>



#pagebreak()
#bibliography("sources.bib", style: "apa")
