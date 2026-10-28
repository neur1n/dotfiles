# ML/AI Specifications

## Method Design (3a-3c)

- Separate training and inference: inputs, learned versus fixed components,
  representations, and pretrained dependencies.
- Explain data construction, annotation, retrieval, sampling, augmentation, and
  filtering used by the method.
- Explain loss terms and weights, distinguishing the training objective from
  the evaluation metric.

## Comparison and Experimental Results (4a-5d)

- Examine dataset splits and reported controls against leakage or overlap.
- Check baseline comparability in model scale, pretraining, supervision, data
  access, tuning, and compute budgets.
- Assess ablations, repeated runs, and sensitivity; examine robustness
  and generalization across datasets, tasks, and scales.
- Include quality versus compute, memory, latency, or throughput tradeoffs.

## Learning and Application (6a-6c)

- Include model weights and configurations in the artifact inventory.
- Capture preprocessing, optimizer, batch size, learning rate, training length,
  seeds, decoding settings, and data-selection or augmentation parameters.
- Identify transfer requirements for retraining, fine-tuning, or new data.
