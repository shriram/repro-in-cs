Recently, the results from

http://reproducibility.cs.arizona.edu/

were noticed by several people. This resulted in significant
discussion on social media sites:

https://plus.google.com/+ShriramKrishnamurthi/posts/Tf4D2HKQRKi
https://www.facebook.com/shriram.krishnamurthi/posts/10153931516105581?stream_ref=10

A quick reading would suggest that a large number of systems papers
have unusable artifacts. However, several authors reported that their
work had not been represented fairly. In addition, some disinterested
people found problems with the evaluation of work by others.

As the claims multiplied, it became clear that the evaluation done
here warranted further investigation. This repository is meant to
enable and publicize the findings of that investigation.

You can focus on the data/ subdirectory and ignore everything else.

If you really want to build the Web site:

- install DrRacket 6.0 (http://download.racket-lang.org/)

Then either:

- load emit.rkt in DrRacket
- click "Run"

or (assuming your path includes the Racket binary):

- run this command: racket emit.rkt

This should generate data/index.html.

Note: metadata/summary.csv is from Collberg, et al.
