# NOTES

1. The recommended version of Ruby was too old to install on my machine, so I switched the project to 2.2.3 - the oldest version I had immediately available.
2. My intuition suggested that the list munging behaviour in the TimeSeries was the culprit for the performance problems, but just to be sure I dropped RubyProf in - sure enough, the vast majority of the time was being spent comparing timestamps, as per the search code in the `TimeSeries#[]=` method.
3. TimeSeries is essentially a hash - a theory that was borne out by how easily the code was adapted to use one under the hood. (It was reassuring to have a solid suite of tests around the class just to be certain, too.) That change yielded the desired performance improvement - the `time` command yielded the following results:

```
real	2m43.601s
user	2m42.869s
sys	0m0.314s
```

...and after...

```
real	0m3.309s
user	0m3.207s
sys	0m0.073s
```

4. As an experiment, I decided to rewrite the DailyStats class to make it completely generic - able to collect and process arbitrary blocks of time. This took a bit of work, and isn't terribly efficient, but at least the code is pretty clear.

5. Due to time pressures I haven't written as many tests for my new code as I would like - I also didn't get a chance to add the other statistical components.
