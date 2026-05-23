// Erase everything
CALL apoc.schema.assert({}, {})

// Create Entities
CREATE CONSTRAINT FOR (p:Person) REQUIRE p.name IS UNIQUE;
CREATE CONSTRAINT FOR (pr:Project) REQUIRE pr.name IS UNIQUE;
CREATE CONSTRAINT FOR (o:Organization) REQUIRE o.name IS UNIQUE;

// Inserting data
LOAD CSV WITH HEADERS FROM 'file:///git_selection.csv' AS row
WITH row
WHERE row.real_name IS NOT NULL AND row.project_name IS NOT NULL

// 1. Group and clean properties to handle duplicates/whitespace
WITH trim(row.real_name) AS pName, 
     trim(row.project_name) AS projName, 
     trim(row.organization) AS orgName, 
     row.svn_id AS svnId, 
     toInteger(row.num) AS numVal,
     row.role_on_project AS rawRole

// 2. Aggregate the individual roles into an array grouped by Person + Project
WITH pName, projName, orgName,
     max(svnId) AS finalSvnId, 
     max(numVal) AS finalNum,
     collect(DISTINCT rawRole) AS rawRoles

// 3. Clean up the roles array (filter out nulls and "NA" strings)
WITH pName, projName, orgName, finalSvnId, finalNum,
     [role IN rawRoles WHERE role IS NOT NULL AND role <> "NA"] AS cleanRoles

// 4. Create Unique Core Entities
MERGE (person:Person {name: pName})
MERGE (project:Project {name: projName})

// 5. Build the CONTRIBUTED edge (Person -> Project)
MERGE (person)-[r:CONTRIBUTED]->(project)
SET r.num = finalNum,
    r.svn_id = finalSvnId,
    r.roles = cleanRoles

// 6. Build the WORKS_FOR edge conditionally (Person -> Organization)
FOREACH (oName IN CASE WHEN orgName IS NOT NULL AND orgName <> "NA" AND orgName <> "" THEN [orgName] ELSE [] END |
    MERGE (org:Organization {name: oName})
    MERGE (person)-[:WORKS_FOR]->(org)
)

// 1
MATCH (p:Person)
RETURN p

// 2
MATCH (p:Person)
RETURN p.name

// 3
MATCH (pr:Project)<-[:CONTRIBUTED]-(p:Person)
WITH pr, count(p) as n_people
WHERE nPeople > 0
RETURN pr.name, n_people

// 4 + 5
MATCH (p:Person)-[:CONTRIBUTED]->(pr:Project)
WITH p, count(pr) as n_projects
ORDER BY n_projects DESC
RETURN p.name, n_projects

// 6 
MATCH (pr:Project)<-[:CONTRIBUTED]-(p:Person)
WITH pr, count(p) as n_people
RETURN pr.name, n_people

// 7
MATCH (pr:Project)<-[r:CONTRIBUTED]-(p:Person)
WHERE "Committer" IN r.roles
WITH pr, count(p) as n_committers
RETURN pr.name, n_committers

// 8
MATCH (p:Person)-[:CONTRIBUTED]->(pr:Project)<-[:CONTRIBUTED {svn_id: "atm"}]-(atm:Person)
WHERE p <> atm
WITH atm, p, pr
RETURN atm.name, p.name, pr.name

// 9
MATCH (p:Person)-[r:CONTRIBUTED]->(pr:Project)<-[r_atm:CONTRIBUTED {svn_id: "atm"}]-(atm:Person)
WHERE p <> atm
AND "Committer" IN r.roles
AND "PMC" IN r_atm.roles
WITH atm, r_atm, p, r, pr
RETURN atm.name, r_atm.roles, p.name, r.roles, pr.name