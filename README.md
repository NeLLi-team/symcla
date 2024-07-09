# symcla: symbiont genome classifier

## 💾 Installation

Clone the `symcla` repository:

```{shell}
git clone https://github.com/NeLLi-team/symcla.git
```

```{bash}
cd symcla/
chmod u+x symcla
```

Create `conda` environment and install requirements:

```{bash}
conda create --name symcla --file requirements.txt
```

### 💽  Setup data (run only once)

**Run inside the `symcla/` folder:**

```{shell}
conda activate symcla
```

```{shell}
./symcla setup
```

_______

## 👩🏽‍🔬 [Important!] Input data

- A directory with `faa` fasta files of query genomes with headers in the form: `><genomeid>|<proteinid>`

## 🚀 Example run

```{shell}
conda activate symcla
```

```{shell}
cd symcla/
```

### 👷🏻‍♀️  Run the classifier

**Run inside the `symcla/` folder:**

```{shell}
./symcla classify --genomedir data/test_genomes --savedir test_output --ncpus 32
```

### To get help

```{bash}
./symcla classify --help

# Usage: symcla classify [OPTIONS]
#
# ╭─ Options ──────────────────────────────────────────────────────────────────────╮
# │ --genomedir                      TEXT     [default: genomes]                   │
# │ --savedir                        TEXT     [default: output]                    │
# │ --symcla-model                   TEXT     [default: sy50]                      │
# │ --ncpus                          INTEGER  [default: 16]                        │
# │ --deltmp          --no-deltmp             [default: deltmp]                    │
# │ --help                                    Show this message and exit.          │
# ╰────────────────────────────────────────────────────────────────────────────────╯

```

### 🕺🏻 Results

Expected results from the test data:

| taxon_oid                               | completeness_UNI56 | features_gt0| features_ge20 | features_ge100 | symcla_score |
|-----------------------------------------|--------------------|-------------|---------------|----------------|--------------|
| IMGI2140918011                          | 98.214             | 396         | 291           | 128            | 0.000        |
| IMGI2645727657                          | 100.000            | 287         | 197           | 70             | -0.003       |
| IMGI651324087                           | 100.000            | 368         | 252           | 106            | -0.009       |
| IMGM3300027739_BIN74                    | 64.286             | 310         | 234           | 95             | 0.001        |
| SCISO2808607008                         | 98.214             | 406         | 276           | 124            | 2.000        |
| SDISOGCA_003484685.1                    | 83.929             | 193         | 126           | 43             | 2.000        |
| SHISO2654587767                         | 98.214             | 423         | 309           | 134            | 2.000        |
| SLISOGCF_900639865.1                    | 100.000            | 569         | 429           | 234            | 0.999        |
| SRISO640427127                          | 92.857             | 296         | 197           | 103            | 2.000        |
| SXGCA_000019745.1                       | 98.214             | 353         | 259           | 106            | 0.126        |
| SXGCA_902860225.1_Azoamicus_ciliaticola | 91.071             | 117         | 83            | 36             | 1.055        |
| SXISO642555114                          | 96.429             | 333         | 243           | 108            | 1.995        |

### 🧐 Interpretation of results:
- `completeness_UNI56`: The percentage of 56 universal bacterial and archaeal marker genes found in the genome. We do not advise to trust any results <50%. Confidence in symbiont prediction increases with UNI56 completeness.
- `features_gt01`: Number of features found with a bitscore greater than 0. Confidence in symbiont prediction increases with more featured found.
- `features_ge20`: Number of features found with a bitscore greater or equal than 20. Confidence in symbiont prediction increases with more featured found.
- `features_ge100`: Number of features found with a bitscore greater or equal than 100. Confidence in symbiont prediction increases with more featured found.
- `symcla_score`: after adjusting the classification thresholds based on thousands of experiments, we recommend the following values:
  - `symcla_score <= 0.42`: Free-living
  - `0.42 < symcla_score < 1.21`: Symbiont;Host-associated
  - `symcla_score >= 1.21`: Symbiont;Intracellular
    
🤖 *Note: by design `symcla` minimizes the rate of false positives for symbionts, at the expense of increased false negatives (i.e. some symbionts might still get a lower `symcla` score).*

