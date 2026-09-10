# Jane Doe

jane@example.com · +31 6 12345678 · Amsterdam, Netherlands · [github.com/janedoe](https://github.com/janedoe) · [linkedin.com/in/janedoe](https://linkedin.com/in/janedoe)

## Summary

Backend engineer with six years in Python and PostgreSQL. I work on systems where somebody is waiting for a response, so performance is the thread through all of it. I have taken a 6-hour batch job to 38 minutes and a 1.9s API to 210ms. I pick up new stacks fast.

## Experience

**Senior Backend Engineer** · Northwind Freight · Rotterdam · Mar 2023 – Present

Northwind Freight runs freight brokerage software for road haulage across northern Europe.

- Cut the nightly settlement job from 6 hours to 38 minutes. Replaced row-by-row updates with a single batched CTE.
- Rewrote the pricing API on FastAPI. p95 latency fell from 1.9s to 210ms.
- Moved the four longest-running synchronous endpoints onto Celery. Weekly timeout errors fell from about 300 to under 10.
- Ran the on-call rotation for the billing service for 18 months.

**Backend Engineer** · Kestrel Health · Amsterdam · Jun 2021 – Feb 2023

Kestrel Health builds patient scheduling software for Dutch general practices.

- Fixed a PostgreSQL query that scanned 2.4 million rows on every page load. Added a partial index and cut the page from 4.1s to 90ms.
- Built the appointment booking API on Django REST Framework, serving 45,000 patients.
- Migrated deployment from bare EC2 to ECS on Docker. Release time fell from 40 minutes to 6.

**Junior Software Engineer** · Bramble Studio · Utrecht · Sep 2019 – May 2021

Bramble Studio is a small Utrecht agency building internal tools for its clients.

- Automated the monthly reporting pipeline, which had been manual and took two days.

**Freelance Developer** · Self-employed · Remote · Jan 2018 – Aug 2019

- Delivered eight small web projects for local businesses.

## Projects

**Tramline** (open-source real-time departure board for Dutch public transport)

- Built the service in Python and React against the NS and GVB feeds.
- Serves 400 requests a minute on a single $6 VPS. 1,200 GitHub stars.

**Slowquery** (browser tool that renders PostgreSQL query plans as a flame graph)

- Parses EXPLAIN ANALYZE output and draws it in the browser. Python and TypeScript.
- Two former employers use it internally.

## Education

**MSc Computer Science** · Delft University of Technology · 2016 – 2018\
Specialization: distributed systems.

**BSc Software Engineering** · Hogeschool Utrecht · 2012 – 2016

## Skills

**Languages:** Python, SQL, TypeScript, Go (reading)\
**Frameworks:** FastAPI, Celery, Django, Flask, React\
**Data:** PostgreSQL, Redis, Elasticsearch\
**Infrastructure:** Docker, AWS (ECS, RDS, S3), GitHub Actions, Terraform (basic)\
**Practices:** Performance profiling, query plan analysis, background job pipelines, on-call\
**Spoken:** English (fluent), Dutch (B1), German (A2)
