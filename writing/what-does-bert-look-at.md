---
title: "Papers are Neat: What Does BERT Look At?"
author:
  - Sam Stevens
keywords:
  [
    academic paper,
    interesting paper,
    bert,
    natural language processing,
    analysis,
    attention,
    transformer,
  ]
abstract: My take on "What Does BERT Look At?" and what it means for future work with BERT.
references:
  - id: clark2019
    type: no-type
    author:
      - family: Clark
        given: Kevin
      - family: Khandelwal
        given: Urvashi
      - family: Levy
        given: Omer
      - family: Manning
        given: Christopher D.
    issued:
      - year: 2019
    title: What does bert look at? An analysis of bert’s attention
    URL: http://arxiv.org/abs/1906.04341
link-citations: true
---

# Papers are Neat: What Does BERT Look At?

My undergraduate thesis focuses on fine-tuning pretrained language models on sentence classification.
Because of this, I've been reading a lot about BERT, its derivatives (RoBERTa, SciBERT) and how BERT actually works on the inside.
One of the cooler papers I've read is "What Does BERT Look At? An Analysis of BERT's Attention" [@clark2019].

> _Note: I'll use this styling to highlight direct quotes from the paper._

The gist of the paper is: Clark and his co-authors find that the attention heads within BERT find some grammatical structures with surprising accuracy, _given that they're never trained to do this_.

> For example, we find heads that find direct objects of verbs, determiners of nouns, objects of prepositions and objects of possessive pronouns with >75% accuracy.

Just as Clark says, these results are _crazy_ because BERT's not ever asked to find these patterns.
It's just given a bunch of data and asked to predict most likely words in a context.

If you're unfamiliar with BERT, attention heads, or transformer models in general, I'll do my best to make this approachable.
If you're interested in how this all works, I recommend the following.

1. For attention: [Jay Alammar's intro to attention in a neural MT context](https://jalammar.github.io/visualizing-neural-machine-translation-mechanics-of-seq2seq-models-with-attention/)
2. For transformer models: [Jay Alammar's intro to transformer models](https://jalammar.github.io/illustrated-transformer/)
3. For BERT (a little more involved):
   1. [Part 1](https://towardsdatascience.com/deconstructing-bert-distilling-6-patterns-from-100-million-parameters-b49113672f77)
   2. [Part 2](https://towardsdatascience.com/deconstructing-bert-part-2-visualizing-the-inner-workings-of-attention-60a16d86b5c1)
   3. [Explore with the `huggingface` library](https://mccormickml.com/2019/07/22/BERT-fine-tuning/)

## Attention/Transformers/BERT TL;DR

Attention is a mechanism for models to figure out which word is most important at different points in a sentence.
Transformers use attention exclusively (it used to be a supplemental mechanism) to great success.
BERT is one of the most popular and succesful transformer models, released by Google in 2019.
In BERT (specifically the base model), a sentence goes through 12 layers of modeling, and in each layer, for each word, attention _heads_ point to another word in the sentence as the "most important".

## The Paper

Clark and his co-authors inspect the overall attention trends of and find that some of the attention head in the earlier layers put the majority of their weight on either the next or previous token in the sentence.

> In particular four attention heads (in layers 2, 4, 7, and 8) on average put >50% of their attention on the previous token and five attention heads (in layers 1, 2, 2, 3, and 6) put >50% of their attention on the next token.

They also find that "over half of BERT's attention in layers 6-10 focuses on [SEP]" (the last, artificially added token in a sentence).
They hypothesize that attending to [SEP] is a kind of "no-op" for when the "attention head's function is not applicable."
This finding is further supported by applying gradient-based measures of feature importance and finding that in layer 5, "the same layer where attention to [SEP] becomes high", the gradients for attention to [SEP] dramatically diminish.

> This indicates that attending more or less to [SEP] does not substantially change BERT's outputs, supporting the theory that attention to [SEP] is used as a no-op for attention heads.

## The Cool Stuff

The part of the paper that made me gasp was the analysis of BERT's ability to parse syntactic structures from raw text.
For a variety of syntactic structures ("direct objects of verbs, determiners of nouns, objects of prepositions and objects of possessive pronouns"), Clark and his co-authors look for a particular attention head that best predicts these dependencies.
That means that for the sentence "The cat ate the mouse", the authors look for an attention head points from "mouse" to "ate".
I won't copy the entire table here, but the results in the paper are very positive.
Bert learns these relationships surprisingly well.

What _really_ is nuts, however, is BERT learning the structure of objects of possessive pronouns.
Clark and his co-authors find that BERT does not have an attention head that attends from an object to its possessive pronoun.
For example, for the sentence "I found John's ball!", BERT never attends strongly from "ball" to "John", which is how we (as humans) would diagram this sentence.
Instead, one of BERT's attention heads attends strongly from "ball" to the "'s" after "John".
_BERT learns possessive objects on its own, and differently to humans_

> Such disagreements [between the human and machine annotations] highlight how these syntactic behaviors in BERT are learned as a by-product of self-supervised training, not by copying a human design

Holy. Crap.

BERT learns grammar on its own from just reading a lot of English text.
If that doesn't get you excited about NLP, I don't know what will.
