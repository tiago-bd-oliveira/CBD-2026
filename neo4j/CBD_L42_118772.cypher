// 118772

// 1
MATCH (p:Person)-[:DIRECTED]->(m)<-[:ACTED_IN]-(p)
RETURN p.name, m.title;

// 2
MATCH (m:Movie)<-[r:ACTED_IN]-(p:Person)
WHERE m.released > 2005
RETURN m.title, p.name

// 3
MATCH (n1)-[r]->(n2)
WITH n1, n2, count(r) AS relCount
WHERE relCount > 1
RETURN n1, relCount, n2

// 4
MATCH (p1:Person)-[:REVIEWED]->(m:Movie)<-[:REVIEWED]-(p2:Person)
WHERE p1 <> p2
RETURN p1.name, p2.name, m.title

// 5
// vários (plural) significa pelo menos 2
MATCH (p1:Person)-[:ACTED_IN]->(m)<-[:ACTED_IN]-(p2:Person)
WITH p1, p2, count(m) as movies_together
WHERE movies_together > 1
RETURN p1.name, p2.name, movies_together

// 6
MATCH (p:Person)-[:ACTED_IN]->(m:Movie {title: "Apollo 13"})
WITH m.released - p.born as age_at_release
RETURN avg(age_at_release)

// 7
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m, avg(m.released - p.born) as avg_age
ORDER BY avg_age DESC
LIMIT 10
RETURN m.title, avg_age

// 8
MATCH (p:Person)-[:ACTED_IN]->(m:Movie)
WITH m, avg(m.released - p.born) AS avg_age
ORDER BY avg_age ASC
LIMIT 1
MATCH (actors:Person)-[r:ACTED_IN]->(m)
RETURN actors, r, m

// 9
MATCH path=shortestPath(
  (:Person {name: "John Cusack"})-[*]-(:Person {name: "Demi Moore"})
)
RETURN path

// 10
MATCH path=shortestPath(
  (:Person {name: "Keanu Reeves"})-[*]-(:Person {name: "Tom Cruise"})
)
RETURN length(path)


