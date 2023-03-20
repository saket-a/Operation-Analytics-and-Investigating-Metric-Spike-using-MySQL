# Operation-Analytics-and-Investigating-Metric-Spike-using-MySQL
This project involves the operation analytics and investigates certain metric spikes of a company data using MySQL.

The operation analytics and metric spike investigation is done on separate datasets.

The SQL implementation file and all datasets have been uploaded in the repository.

### Technology Stack
MySQL Workbench version 8.0.32

### File Description
- Operation Analytics and Investigating Metric Spike Project.sql : The main file where all the SQL queries have been implemented.
- dataset.zip : The folder contains all the datasets.

### Dataset
1. Operation Analytics
The dataset *job data.xlsx* contains job review data and has the following columns/attributes:
- job_id: unique identifier of jobs
- actor_id: unique identifier of actor
- event: decision/skip/transfer
- language: language of the content
- time_spent: time spent to review the job in seconds
- org: organization of the actor
- ds: date in the yyyy/mm/dd format

2. Investigating Metric Spike
The dataset *users.csv* contains user information and has the following columns/attributes:
- user_id: unique identifier of users
- created_at: date and time of account creation
- company_id: unique identifier of user company
- language
- activated_at: date and time of user account activation
- state: user account activation status (pending/activated)

The dataset *events.csv* contains the information of all events or actions performed by users on the company portal and has the following columns/attributes:
- user_id: unique identifier of users
- occurred_at: date and time of the event
- event_type
- event_name
- location: country where the event was performed
- device: device on which the event was performed
- user_type

The dataset *email_events.csv* contains only the email related actions and has the following columns/attributes:
- user_id: unique identifier of users
- occurred_at: date and time of the event
- action: what email event happened
- user_type

### Insights derived
1. Operation Analytics
- Number of jobs reviewed
- Throughput
- Percentage share of each language
- Duplicate rows

2. Investigating Metric Spike
- Weekly User Engagement
- User Growth per Product
- Weekly Retention
- Weekly Engagement per Device
- Email Engagement - Overall and per Device

### Use Case
1. Operation Analytics is the analysis done for the complete end to end operations of a company. With the help of this, the company then finds the areas on which it must improve upon. Being one of the most important parts of a company, this kind of analysis is further used to predict the overall growth or decline of a company’s fortune. It means better automation, better understanding between cross-functional teams, and more effective workflows.
2. Investigating metric spike is also an important part of operation analytics as being a Data Analyst you must be able to understand or make other teams understand questions like- Why is there a dip in daily engagement? Why have sales taken a dip? Etc. Questions like these must be answered daily and for that its very important to investigate metric spike.
