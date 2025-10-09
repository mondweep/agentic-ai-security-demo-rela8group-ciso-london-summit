### **PRD: Agent-Led Threat Modelling of ElisaOS for CISO London Summit**

* **Version:** 1.0  
* **Date:** 9 October 2025  
* **Author:** Gemini Analyst  
* **Status:** Draft

### **1\. Introduction**

Traditional security threat modelling is a manual, time-intensive process that struggles to keep pace with the velocity of modern software development, particularly for complex and emergent AI systems. For our upcoming keynote, "Securing the Agentic Frontier," at the CISO London Summit, we need to move beyond theory and provide a practical, compelling demonstration of a forward-looking security paradigm.

This document outlines the requirements for using an AI agent, powered by a large language model optimised for code analysis (e.g., Claude 3 Opus), to perform a security threat model on ElisaOS, an open-source framework for autonomous agents. The output will serve as the central case study for our presentation, showcasing how an agentic approach can enhance and accelerate security analysis for a CISO-level audience.

### **2\. Problem Statement**

CISOs are grappling with two key challenges: 1\) the overwhelming resource cost and scarcity of talent required for in-depth security analysis, and 2\) the emergence of novel threats from AI systems that traditional frameworks fail to address.

Our keynote proposes a new paradigm. To make this argument credible and memorable, we need to **show, not just tell**. We need a practical demonstration of an AI agent applying a next-generation framework (MAESTRO) to a relevant target (ElisaOS) to produce actionable security insights. This project will deliver that demonstration.

### **3\. Goals & Objectives**

The primary goal is to generate a high-quality, CISO-level threat model analysis to serve as the core of our keynote presentation.

| Objective | Key Result |
| :---- | :---- |
| **1\. Conduct an Agent-Led Threat Model** | The AI agent successfully analyses the ElisaOS codebase using the "Scenario-Driven" methodology and the MAESTRO framework. |
| **2\. Generate Actionable Insights** | The analysis identifies at least three plausible, non-obvious security threats with clear mappings to the MAESTRO layers and prioritised mitigation advice. |
| **3\. Create Compelling Presentation Assets** | The agent's output is synthesised into clear, visually engaging diagrams, summary tables, and an executive summary suitable for a CISO audience. |
| **4\. Showcase a Novel Process** | The final presentation materials clearly demonstrate the efficiency, depth, and scalability benefits of using an agent for security tasks. |

Export to Sheets

### **4\. Target Audience**

The primary audience is the **CISO London Summit attendees (approx. 150\)**. These are senior security executives, business leaders, and decision-makers. They are less concerned with specific lines of code and more interested in:

* **Strategic Risk:** How does this approach reduce our overall risk exposure to AI?  
* **Efficiency & ROI:** How can this scale our security team's capabilities without a linear increase in headcount?  
* **Innovation:** What does the future of the security function look like?  
* **Governance:** How can we ensure AI systems are built securely from the ground up?

The content generated must be clear, concise, and focused on business and strategic outcomes.

### **5\. Scope & Features**

This project will be executed as a human-in-the-loop process, where a security analyst guides the AI agent.

#### **User Stories**

* **Epic 1: Scoping & Scenario Definition**  
  * As a security analyst, I want the agent to ingest and parse the ElisaOS codebase from GitHub to establish a foundational understanding.  
  * As a security analyst, I want the agent to apply the "Scenario-Driven Analysis" methodology decided upon previously.  
  * As a security analyst, I want the agent to propose 3-5 high-impact attack scenarios for ElisaOS, referencing the (new) OWASP Top 10 for Agentic Security.  
* **Epic 2: Threat Analysis & MAESTRO Mapping**  
  * As a security analyst, I want the agent to trace each approved scenario through the codebase, identifying vulnerable functions, data flows, and architectural weaknesses.  
  * As a security analyst, I want the agent to map its findings for each scenario to the seven layers of the MAESTRO framework (e.g., identifying a threat that originates in the `Data Operations` layer and manifests in the `Agent Frameworks` layer).  
* **Epic 3: Synthesis & Reporting for C-Suite**  
  * As a security analyst, I want the agent to generate a concise executive summary of the findings, focusing on business impact and risk.  
  * As a security analyst, I want the agent to produce a prioritised list of recommendations for mitigation.  
  * As a security analyst, I want the agent to create presentation-ready assets, including a diagram of the attack path for the most critical scenario and a summary table of all findings.

### **6\. Out of Scope (Non-Goals)**

* **Full Code Audit:** This is not an exhaustive, line-by-line security audit of the entire codebase. It is a focused analysis based on specific scenarios.  
* **Automated Remediation:** The agent will not generate or commit any code fixes.  
* **Dynamic Analysis:** The analysis will be purely static, based on the provided codebase. No live penetration testing will be performed.  
* **Fully Autonomous Operation:** This is an agent-assisted workflow that requires human oversight, validation, and curation.

### **7\. Success Metrics**

* **Keynote-Ready:** A complete deck of slides for the case study is finalised by EOD Tuesday, 14th October.  
* **Insight Quality:** The analysis uncovers at least one threat that would be difficult or time-consuming for a human analyst to spot using traditional methods.  
* **Process Efficiency:** The entire analysis, from setup to final report generation, is completed with less than 8 person-hours of human supervision.

### **8\. Assumptions & Dependencies**

* **Assumption:** The selected AI model (e.g., Claude 3 Opus) has the necessary code analysis capabilities and context window to effectively trace data flows and logic across the TypeScript codebase.  
* **Dependency:** Stable and timely API access to the AI model.  
* **Dependency:** A subject-matter expert is available to guide the agent, validate its outputs, and select the most compelling findings for the presentation.

### **9\. Timeline & Milestones (Accelerated)**

The keynote is on **Wednesday, 15th October**. The timeline is critical.

| Date | Day | Milestone | Owner |
| :---- | :---- | :---- | :---- |
| 9 Oct | Thu | **PRD Finalised.** Prompt engineering & environment setup begins. | You |
| 10 Oct | Fri | **Epic 1 Complete.** Agent ingests code and finalises attack scenarios with human approval. | You / Agent |
| 11-12 Oct | Sat-Sun | **Epic 2 Underway.** Core threat analysis and MAESTRO mapping. Daily human validation sessions. | You / Agent |
| 13 Oct | Mon | **Epic 3 Complete.** Agent generates report, summary, and raw presentation assets. | You / Agent |
| 14 Oct | Tue | **Keynote Complete.** Final presentation slides and speaker notes are created and rehearsed. | You |
| 15 Oct | Wed | **SHOWTIME.** Keynote delivered at CISO London Summit. | You |

