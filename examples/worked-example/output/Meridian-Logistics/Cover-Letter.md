Dear Meridian Logistics hiring team,

A routing service that takes 40 seconds to replan a day is not a slow service. It is a service that changed the shape of somebody's morning. If a dispatcher replans five times before lunch, your software has quietly taken three and a half minutes of their day and, worse, taught them to think twice before pressing the button. That second effect is the expensive one, because it means the plan they ship is not the plan they wanted.

I spend most of my time on that class of problem. At Northwind Freight I took the nightly settlement job from six hours to 38 minutes by replacing row-by-row updates with a single batched CTE, and I rewrote our pricing API on FastAPI, which moved p95 latency from 1.9 seconds to 210 milliseconds. Before that, at Kestrel Health, I found a query scanning 2.4 million rows on every page load and cut the page from 4.1 seconds to 90 milliseconds with a partial index. Your posting also asks for background job processing, and that is the piece I would reach for here: I moved Northwind's four worst synchronous endpoints onto Celery, and weekly timeout errors went from about 300 to under 10.

Here is my honest caveat. I have never worked on routing or optimisation problems, and I have not run Kubernetes in production. I am not going to arrive with an opinion about vehicle routing heuristics. What I would arrive with is the ability to read your query plans in week one and tell you where the 40 seconds actually goes, which in my experience is rarely where the team assumed it was. The domain I can learn from your carriers. The profiler I already know.

What draws me to Meridian specifically is that your posting says the routing service was written fast in 2020 and has held up better than it should have. That is an unusually honest thing to put in a job ad, and it tells me the team can look at its own code without flinching. It also tells me the work is real: not a rewrite for its own sake, but a system with paying carriers on it that needs to get faster without going down. I would also rather talk to the operations teams than guess at what they do, and your posting puts that in the responsibilities instead of treating it as optional.

I am in Amsterdam and a Dutch citizen, so the hybrid arrangement works and there is no sponsorship to sort out. I would be glad to walk through the settlement job rewrite in more detail, including the part where my first attempt made it slower. I gave a talk on it at PyGrunn last year, so I have already had to explain it to a room.

Best regards,\
Jane Doe\
jane@example.com\
github.com/janedoe\
linkedin.com/in/janedoe
