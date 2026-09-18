---
name: read-paper
description: Read and explain academic papers through structured analysis, with emphasis on motivation, method design, experiments, limitations, reproducibility, and applications. Use this skill when the user wants to understand a paper, not to write a peer-review report.
compatibility: opencode
metadata:
  category: research
  audience: academic-paper-readers
---

# Paper Method Review Skill

## What this skill does

Use this skill to read and analyze an academic paper or paper-like material provided by the user, with particular emphasis on the methodology, experimental evidence, limitations, and reproduction details.

## When to use this skill

Use this skill when the user asks to read, summarize, review, understand, analyze, or reproduce an academic paper, especially when they provide a PDF, abstract, method section, experiment section, appendix, supplementary material, or notes about a paper.

Do not use this skill for generic literature search unless the user provides paper content or explicitly asks to analyze a specific paper.

## Instructions

Please summarize and analyze the paper based on the following requirements after reading the provided paper content. The paper content may be a PDF, full-text excerpt, methodology section, experiment section, or abstract provided by the user.

Important assumptions:

* All analysis must be primarily based on the paper content provided by the user.
* If the user has not provided any paper content, ask the user to upload the PDF or provide the paper text/abstract.
* If the user only provides the abstract, only perform an "abstract-level analysis." Do not fabricate methodology details, experiment settings, numerical results, open-source status, or conclusions that are not stated in the abstract.
* For any information that is not stated, insufficiently supported, or impossible to determine from the provided content, explicitly write "not stated in the paper" or "cannot be determined from the provided content." Do not speculate.
* Comparisons with other methods should primarily rely on the paper's baselines, related work, experimental setup, and the authors' own discussion. If domain knowledge is used as supplementary analysis, clearly mark it as "supplementary analysis based on domain background."
* The open-source status should only be judged from the paper text. If the paper does not mention code, data, model weights, or artifacts, write "not stated in the paper." Only verify externally if the user explicitly allows web access.
* Focus on the methodology, especially model structure, algorithmic pipeline, training objectives, key formulas, data flow, implementation details, and experimental validation. The introduction, related work, and conclusion should only be discussed when directly relevant to understanding the method.
* If the paper includes section numbers, figure numbers, table numbers, algorithm numbers, or equation numbers, refer to them whenever helpful so the user can verify the analysis against the original paper.
* The output should allow the user to understand the core method, experimental findings, applicable scenarios, and limitations without continuing to read the full paper.

Language and style:

* Use a professional, rigorous, and logically structured style.
* Do not give vague praise. Do not forcefully claim novelty if the contribution is weak.
* Focus on the core methodology and avoid excessive repetition of the introduction or conclusion.

The response must strictly follow the six major sections and subsections below.

---

## 1. Motivation

### 1a. Why do the authors propose this method?

Explain the background, problem setting, and driving motivation behind the proposed method.

### 1b. What are the limitations of existing methods?

Clearly identify the limitations of prior methods discussed in the paper, such as accuracy, efficiency, generalization, data dependence, computational cost, interpretability, or deployment difficulty.

If the paper does not discuss a certain limitation, state "not stated in the paper."

### 1c. What is the research hypothesis or core intuition?

Summarize the authors' key intuition in simple terms: why they believe the proposed method should work.

---

## 2. Method Design

This is the most important section and must be the most detailed.

### 2a. Method pipeline: input → processing → output

Provide a clear, step-by-step pipeline of the method.

Requirements:

1. Specify what the input is.
2. Explain what each step does.
3. Explain why each step is needed.
4. Describe the output of each step and how it is passed to the next step.
5. If the method has both training and inference phases, explain them separately.
6. If the method involves data construction, preprocessing, sampling, retrieval, annotation, augmentation, or filtering, explain these details carefully.
7. If the method uses loss functions, optimization objectives, or constraints, explain what each one optimizes.
8. If the paper does not provide implementation details for a step, explicitly write "the paper does not specify the implementation details."

### 2b. Model architecture or system modules

If the paper involves a model architecture, framework components, or system modules, explain each module separately:

1. The input and output of each module.
2. The function of each module.
3. How the modules are connected and cooperate with each other.
4. Which modules are the paper's core innovations and which are inherited from prior work.
5. If there is an architecture figure, explain the overall data flow based on that figure.

If the paper does not involve an explicit model architecture, state "there is no obvious model architecture design," and instead explain the algorithmic or system-level workflow.

### 2c. Formulas, algorithms, and key mechanisms

If the paper contains formulas, algorithms, or key mechanisms, explain them in plain language:

1. What the main variables represent.
2. What role the formula plays in the method.
3. What the formula optimizes, constrains, or measures.
4. What each algorithmic step means in practice.
5. Why the mechanism helps achieve the paper's goal.

Do not merely translate mathematical notation. Explain the practical meaning behind the formula.

---

