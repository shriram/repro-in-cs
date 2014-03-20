#lang at-exp racket

(require scribble/base)

(provide top-matter review-format threats-to-validity)

(define top-matter
  (list
   @para{We are evaluating the results presented by the
         @(hyperlink "http://reproducibility.cs.arizona.edu/"
                     "study at the University of Arizona").
         Our goal is to allow authors (or any other interested party)
         to review that study's findings about an individual paper,
         and attempt to reconstruct their findings. We will summarize
         the results here.}
   
   @para{We are grateful to Collberg, et al. for initiating this
         discussion and making all their data available. This is a
         valuable service based on an enormous amount of manual labor.
         Even if we end up disagreeing with some of their findings,
         we remain deeply appreciative of their service to the
         community by highlighting these important issues.}))

(define review-format
  (list
     @para{Please enter your review using the following format:}
     
     @verbatim{
       Time [in minutes]:
       Platform [OS, libraries, etc.]: 
       Skill level:
       - make, but that's about it
       - I can work around issues like failed dependencies and unset environment variables
       - I can build complex software like GCC and the Linux kernel
       Detailed evaluation:}))

(define threats-to-validity
  (list
   @para{Some threats to the validity of our 
         attempt to validate these results include:}
   
   @itemlist[
     @item{Some artifacts may have changed since the time they were tested by
           Collberg's team.}

      @item{Some authors may have fixed their artifacts after reading the build
            logs on the original site.}

      @item{Different platforms may yield different build issues.}]))
