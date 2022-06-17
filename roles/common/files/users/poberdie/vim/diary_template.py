#!/usr/bin/python3
import sys
import datetime
from os.path import basename, splitext

WEEKLY_REVIEW_WEEKDAY = None

template = "# {date} | "
template_weekly_review = """# {date} | Weekly Review

## Weekly Review
:weekly-review:

**Get Clear**

- [ ] Collect loose papers and materials
- [ ] Get "IN" to zero
- [ ] Empty your head

**Get Current**

- [ ] Review "Next Actions" in your task lists
- [ ] Previous calendar data
- [ ] Upcoming calendar data
- [ ] Review "Waiting For" List
- [ ] Review projects (and larger outcome) lists
- [ ] Review any relevant checklists

**Get Creative**

- [ ] Review "Someday/Maybe" list
- [ ] Be "Creative and Courageous" about new ideas"""

date = (datetime.date.today() if len(sys.argv) < 2
        # Expecting filename in YYYY-MM-DD.foo format
        else datetime.datetime.strptime(splitext(basename(sys.argv[1]))[0], "%Y-%m-%d").date())

if WEEKLY_REVIEW_WEEKDAY is not None and date.weekday() == WEEKLY_REVIEW_WEEKDAY:
    print(template_weekly_review.format(date=date))
else:
    print(template.format(date=date))
