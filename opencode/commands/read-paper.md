---
description: Read and explain a paper using the read-paper skill
---

Use the `read-paper` skill to analyze the paper or paper content provided in:

$ARGUMENTS

Parse $ARGUMENTS into:
1. source material to read, such as file references, paths, directories, or pasted paper content;
2. task-specific instructions from the user.

Follow the task-specific instructions unless they conflict with the reliability rules below.

Input handling:
- If the user provides one or more file references, read those files first.
- If the user provides a directory path, inspect it and identify the likely paper-related files before reading.
- If no usable paper content is provided, ask the user to provide a PDF, paper text, method section, experiment section, or abstract.

Output handling:
- By default, respond in the chat only.
- If the user explicitly asks to save the summary to a specific path, write the final summary to exactly that path.
- Do not choose or invent an output path.
- Do not overwrite an existing file unless the user explicitly requested overwriting.
- Do not modify the paper source files or unrelated project files.

Reliability rules:
- Do not invent missing methodology details, experiment settings, numerical results, open-source status, or conclusions.
- If information is missing, say “not stated in the paper” or “cannot be determined from the provided content.”
