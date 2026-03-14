# Week 01 - Log Analysis

## Commands Learned

### grep - Filter logs
```bash
grep "500" access.log              # find 500 errors
grep "^192.168.1.1 " access.log   # exact IP match
```

### awk - Extract columns
```bash
awk '{print $1}' access.log       # get IP column
awk '{print $5}' access.log       # get endpoint column
```

### Full Investigation Pipeline
```bash
# Which IPs causing most 500 errors?
grep "500" access.log | awk '{print $1}' | sort | uniq -c | sort -rn

# Which endpoints causing most 500 errors?
grep "500" access.log | awk '{print $5}' | sort | uniq -c | sort -rn
```

## Interview Scenario
Production is down → check logs → find errors → find which IP/endpoint → report
