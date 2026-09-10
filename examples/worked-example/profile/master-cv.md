# Jane Doe

jane@example.com · +31 6 12345678 · Amsterdam, Netherlands
github.com/janedoe · linkedin.com/in/janedoe

<!-- A fictional master CV, written for the cv-kit worked example. Jane Doe does not exist. -->
<!-- Note the length. A master CV is deliberately too long. /jd cuts it down per application. -->

## Summary

Backend engineer, six years, mostly Python and PostgreSQL. I have spent most of that time on
systems where somebody was waiting for a response, so performance work is the thread through
all of it. I pick up new stacks fast.

## Experience

**Senior Backend Engineer** · Northwind Freight · Rotterdam · Mar 2023 – Present

- Cut the nightly settlement job from 6 hours to 38 minutes by replacing row-by-row updates with a single batched CTE.
- Rewrote the pricing API on FastAPI. p95 latency fell from 1.9s to 210ms.
- Introduced Celery for the four longest-running synchronous endpoints. Timeout errors dropped from roughly 300 a week to under 10.
- Ran the on-call rotation for the billing service for 18 months.
- Mentored two junior engineers through their first year.

**Backend Engineer** · Kestrel Health · Amsterdam · Jun 2021 – Feb 2023

- Built the appointment booking API on Django REST Framework, serving 45,000 patients.
- Fixed a PostgreSQL query that scanned 2.4 million rows on every page load. Added a partial index and cut the page from 4.1s to 90ms.
- Migrated the deployment from bare EC2 to ECS on Docker, which took the release process from 40 minutes to 6.
- Wrote the integration test suite for the scheduling module, from zero to 140 tests.

**Junior Software Engineer** · Bramble Studio · Utrecht · Sep 2019 – May 2021

- Built internal dashboards in Flask and React for six agency clients.
- Automated the monthly reporting pipeline, which had been manual and took two days.
- Handled first-line support for the three products I had shipped.

**Freelance Developer** · Self-employed · Remote · Jan 2018 – Aug 2019

- Delivered eight small web projects for local businesses, mostly WordPress and custom PHP.

## Education

**MSc Computer Science** · Delft University of Technology · 2016 – 2018
Specialization: distributed systems. Thesis on consistency trade-offs in geo-replicated stores.

**BSc Software Engineering** · Hogeschool Utrecht · 2012 – 2016

## Projects

**Tramline** (open-source departure board for Dutch public transport)

- Built a real-time departure board that reads the NS and GVB feeds, in Python and React.
- Handles 400 requests a minute on a single $6 VPS. 1,200 GitHub stars.

**Slowquery** (PostgreSQL query plan visualiser)

- Parses EXPLAIN ANALYZE output and renders it as a flame graph in the browser.
- Written in Python and TypeScript. Used internally at two former employers.

**Pantry** (household inventory app)

- Personal project. React Native, FastAPI, PostgreSQL.
- Never launched publicly. Built to learn React Native.

## Skills

**Languages:** Python, TypeScript, SQL, Go (reading), PHP (legacy)
**Frameworks:** FastAPI, Django, Flask, React, Celery
**Data:** PostgreSQL, Redis, Elasticsearch
**Infrastructure:** Docker, AWS (ECS, RDS, S3), GitHub Actions, Terraform (basic)
**Practices:** Performance profiling, query optimisation, integration testing, on-call

## Languages

Dutch (B1, conversational), English (fluent), German (A2)

## Achievements

- Speaker, PyGrunn 2024: "Six hours to 38 minutes: what the query planner was trying to tell me"
- Maintainer of Tramline, 1,200 stars, 14 contributors
