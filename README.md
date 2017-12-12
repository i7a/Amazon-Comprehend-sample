# README

Sample Code for Amazon Comprehend. Shows average sentiment score of the last 20 tweets of the search result of inputed query.

# usage
`bundle exec rails runner "Tasks::SentimentFromTwitter.execute('amazon')"`
`

```
positive : 0.23963126577436925
negative : 0.024057822281429254
neutral : 0.727054006268736
mixed : 0.009256892037956276
```

only english is accepted since Amazon Comprehend currently supports English and Spanish.
