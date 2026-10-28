# HPC/System Specifications

## Motivation: Bottleneck Identification (2a-2c)

- Identify the bottleneck, where it occurs, and whether it is measured or
  assumed. Explain supporting profiling, breakdowns, experiments, or models.

## Method Design: Goals, Constraints, and Mechanisms (3a-3c)

- Specify the goal: runtime, throughput, tail latency, memory, energy, or cost.
  Identify changes to correctness, numerical accuracy, consistency, or
  fault-tolerance guarantees and their operating assumptions.
- Explain how computation, communication, I/O, synchronization, scheduling, or
  data movement changes to address the bottleneck, including relevant state,
  concurrency, and resource ownership.

## Comparison: Fairness and Scope (4a-4d, 5a)

- Check comparability of hardware, resource budgets, software versions, tuning,
  problem sizes, numerical precision, and stopping criteria. Explain how
  differences affect the conclusions.
- Distinguish kernel or component-level from end-to-end measurements. State
  whether initialization, preprocessing, compilation, and data transfer are
  included; a local speedup does not establish an application-level speedup.

## Experimental Results: Scaling and Measurement (5a-5d)

- Give workload sizes and node, device, process, or thread counts. Distinguish
  strong scaling (fixed total problem size) from weak scaling (fixed problem
  size per processing unit); state reference configurations and definitions of
  speedup and efficiency.
- Assess resource efficiency alongside speedup, accounting for resource growth,
  communication, synchronization, and saturation.
- Examine repeated runs, variability, warmup, cache state, and timing or
  aggregation methods. Missing reporting creates uncertainty, not proof of
  invalid measurements.
- Assess representativeness across workloads, scales, machines, and settings;
  distinguish microbenchmarks, synthetic workloads, and full applications.

## Learning and Application: Reproduction (6a-6c)

- Capture CPU/GPU, memory, interconnect, storage, OS, compiler and flags,
  libraries, process placement, thread binding, and parallelism settings.
- Include build and run instructions, scripts, traces, workload generation,
  and resource allocation; preserve measurement boundaries and correctness or
  accuracy checks in reproduction.
- Identify hardware, workload, scale, or guarantee assumptions that constrain
  transfer, and components needing adaptation or retuning.
