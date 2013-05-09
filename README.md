Graph search for academic articles.

Authors: Aman Kapur and Jimmy Wu

Built at Olin College of Engineering as a part of an AI class.

![Graph visualization](https://github.com/fireblade99/journalgraph/blob/master/public/graphvis.png)

Introduction
=====
We built a graph database of indexed science journal articles by scraping http://arxiv.org/

We have around 2000 articles, all in the realm of high energy physics and quantum cosomology.

Our scraping functions ensure a graph as complete as the information arxiv gives us.

We implemented search algorithms to allow the user to search using different ranking criteria.

Front-end: a search box which allows the user to choose ranking functions
* Simple boolean match, ranking by article id
* Term frequency (TF) ranking
* TFIDF ranking
* PageRank
* PageRank and TFIDF (most accurate and relevant)

Users can "explore" a topic by traversing our graph.
* They can view related articles (generated by graph properties and ranked by Levenshtein distance).
* They can also traverse by author.
* They can view all articles given by a given author.
* They can look at authors related to a given author.

Database representation
=====
Nodes are articles and authors.
Edges are articles-article, article-author, and author-author relations.

Article nodes hold metadata such as publication date, and subject category.
They also hold information to aid the search engine:
* abstract keywords via automatic summarization
* ranking factors, such as PageRank

PageRank
=====

To compute PageRank, we first generate the transition probability matrix for our graph.
Here is an example transition probability matrix, where each directed edge coming out of a node is weighted by 1/n,
and n is that node's total number of outgoing edges.

     a   b   c   d
 a | 0   0  .33  0  |
 b | 1   0  .33  0  |
 c | 0   0   0   0  |
 d | 0   1  .33  0  |

This matrix represents the following graph:
 a ----> b
 ^     /^|
 |   /   |
 | /     |/
 c ----> d

Each row in the matrix corresponds to an article which is being cited.
As you can see, article a cites article b, so its edge has weight 1.
However, article c cites articles a, b, and c, so each edge has weight 1/3.

TFIDF
=====
