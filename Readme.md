# Filosofía Código's zkBenchmarking

This repository holds my personal journey through benchmarking major Zero-Knowledge projects.

**A Note:** ZK benchmarking is a multidimensial open-ended question. There’s no _"best project"_. Instead, projects may offer advantages like faster provers, or faster and cheaper verifiers, some might be application-specific and other general purpose. Moreover, ZK projects often vary in their architectural structures, developer experience and long term vision.

### A Living Work

Consider this repository as a **living work in progress**, ZK is moving fast.

### Features

- **Reproducible Benchmarks:** Each benchmark is meant to be easily reproduced through of GitHub Actions.
- **Starter Scripts:** The included scripts serve as a guide to help you get started with the tool of your choice.
- **zkVMs tests now live:** zkDSLs benchmarks coming soon™.

## Benchmarks

| Project         | Benchmark 1 (ms) | Benchmark 2 (ms) | Benchmark 3 (ms) | Average (ms) |
|-----------------|------------------|------------------|------------------|--------------|
| **SP1** | [468362ms](https://github.com/Turupawn/zkBenchmark/actions/runs/11893961301/job/33140115064#step:4:760) | TODO | TODO | 468362ms |
| **Risc0** | [24168ms](https://github.com/Turupawn/zkBenchmark/actions/runs/11910259456/job/33189284269#step:4:520) | [26720ms](https://github.com/Turupawn/zkBenchmark/actions/runs/12876481850/job/35899541921#step:4:500) | [26719ms](https://github.com/Turupawn/zkBenchmark/actions/runs/12876629345/job/35899898489) | 25869ms |
| **OpenVM** | [17462ms](https://github.com/Turupawn/zkBenchmark/actions/runs/12839295926/job/35806339304#step:4:1133) | [17485ms](https://github.com/Turupawn/zkBenchmark/actions/runs/12876480553/job/35899539095#step:4:1133) | [17432ms](https://github.com/Turupawn/zkBenchmark/actions/runs/12876628029/job/35899894923#step:4:1133) | 17460ms |
