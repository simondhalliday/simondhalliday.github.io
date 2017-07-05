---
layout: post
title: How to set up a site like mine
subtitle: Even when you're a dilettante
tags: [R, RStudio, github, RMarkdown, jekyll]
---

I needed to re-do my website. But, I'm not particularly good at understanding html, github, and related issue. Nonetheless, even a dilettante like me was able to set up a jekyll-enabled site to replace my old site and add a blog. So, what outcomes did I want and how did I achieve them?

What outcomes did I want
------------------------

-   I want to do everything in RStudio by writing an RMarkdown document and using RStudio's built-in git integration.
-   I want synching to be quick so that I can use my site with teaching, research and blogging in a way that is easy to maintain and relatively hassle-free.
-   I want to show my students that markdown is useful and that RMarkdown is even more useful for on-the-fly data analysis, regardless of your role as researcher, working data analyst, or concerned citizen.

How did I do it?
----------------

I used the following suggestions from a variety of sites, with my own tweaks here and there:

-   I read Dean Attali's how-to and used his Beautiful Jekyll template demonstrated [here](http://deanattali.com/2015/03/12/beautiful-jekyll-how-to-build-a-site-in-minutes/).
-   I registered a custom domain name with [Google domains](domains.google.com) (mainly because I have a gmail address and they Googles has my billing info) and I used this how-to by Curtis Larson [here](http://www.curtismlarson.com/blog/2015/04/12/github-pages-google-domains/).
-   I tweaked Jakob Fiksel's workflow shown [here](https://jfiksel.github.io/2017-01-25-hello-world/) by doing the following
-   I use Jakob's folder structure (drafts + blog\_images) while adding a folder for bibliographies (`/bib`) in my website directory. I'll put all .bib files in this directory.
-   I use the `github_document` .Rmd template because I want to include citations and I couldn't get this to work with the `keep_md` option with standard RMarkdown documents. See documentation [here](http://rmarkdown.rstudio.com/github_document_format.html).
-   I use Jacob's `make_post.sh` script to move edits from my `_drafts` folder to the `_posts` folder and I sync everything up with github.
-   E voilà!

Conclusion
----------

So how did the process all unfold? I have a textbook I'm working on and as a result my website needed to be updated because we're negotiating with publishers and I need my best foot forward. I've been getting more involved in debates involving transparency in teaching and research, e.g. through my involvement as a TIER Fellow and through social media. I like to demonstrate to others how easy it is to get data and to be an informed citizen, especially in situations when you see "studies" with "results" that don't pass the sniff test (see my very first [blog post](/2017-07-04-sairr-check/) on this topic where I was trying to understand the SAIRR's report on transformation in South Africa). I hope you've found this how-to useful. Best of luck setting up your site and many thanks to those whose well-trodden footprints I walked in to get to the point where I could achieve what I wanted to achieve, dilettante that I am.
