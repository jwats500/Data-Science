EXPERIMENTS:
To re-run exeriments open GROUP4-INTP4 netlogo file, go to the BehaviorSpace module under tools. Different experiments are pre-set and can be run.

FIGURES/ANALYSIS:
If Jupyter Notebooks installed, move Jupyter Notebooks folder to wherever your files are stored. Select run all in each seperate Jupyter notebook to generate regression analysis and figures
 
NOTE: charts graphs and analysis were performed on the files located in the "uptyer notebooks"->"exp_results" folder. To re-run the notebooks on new data simply replace the contents of the exp results folder with newly generate experiments from the BehaviorSpace tool. Figures and regression results will be similar, but not identical as the seed was not set.


Experiment Design Summary:
 
Exp 1 (primarily just viz):
Time series casualties vs initial supplies 
	Initial-Supply varied @ [0 25 50 75 100] (ticks represent days)
	100 repetitions 

Exp 2: Comparing the effect of supply policy on dependent variables. Discrete values chosen to make observation simpler
	Exp 2.a (test effect of initial supply)
		Re-supply rate set to zero
		Starting supplies varied @[0,25,50,75,100] 		
		100 repetitions for each value 
		Expectation obtained by taking the average over the 100 runs+sum #numer of times imphal/kohima held
		Linear Regression performed for continuous dependent variable (Casualties)
		Logistic Regression for binary dependent variable (Imp/Kohima)
	
	Exp 2.b (test effect of re-supply on casualties and success)
		starting supplies held stead @25 for each repition
		re-supply rate varied @[2,4,6,8,10]
		100 repetitions for each value 
		Expectation obtained by taking the average over the 100 runs/sum #numer of times imphal/kohima held
		Linear Regression performed for continuous dependent variable (Casualties
		Logistic Regression for binary dependent variables(Imp/Kohima)

	Exp 2.c (not implemented) (test effect of initial supplies+re-supply on casualties and success)
		starting supplies varied @[0,10,25,50,75,100] 
		re-supply rate varied @[6,8,10] (just to limit # of runs)
		100 repetitions for each value 
		Expectation obtained by taking the average over the 100 runs/sum #numer of times imphal/kohima held
		Linear Regression performed for continuous dependent variable (Casualties
		Logistic Regression for binary dependent variables(Imp/Kohima)
Exp 3(optional)????:
	repeat but treat independent variables as continuous
	starting supplies varied[0-100]
	re-supply varied[0-10]
	10 repetitions for each value
	Linear Regression total casualties
	Logit Imp, Koh

See behaviorSpace in NetLogo model for exact details.
