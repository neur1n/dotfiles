---
name: read-paper
description: Read and explain academic papers through structured analysis, with emphasis on motivation, method design, experiments, limitations, reproducibility, and applications. Use this skill when the user wants to understand a paper, not to write a peer-review report.
metadata:
  category: research
  audience: academic-paper-readers
---

# Paper Reading and Analysis Skill

Read and explain a specific academic paper, emphasizing motivation, method,
evidence, limitations, and reproduction. This is not a generic literature
search or peer-review-report workflow.

## Field-specific specifications

Before analysis, read all specifications in `field/` relevant to the paper's
research problem, method, and claims. Use the general requirements alone when
none match.

- `field/ml-ai.md`: machine learning and AI methods.
- `field/hpc-system.md`: high-performance computing and systems.

These files add domain-specific requirements under the same rules below.
Integrate relevant items into the indicated subsections, without separate
field-specific output sections or duplicate analysis.

## Evidence and scope

- Base the analysis primarily on the provided paper content. If none is
  available, ask for a PDF or text. With only an abstract, limit the analysis
  to what the abstract supports.
- Do not invent details or findings. Identify relevant missing information,
  distinguishing omissions in the paper from gaps in a provided excerpt; skip
  irrelevant checklist items rather than listing them as missing.
- Distinguish author claims, reported evidence, and your interpretation. Label
  inferences and explain their basis and uncertainty. Mark supplementary domain
  knowledge separately from paper-derived analysis.
- Ground comparisons in the paper's baselines, related work, and experiments.
  Separate demonstrated effects from evidence for the proposed causal
  explanation; improvement alone does not establish why a method works.
- Cite sections, figures, tables, algorithms, or equations where useful.
  Include units, baselines, and conditions for numerical results; distinguish
  reported values from your calculations. Do not generalize beyond evidence.
- Judge artifact availability from the paper unless the user explicitly permits
  external verification. Distinguish available artifacts from promised releases
  and author-provided reproduction instructions from your proposed steps.

## Output

Use the six sections and subsections below. Focus on understanding the method
and evidence, not generic praise or repetition of the introduction. Apply only
relevant requirements, using direct language and explaining necessary jargon.

## 1. Summary

### 1a. One-sentence core idea

State the core idea in one concise, concrete sentence.

### 1b. Memorization-friendly pipeline

Give 3-5 steps describing actual operations plainly, without metaphors
or unexplained paper-specific terms. Make the method understandable from this
pipeline alone.

## 2. Motivation

### 2a. Why do the authors propose this method?

Explain the problem setting, why it matters, and what motivates the method.

### 2b. What are the limitations of existing methods?

Identify the limitations discussed in the paper, when they matter, and the
evidence supporting the problem diagnosis.

### 2c. What is the research hypothesis or core intuition?

Explain why the authors expect their design to address those limitations.

## 3. Method Design

Give this section the most detail.

### 3a. Method pipeline: input → processing → output

Explain each step's inputs, operation, purpose, and outputs, including input
preparation and how results pass between steps. Separate distinct preparation
and execution phases, including shared state. Identify objectives, constraints,
and assumptions.

### 3b. Architecture and components

Explain component responsibilities, interfaces, and data and control flow,
using the architecture figure when available. Identify new versus inherited
components. For methods without an explicit architecture, explain algorithmic
organization instead.

### 3c. Formulas, algorithms, and key mechanisms

Explain key variables, what each formula optimizes, constrains, or measures,
and how the algorithm or mechanism achieves its goal. Explain practical meaning
rather than merely translating notation.

## 4. Comparison with Other Methods

### 4a. Essential differences from existing mainstream methods

Explain substantive differences from the baselines and related approaches
discussed in the paper.

### 4b. Novelty and contribution level

Assess what is new, why it matters, and its supporting evidence. Do not inflate
novelty or automatically rank engineering or integration below theoretical
work. State when the available prior-work context prevents a firm assessment.

### 4c. Applicable scenarios and scope

Identify suitable and unsuitable problems, input conditions, scales, and
environments, and the assumptions limiting applicability.

### 4d. Comparison table

Summarize the comparison using at least these columns:

| Method Type / Representative Method | Core Idea | Advantages | Disadvantages | Improvement |
| ----------------------------------- | --------- | ---------- | ------------- | ----------- |

## 5. Experimental Results and Advantages

### 5a. How do the authors validate the method?

Describe inputs, tasks or workloads, baselines, metrics, and key implementation
and evaluation settings. Explain how controlled experiments isolate design
effects and how other tests examine efficiency, robustness, or applicability.

### 5b. Key experimental results

Prioritize representative results from the main tables and figures. Give
concrete values and improvement margins where available, identifying the
baseline and metric; otherwise describe only supported qualitative findings.

### 5c. Where is the advantage most obvious?

Explain where the benefit is strongest, with evidence, and where it disappears
or comes with tradeoffs.

### 5d. Limitations and potential issues

Assess applicability limits, resource overhead, deployment complexity, failure
cases, and gaps in baselines, coverage, or causal evidence. Distinguish
acknowledged limitations from your grounded inferences.

## 6. Learning and Application

### 6a. Open-source status and key reproduction steps

Report the stated availability of code, data, and other artifacts separately.
Summarize how to prepare inputs and the environment, implement core components,
configure and execute the method, and repeat the key validation experiments.

### 6b. Implementation details and practical notes

Highlight parameters, initialization, dependencies, resource requirements, and
evaluation details that affect implementation or reproducibility.

### 6c. Can the method be transferred to other tasks?

Identify plausible target tasks, directly reusable components, required
adaptations, inputs and resources, and likely obstacles. Keep proposed transfer
separate from transfer demonstrated in the paper.