## 3. Comparison with Other Methods

### 3a. Essential differences from existing mainstream methods

Explain how the proposed method differs from the baselines, related methods, or mainstream approaches discussed in the paper.

If this part includes additional domain background, clearly mark it as "supplementary analysis based on domain background."

### 3b. Novelty and contribution level

List the paper's innovations and assess the strength of each contribution.

You may use the following categories:

* Core contribution: the main new method, mechanism, or problem formulation.
* Secondary contribution: auxiliary modules, engineering improvements, experimental analysis, or application extensions.
* Limited contribution: components that are closer to combinations, adaptations, or engineering implementations of existing methods.

Do not overstate the contribution. If the novelty is limited, state it explicitly.

### 3c. Applicable scenarios and scope

Analyze which tasks, data conditions, model scales, deployment environments, or application scenarios the method is most suitable for.

Also explain where the method may not be suitable.

### 3d. Comparison table

Use a table to summarize the comparison between this method and other methods.

The table should contain at least the following columns:

| Method type / representative method | Core idea | Advantages | Disadvantages | Improvement made by this paper |
| ----------------------------------- | --------- | ---------- | ------------- | ------------------------------ |

If the paper does not provide enough information for a comparison item, write "not stated in the paper."

---

## 4. Experimental Results and Advantages

### 4a. How do the authors validate the method?

Describe the experimental design and setup, including:

1. Datasets or tasks used.
2. Baselines compared against.
3. Evaluation metrics.
4. Whether ablation studies are included.
5. Whether there are generalization experiments, efficiency experiments, robustness experiments, or case studies.
6. Key training and evaluation details.

If the paper does not specify some settings, explicitly write "not stated in the paper."

### 4b. Key experimental results

List the most representative numerical results and conclusions.

Requirements:

1. Prioritize key metrics from the main result tables.
2. Indicate which baselines are surpassed and on which metrics.
3. Provide concrete numbers, improvement margins, or ranking changes whenever available.
4. If the provided content does not include numerical results, do not fabricate them; only summarize the observed trend.

### 4c. Where is the advantage most obvious?

Analyze which datasets, tasks, input conditions, model scales, or experimental settings show the strongest advantage, and provide evidence from the paper.

### 4d. Limitations and potential issues

Identify limitations that are either acknowledged by the paper or implied by the provided content, including but not limited to:

1. Generalization limitations.
2. Dependence on specific data, labels, models, or assumptions.
3. Computational overhead or training cost.
4. Deployment complexity.
5. Insufficient experimental coverage.
6. Insufficient baselines.
7. Insufficient ablation studies.
8. Possible failure cases.

If the paper does not explicitly discuss limitations, cautiously analyze based on the provided content and mark the analysis as "inferred from the paper content."

---

## 5. Learning and Application

### 5a. Open-source status and key reproduction steps

State whether the paper claims to be open-source.

If the paper does not mention code, data, model weights, or artifacts, write "not stated in the paper."

If one wants to implement or reproduce the method, summarize the key steps:

1. What data needs to be prepared.
2. Which core modules need to be implemented.
3. What the training workflow is.
4. What the inference workflow is.
5. Which experiments should be reproduced to validate effectiveness.

### 5b. Implementation details and practical notes

Summarize implementation-level details that require attention, including:

1. Key hyperparameters.
2. Data preprocessing.
3. Model initialization or pretraining dependencies.
4. Training strategy.
5. Negative sampling, data augmentation, or filtering strategy.
6. Loss-function weights.
7. Batch size, learning rate, number of epochs, and other training settings.
8. Evaluation protocol.
9. Details that may affect reproducibility.

If the paper does not specify concrete parameters, write "the paper does not specify the concrete parameters."

### 5c. Can the method be transferred to other tasks?

Analyze whether the method can be transferred to other tasks.

If yes, explain:

1. Which modules can be directly reused.
2. Which modules need to be replaced or retrained.
3. What data is needed for transfer.
4. What difficulties may arise.
5. Which tasks are the most suitable transfer targets.

If this cannot be determined, write "cannot be determined from the provided content."

---

## 6. Summary

### 6a. One-sentence core idea

Summarize the core idea of the method in one concise sentence.

Requirements:

* Be direct.
* Be accurate.
* Avoid overly abstract promotional wording.

### 6b. Memorization-friendly pipeline

Provide a 3–5 step simplified pipeline.

Requirements:

* Do not use paper-specific coined terms or unexplained abbreviations.
* Avoid technical jargon whenever possible.
* Necessary technical terms may be retained, but they must be explained in plain language.
* The reader should be able to roughly understand what the method does by only reading this pipeline.
* Do not use metaphors.
* Directly describe the actual operations.

Example format:

1. Prepare the input data.
2. Extract key information.
3. Process the information with the core model.
4. Optimize the model according to the training objective.
5. Output predictions and evaluate the results.
