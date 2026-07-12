# Customer Segmentation & Retention Strategy

Data-driven customer segmentation and churn analysis for a telecom provider — using RFM feature engineering, K-Means clustering, SQL analytics, and Power BI reporting to identify high-value and at-risk customer cohorts.

![Python](https://img.shields.io/badge/Python-Pandas-blue)
![SQL Server](https://img.shields.io/badge/SQL%20Server-SSMS-red)
![Power BI](https://img.shields.io/badge/Power%20BI-DAX-yellow)

## Overview
This project analyzes ~6,400 telecom customer records to uncover behavioral segments, quantify churn risk, and translate findings into retention strategy. Using K-Means clustering on RFM-style features, customers were grouped into 4 behavioral cohorts — revealing a **27% overall churn rate** and **~17% of total revenue sitting at risk**, concentrated unevenly across segments.

## Business Problem
Telecom providers lose revenue not just from churn volume, but from *which* customers churn. Treating all customers with the same retention strategy wastes budget on low-value accounts while under-protecting high-value ones. This project segments the customer base so retention efforts — pricing, outreach, support — can be prioritized by actual business impact, not guesswork.

## Dataset
Source: `Telecom_Dataset.csv` — telecom customer records including:
- **Demographics**: age, gender, marital status, state
- **Account details**: tenure, contract type, payment method, paperless billing
- **Services**: internet type, streaming, security/backup add-ons, multiple lines
- **Billing**: monthly charge, total revenue, refunds, extra data charges
- **Churn**: customer status, churn category, churn reason

## Tools & Tech Stack
| Tool | Purpose |
|---|---|
| Python (Pandas) | Data cleaning, feature engineering |
| Matplotlib | Elbow method validation |
| SQL Server (SSMS) | Query layer — churn rate, revenue at risk, KPIs |
| Power BI + DAX | Interactive dashboard, stakeholder reporting |

## Methodology

**1. Data Cleaning (Python)**
- Contextual null handling — blank service fields meant "not subscribed," not missing data (e.g., filled as "No Internet Service" rather than dropped)
- Corrected invalid negative billing values
- Reviewed customers with "Joined" status (no tenure history yet) as a distinct edge case, since they carry no behavioral signal for segmentation

**2. RFM Feature Engineering**
No transaction-date field existed in the raw data, so RFM logic was adapted to a telecom context:
- **Recency proxy** → Tenure in months
- **Frequency proxy** → Referrals made + count of active add-on services subscribed
- **Monetary proxy** → Total revenue generated

**4. SQL Analysis Layer**
- Cleaned, segmented data loaded into SQL Server
- Queries built for churn rate by segment, revenue at risk, and retention KPIs (contract mix, average tenure)

**5. Power BI Dashboard**
- Connected to the SQL Server segmented table
- DAX measures for churn rate, revenue at risk, and retention KPIs
- Visuals built for segment comparison and revenue exposure tracking

## Key Insights

| Segment | Customers | Churn Rate | Avg Tenure | Total Revenue | Revenue at Risk | % at Risk |
|---|---|---|---|---|---|---|
| High-Value Champions | 1,406 | 14.65% | 17.3 mo | ₹10,558,408 | ₹1,519,049 | 14.39% |
| Steady Long-Tenure (At Risk) | 1,932 | 31.11% | 28.9 mo | ₹3,614,728 | ₹798,559 | 22.09% |
| New & Engaged (At Risk) | 1,554 | 32.11% | 9.5 mo | ₹2,817,894 | ₹636,924 | 22.60% |
| New & Disengaged | 1,526 | 27.92% | 10.7 mo | ₹2,480,360 | ₹457,429 | 18.44% |

**Takeaways:**
- High-Value Champions have the *lowest* churn rate (14.65%) but the *largest* absolute revenue at risk — their revenue base is simply larger, so even modest churn there costs more than high churn% elsewhere.
- Long tenure alone doesn't guarantee loyalty: the Steady Long-Tenure segment averages 29 months tenure yet still churns at 31%+.
- Contract type tracks closely with retention — Champions skew toward longer-term contracts (1,144 vs. 262 month-to-month), while at-risk segments lean month-to-month.

## Business Recommendations
1. **Loyalty pricing for Champions** — tenure-based discounts or renewal incentives for the highest-revenue segment, since even small churn% here has outsized dollar impact.
2. **Proactive outreach for at-risk cohorts** — targeted retention contact for Steady Long-Tenure and New & Engaged segments ahead of contract renewal, since both exceed 30% churn for different underlying reasons.
3. **Tiered support model** — white-glove support for Champions; structured onboarding for New & Disengaged customers to build engagement early, before disengagement turns into churn.

## Repository Structure
```
Customer-Segmentation-Retention-Strategy/
│
├── README.md
├── data/
│   ├── Telecom_Dataset.csv
│   └── Telecom_Final_Segmented.csv
├── notebooks/
│   └── 01_eda_cleaning_rfm_kmeans.ipynb
├── sql/
│   └── telecom_analytics_queries.sql
├── powerbi/
│   └── Telecom_Dashboard.pbix
└── docs/
    └── executive_summary.pdf
```

## How to Reproduce
```bash
git clone https://github.com/EktaC06/Customer-Segmentation-Retention-Strategy.git
pip install pandas scikit-learn matplotlib
```
1. Run `notebooks/01_eda_cleaning_rfm_kmeans.ipynb` — cleaning, RFM, clustering
2. Import `data/Telecom_Final_Segmented.csv` into SQL Server
3. Run `sql/telecom_analytics_queries.sql` for the KPI query layer
4. Open `powerbi/Telecom_Dashboard.pbix` in Power BI Desktop, refresh data

## Dashboard
*(Screenshot to be added once the Power BI dashboard is finalized)*

## Future Work
- Predictive churn model (logistic regression / XGBoost) to flag at-risk customers before they churn
- Automated monthly data refresh pipeline
- A/B testing of retention offers by segment

---
**Author:** [EktaC06](https://github.com/EktaC06)
